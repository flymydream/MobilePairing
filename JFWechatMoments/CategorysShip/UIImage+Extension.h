//
//  UIImage+Extension.h
//  MyTool
//
//  Created by lp-mac on 16/5/31.
//  Copyright © 2016年 lp-mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/** 返回一张不超过屏幕尺寸的 image */
+ (UIImage *)imageSizeWithScreenImage:(UIImage *)image;

///**
// 将图片处理成一张圆形的图片
// */
- (UIImage *)circleImage;

/* On-screen-renderring绘制UIImage矩形圆角 */
- (UIImage *)imageWithCornerRadius:(CGFloat)radius ofSize:(CGSize)size;

- (UIImage *)resetImageWithColor:(UIColor *)color;

/**
 *  根据图片颜色返回一个颜色
 */

//将一张图片变成指定大小
+ (UIImage *)scaleToSize:(UIImage *)image size:(CGSize)size;

//根据颜色返回一张图片
+ (UIImage *)imageWithColor:(UIColor *)color;

//根据屏幕获取图片的大小
+ (NSURL *)getScreenAutoPhotoSizeWithUR:(NSString *)url;


//通过文字获取图片
+ (UIImage *)hp_imageWithColor:(UIColor *)color
                          size:(CGSize)size
                          text:(NSString *)text
                textAttributes:(NSDictionary *)textAttributes
                      circular:(BOOL)isCircular;

//合成图片
+ (UIImage *)combine:(UIImage *)oneImage otherImage:(UIImage *)otherImage;

//压缩图片到指定大小
+ (NSData *)resetSizeOfImageData:(UIImage *)sourceImage maxSize:(NSInteger)maxSize;
//压缩图片尺寸
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;
/**
 加半透明水印
 @param useImage 需要加水印的图片
 @returns 加好水印的图片
 */
- (UIImage *)addImage:(UIImage *)useImage addMsakImage:(UIImage *)maskImage msakRect:(CGRect)rect;
/**
 *  添加文字水印到图片
 *
 *  @param str   文字
 *  @param image 图片
 *  @param rect 文字位于图片的位置 使用rect 比 point  可以轻易处理自适应高度
 *  @param font  文字字体
 *  @param color 文字颜色
 *
 *  @return 返回添加好水印的图片
 */
- ( UIImage *)createShareImage:( NSString *)str image:(UIImage *)image andRect:(CGRect )rect andFont:(UIFont *)font andColor:(UIColor *)color;

/**
 生成二维码(中间有小图片)
 qrString：字符串
 centerImage：二维码中间的image对象
 */
+ (UIImage *)createImgQRCodeWithString:(NSString *)qrString centerImage:(UIImage *)centerImage;
/** 将CIImage转换成UIImage 并放大(内部转换使用)*/
+ (UIImage *)imageWithImageSize:(CGFloat)size withCIIImage:(CIImage *)ciiImage;
@end
