//
//  JFDownloadManager.m
//  JFWechatMoments
//
//  Created by hero on 2021/11/21.
//  Copyright © 2021 fanzhiying. All rights reserved.
//

#import "JFDownloadManager.h"
@interface JFDownloadManager ()
/**
 图片内存缓存
 */
@property (nonatomic, strong) NSCache *imageCache;
/**
 下载队列
 */
@property (nonatomic, strong) NSOperationQueue *queue;
/**
 操作缓存字典
 */
@property (nonatomic, strong) NSMutableDictionary *operationsMutableDict;


@end


@implementation JFDownloadManager

#pragma mark-懒加载

- (NSMutableDictionary*)operationsMutableDict {
    if (!_operationsMutableDict) {
        _operationsMutableDict = [NSMutableDictionary dictionary];
    }
    return _operationsMutableDict;
}

- (NSOperationQueue*)queue{
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 5;
    }
    return _queue;
}

- (NSCache*)imageCache {
    if (!_imageCache) {
        _imageCache = [[NSCache alloc] init];
    }
    return _imageCache ;
}

+ (JFDownloadManager *)shareDownloadManage {
    static JFDownloadManager *downloadManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downloadManager = [[JFDownloadManager alloc] init];
    });
    return downloadManager;
}

- (void)jf_getImageWithUrl:(NSString *)urlString placeholderImage:(UIImage *)placeholderImage completeCallback:(nullable void (^)(UIImage *picImage))completeCallback{
    //在内存中查到缓存
    UIImage *image = [self.imageCache objectForKey:urlString];
    //找到了缓存
    if (image) {
        completeCallback(image);
    } else {
        //没有找到内存缓存，查询沙盒缓存
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *fileName = [urlString lastPathComponent];
        NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
        NSData *imageData = [NSData dataWithContentsOfFile:filePath];
        if (imageData) {
            //找到了沙盒缓存
            UIImage *image = [UIImage imageWithData:imageData];
            [self.imageCache setObject:image forKey:urlString];
            completeCallback(image);
        } else {
            //开始下载
            NSBlockOperation *downloadOperation = [self.operationsMutableDict objectForKey:urlString];
            if (downloadOperation) {
                //什么都不做，因为存在下载该url的线程
            } else {
                //设置占位图片
                completeCallback(placeholderImage);
                //下载任务
                downloadOperation = [NSBlockOperation blockOperationWithBlock:^{
                    //通过url下载图片
                    NSURL *url = [NSURL URLWithString:urlString];
                    NSData *imageData = [NSData dataWithContentsOfURL:url];
                    UIImage *image = [UIImage imageWithData:imageData];
                    //没有拿到图片
                    if (image == nil) {
                        [self.operationsMutableDict removeObjectForKey:urlString];
                        
                        return;
                    }
                    //拿到图片了缓存内存缓存
                    if (url && image) {
                        [self.imageCache setObject:image forKey:url];
                    }
                    //回到主线程刷新
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        NOTIFY_POST(Nofication_RefreshTableView);
                        completeCallback(placeholderImage);
                        
                    }];
                    
                    //缓存沙盒缓存
                    [imageData writeToFile:filePath atomically:YES];
                    [self.operationsMutableDict removeObjectForKey:urlString];
                    
                }];
                //将操作添加到操作缓存中
                [self.operationsMutableDict setValue:downloadOperation forKey:urlString];
                
                //将下载任务添加到队列里
                [self.queue addOperation:downloadOperation];
            }
        }
    }

}



@end
