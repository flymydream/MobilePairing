//
//  WebImageManage.m
//  JFWechatMoments
//

#import "WebImageManage.h"
#import "AFImageDownloader.h"

static WebImageManage *webImageManage;

@interface WebImageManage ()

/**
 保存获取失败的图片地址，避免重复获取
 */
@property(nonatomic, strong) NSMutableArray *failUrlsArray;

@end

@implementation WebImageManage
+ (WebImageManage *)shareWebImageManage {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        webImageManage = [[WebImageManage alloc] init];
    });
    return webImageManage;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _failUrlsArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)getImageWithURL:(NSString *)urlString downloadCompletedBlock:(DownloadCompletedBlock)completedBlock {
    if ([self.failUrlsArray containsObject:urlString]) {
        completedBlock(nil, nil, NO);
        return;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //如果本地有图片直接加载 没有去下载
        if (urlString.length > 0) {
            NSLog(@"进行下载");
            NSURL *url = [NSURL URLWithString:urlString];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:30];
            
            [[AFImageDownloader defaultInstance] downloadImageForURLRequest:request success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull responseObject) {
                
                NSString *documentPath = [JFDataManager documentSaveImageFile];
                NSArray *imageArr = [urlString componentsSeparatedByString:@"/"];
                NSString *imageNameStr = [imageArr lastObject];
                if (![[JFFileMannager shareInstance] fileIsExist:documentPath]) {
                    [[JFFileMannager shareInstance] creatDownloadFile];
                }

                [self saveImage:responseObject withFileName:imageNameStr inDirectory:documentPath];
                completedBlock(responseObject, nil, YES);
            } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                //获取图片失败之后记入数组
                if (urlString != nil && ![self.failUrlsArray containsObject:urlString]) {
                    [self.failUrlsArray addObject:urlString];
                }
                completedBlock(nil, error, NO);
            }];
        }

    });
    
    
}

//将图片存储到沙盒目录下存储成jpg形式
-(void)saveImage:(UIImage *)image withFileName:(NSString *)imageName inDirectory:(NSString *)directoryPath {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:imageName] options:NSAtomicWrite error:nil];
    });
}
@end
