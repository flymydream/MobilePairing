//
//  UIImageView+Web.h
//  JFWechatMoments
//

#import <UIKit/UIKit.h>

@interface UIImageView (Web)

/**
 设置网络图片

 @param urlString 图片地址
 @param placeholderImage 默认图片
 */
- (void)jf_setImageWithURL:(NSString *)urlString placeholderImage:(UIImage *)placeholderImage;

@end
