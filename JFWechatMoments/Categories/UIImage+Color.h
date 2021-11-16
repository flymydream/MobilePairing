//
//  UIImage+Color.h
//  JFWechatMoments
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

/**
 创建单色图片

 @param color 期望颜色
 @return 单色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
