//
//  UIImageView+Web.m
//  JFWechatMoments
//

#import "UIImageView+Web.h"
#import "WebImageManage.h"
#import "JFDownloadManager.h"

@implementation UIImageView (Web)

- (void)jf_setImageWithURL:(NSString *)urlString placeholderImage:(UIImage *)placeholderImage {
    self.image = placeholderImage;
   
    NSString *documentPath = [JFDataManager documentSaveImageFile];
    NSArray *imageArr = [urlString componentsSeparatedByString:@"/"];
    NSString *imageNameStr = [imageArr lastObject];
    NSString *imageFileStr = [documentPath stringByAppendingFormat:@"/%@",imageNameStr];

    UIImage * localImage = [UIImage imageNamed:imageFileStr];
    if (localImage) {
        self.image = localImage;
        return;
    }
    [[WebImageManage shareWebImageManage] getImageWithURL:urlString downloadCompletedBlock:^(UIImage *image, NSError *error, BOOL success) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                self.image = image;
            }
        });
    }];    
}


- (void)jf_setImageWithImageURL:(NSString *)urlString
               placeholderImage:(UIImage *)placeholderImage {
    self.image = placeholderImage;
    JFDownloadManager * downloadManager = [[JFDownloadManager alloc]init];
    //1.开始下载
    [downloadManager startDownloadImagePath:urlString];
    //2.设置下载完毕的回调
    [downloadManager downloadManagerFinishBlockHandler:^(NSString * _Nonnull path) {
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        self.image = image;
    }];
    
}




@end
