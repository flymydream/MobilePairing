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
//    [[WebImageManage shareWebImageManage] getImageWithURL:urlString downloadCompletedBlock:^(UIImage *image, NSError *error, BOOL success) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (success) {
//                self.image = image;
//            }
//        });
//    }];    
}


- (void)jf_setImageWithUrl:(NSString *)urlString placeholderImage:(UIImage *)placeholderImage {
    self.image = placeholderImage;
    [[JFDownloadManager shareDownloadManage] jf_getImageWithUrl:urlString placeholderImage:placeholderImage completeCallback:^(UIImage * _Nonnull picImage) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (picImage) {
                self.image = picImage;
            }
        });
    }];
}



@end
