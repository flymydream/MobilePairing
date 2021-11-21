//
//  JFDownloadManager.m
//  JFWechatMoments
//
//  Created by hero on 2021/11/21.
//  Copyright © 2021 fanzhiying. All rights reserved.
//

#import "JFDownloadManager.h"
#import "JFFileMannager.h"
#import "JFDataManager.h"

@interface JFDownloadManager()<NSURLSessionDownloadDelegate>

/**需要下载图片的url*/
@property (nonatomic, copy)NSString *imagePath;
/**请求图片的url*/
@property (nonatomic, strong)NSURL *imageURL;
/**转型后的图片名称*/
@property (nonatomic, copy)NSString *imageName;
/**沙盒路径*/
@property (nonatomic, copy)NSString *documentPath;
/**存储当前下载的数据对象*/
@property (nonatomic, copy)NSData *currentData;

/**自定义的活动下载对象*/
@property (nonatomic, strong)NSURLSession *session;
/**下任务对象*/
@property (nonatomic, strong)NSURLSessionDownloadTask *downloadTask;

/**下载完成后的回调*/
@property (nonatomic, copy)DownloadManagerFinishBlock finishBlockHandle;
/**下载过程中的回调*/
@property (nonatomic, copy)DownloadManagerProgressBlock progressBlockHandle;

@end


@implementation JFDownloadManager


- (instancetype)init {
    if (self = [super init]) {
        //初始化session
        self.session =  [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
        self.currentData = nil;
    }
    return self;
}
-(void)downloadManagerFinishBlockHandler:(DownloadManagerFinishBlock)downloadManagerFinishBlockHandler{
    _finishBlockHandle = downloadManagerFinishBlockHandler;
}
-(void)downManagerProgressBlockHandler:(DownloadManagerProgressBlock)downloadManagerProgressBlockHandler{
    _progressBlockHandle = downloadManagerProgressBlockHandler;
}
/**开始下载图片的方法*/
- (void)startDownloadImagePath:(NSString *)imagepath {
    //1.先暂停下载
    [self pauseDownload];
    //2.根据url检测本地是否存在图片
    if ([[JFFileMannager shareInstance] fileIsExist:imagepath]) {
//        NSString *path = [JFDataManager documentImageFileAppendBase64File:imagepath];
        
        NSArray *imageArr = [imagepath componentsSeparatedByString:@"/"];
        NSString *imageName = [imageArr lastObject];
        NSString *pathStr = [[JFDataManager documentSaveImageFile] stringByAppendingFormat:@"/%@",imageName];
       
        //主线程回调
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.finishBlockHandle) {
                self.finishBlockHandle(pathStr);
            }
        });
        return;
    }
    //3.本地不存在图片，开始下载图片
    _imagePath = imagepath;
    //4.创建请求图片的url
    NSURL *downURL = [NSURL URLWithString:_imagePath];
    //5.开始根据url请求图片
    [self startDownloadImageUrl:downURL];
}

#pragma mark-根据URL开始下载图片
- (void)startDownloadImageUrl:(NSURL *)imageURL{
    //1.获取本地数据
    self.currentData = JFValueWithKey(imageURL.absoluteString);
    //2.如果断点数据存在继续下载，不存在重新下载
    if (self.currentData) {
        [self resumeDownload];
    } else {
        _imageURL = imageURL;
        //创建请求对象
        NSURLRequest *request = [NSURLRequest requestWithURL:_imageURL];
        //获取下载对象
        self.downloadTask = [self.session downloadTaskWithRequest:request];
        //开始请求
        [self.downloadTask resume];
    }
}


#pragma mark-暂停下载
-(void)pauseDownload{
    [self.downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        //如果下载url存在 把未下载完成的图片存储起来
        if(self.imageURL){
            JFSetValueforKey(resumeData, self.imageName);
        }
    }];
    //将下载任务置为nil
    self.downloadTask = nil;
}
#pragma mark-继续下载
- (void)resumeDownload {
    //恢复下载任务
    self.downloadTask = [self.session downloadTaskWithResumeData:self.currentData];
    [self.downloadTask resume];
}
#pragma mark-NSURLSessionDownloadDelegate
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    //1.获得存储位置的路径字符串
    NSString *path = [JFDataManager documentImagefileAppendFile:self.imageName];
    
    //2.创建相关文件夹
    [[JFFileMannager shareInstance] creatDownloadFile];
    //3.获取创建下载到的路径url
    NSURL *url = [NSURL URLWithString:path];
    //4.获取文件管理者
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //5.存到文件
    [fileManager moveItemAtURL:location toURL:url error:nil];
    
    //6.删除UserDefault中的缓存数据
    JFRemoveWithKey(self.imageName);
    //7.主线程回调
    dispatch_async(dispatch_get_main_queue(), ^{
        //传回路径
        if(self.finishBlockHandle){
            self.finishBlockHandle(path);
        }
    });
}
#pragma mark - Image Name Base64
-(NSString *)imageName{
    return [JFDataManager imageNameForBase64Handle:_imageURL.absoluteString];
}

@end
