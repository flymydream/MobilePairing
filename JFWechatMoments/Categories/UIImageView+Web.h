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


/**
 *  根据url设置网络图片
 *
 *  @param urlString              网络图片的url
 *  @param placeholderImage 下载未完成时的占位图
 */
- (void)jf_setImageWithImageURL:(NSString *)urlString
          placeholderImage:(UIImage *)placeholderImage;





@end
