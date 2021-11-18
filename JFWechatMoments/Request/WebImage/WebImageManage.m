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

- (NSMutableArray *)failUrlsArray {
    if (!_failUrlsArray) {
        _failUrlsArray = [[NSMutableArray alloc] init];
    }
    return _failUrlsArray;
}
+ (WebImageManage *)shareWebImageManage {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        webImageManage = [[WebImageManage alloc] init];
    });
    return webImageManage;
}

//- (instancetype)init {
//    self = [super init];
//    if (self) {
//        _failUrls = [[NSMutableArray alloc] init];
//    }
//    return self;
//}

- (void)getImageWithURL:(NSString *)urlString downloadCompletedBlock:(DownloadCompletedBlock)completedBlock {

    if ([self.failUrlsArray containsObject:urlString]) {
        completedBlock(nil, nil, NO);
        return;
    }

    NSLog(@"进行下载");
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:30];
    [[AFImageDownloader defaultInstance] downloadImageForURLRequest:request success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull responseObject) {
        completedBlock(responseObject, nil, YES);
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        //获取图片失败之后记入数组
        if (urlString != nil && ![self.failUrlsArray containsObject:urlString]) {
            [self.failUrlsArray addObject:urlString];
        }
        completedBlock(nil, error, NO);
    }];
}
@end
