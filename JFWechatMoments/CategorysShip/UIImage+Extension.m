//
//  UIImage+Extension.m
//  MyTool
//
//  Created by lp-mac on 16/5/31.
//  Copyright © 2016年 lp-mac. All rights reserved.
//

#import "UIImage+Extension.h"

#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@implementation UIImage (Extension)
/// 返回一张不超过屏幕尺寸的 image
+ (UIImage *)imageSizeWithScreenImage:(UIImage *)image {
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    CGFloat screenWidth = kScreenWidth;
    CGFloat screenHeight = kScreenHeight;
    
    if (imageWidth <= screenWidth && imageHeight <= screenHeight) {
        return image;
    }
    
    CGFloat max = MAX(imageWidth, imageHeight);
    CGFloat scale = max / (screenHeight * 2.0);
    
    CGSize size = CGSizeMake(imageWidth / scale, imageHeight / scale);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)circleImage{
    //NO代表透明
    UIGraphicsBeginImageContextWithOptions(self.size,NO,0.0);
    
    //获得上下文控制器
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    //裁剪
    CGContextClip(ctx);
    
    //将图片画上去
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 * On-screen-renderring绘制UIImage矩形圆角
 */

- (UIImage *)imageWithCornerRadius:(CGFloat)radius ofSize:(CGSize)size{
    /* 当前UIImage的可见绘制区域 */
    CGRect rect = (CGRect){0.f,0.f,size};
    /* 创建基于位图的上下文 */
    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    /* 在当前位图上下文添加圆角绘制路径 */
    CGContextAddPath(UIGraphicsGetCurrentContext(), [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    /* 当前绘制路径和原绘制路径相交得到最终裁剪绘制路径 */
    CGContextClip(UIGraphicsGetCurrentContext());
    /* 绘制 */
    [self drawInRect:rect];
    /* 取得裁剪后的image */
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    /* 关闭当前位图上下文 */
    UIGraphicsEndImageContext();
    return image;
}

//将一张图片变成指定大小
+ (UIImage *)scaleToSize:(UIImage *)image size:(CGSize)size{
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

//根据颜色返回一张图片
+ (UIImage *)imageWithColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)resetImageWithColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

//根据屏幕获取图片的大小
+ (NSURL *)getScreenAutoPhotoSizeWithUR:(NSString *)url{
    if (kScreenWidth <= 320) {
        
        return [NSURL URLWithString:[NSString stringWithFormat:@"%@&imageView2/1/w/300/h/300",url]];
        
    }else if (kScreenWidth > 320 && kScreenWidth <= 375){
        
        return [NSURL URLWithString:[NSString stringWithFormat:@"%@&imageView2/1/w/600/h/600",url]];
    }else if (kScreenWidth > 375 && kScreenWidth <= 414){
        
        return [NSURL URLWithString:[NSString stringWithFormat:@"%@&imageView2/1/w/900/h/900",url]];
    }else{
        return [NSURL URLWithString:[NSString stringWithFormat:@"%@&imageView2/1/w/1280/h/1280",url]];
    }
}
//压缩图片尺寸
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}

/**
 绘制图片
 
 @param color 背景色
 @param size 大小
 @param text 文字
 @param textAttributes 字体设置
 @param isCircular 是否圆形
 @return 图片
 */
+ (UIImage *)hp_imageWithColor:(UIColor *)color
                          size:(CGSize)size
                          text:(NSString *)text
                textAttributes:(NSDictionary *)textAttributes
                      circular:(BOOL)isCircular
{
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // circular
    if (isCircular) {
        CGPathRef path = CGPathCreateWithEllipseInRect(rect, NULL);
        CGContextAddPath(context, path);
        CGContextClip(context);
        CGPathRelease(path);
    }
    
    // color
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    // text
    CGSize textSize = [text sizeWithAttributes:textAttributes];
    [text drawInRect:CGRectMake((size.width - textSize.width) / 2, (size.height - textSize.height) / 2, textSize.width, textSize.height) withAttributes:textAttributes];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark 合并图片（竖着合并，以第一张图片的宽度为主）
+ (UIImage *)combine:(UIImage *)oneImage otherImage:(UIImage *)otherImage {
    //计算画布大小
    CGFloat width = oneImage.size.width;
    CGFloat height = oneImage.size.height + otherImage.size.height;
    CGSize resultSize = CGSizeMake(width, height);
    UIGraphicsBeginImageContext(resultSize);
    
    //放第一个图片
    CGRect oneRect = CGRectMake(0, 0, resultSize.width, oneImage.size.height);
    [oneImage drawInRect:oneRect];
    
    //放第二个图片
    CGRect otherRect = CGRectMake(0, oneRect.size.height, resultSize.width, otherImage.size.height);
    [otherImage drawInRect:otherRect];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

#pragma mark - 图片压缩
+ (NSData *)resetSizeOfImageData:(UIImage *)sourceImage maxSize:(NSInteger)maxSize {
    //先判断当前质量是否满足要求，不满足再进行压缩
    __block NSData *finallImageData = UIImageJPEGRepresentation(sourceImage,1.0);
    NSUInteger sizeOrigin   = finallImageData.length;
    NSUInteger sizeOriginKB = sizeOrigin / 1000;
    
    if (sizeOriginKB <= maxSize) {
        return finallImageData;
    }
    
    //获取原图片宽高比
    CGFloat sourceImageAspectRatio = sourceImage.size.width/sourceImage.size.height;
    //先调整分辨率
    CGSize defaultSize = CGSizeMake(1024, 1024/sourceImageAspectRatio);
    UIImage *newImage = [self newSizeImage:defaultSize image:sourceImage];
    
    finallImageData = UIImageJPEGRepresentation(newImage,1.0);
    
    //保存压缩系数
    NSMutableArray *compressionQualityArr = [NSMutableArray array];
    CGFloat avg   = 1.0/250;
    CGFloat value = avg;
    for (int i = 250; i >= 1; i--) {
        value = i*avg;
        [compressionQualityArr addObject:@(value)];
    }
    
    /*
     调整大小
     说明：压缩系数数组compressionQualityArr是从大到小存储。
     */
    //思路：使用二分法搜索
    finallImageData = [self halfFuntion:compressionQualityArr image:newImage sourceData:finallImageData maxSize:maxSize];
    //如果还是未能压缩到指定大小，则进行降分辨率
    while (finallImageData.length == 0) {
        //每次降100分辨率
        CGFloat reduceWidth = 100.0;
        CGFloat reduceHeight = 100.0/sourceImageAspectRatio;
        if (defaultSize.width-reduceWidth <= 0 || defaultSize.height-reduceHeight <= 0) {
            break;
        }
        defaultSize = CGSizeMake(defaultSize.width-reduceWidth, defaultSize.height-reduceHeight);
        UIImage *image = [self newSizeImage:defaultSize
                                      image:[UIImage imageWithData:UIImageJPEGRepresentation(newImage,[[compressionQualityArr lastObject] floatValue])]];
        finallImageData = [self halfFuntion:compressionQualityArr image:image sourceData:UIImageJPEGRepresentation(image,1.0) maxSize:maxSize];
    }
    return finallImageData;
}

#pragma mark 调整图片分辨率/尺寸（等比例缩放）
+ (UIImage *)newSizeImage:(CGSize)size image:(UIImage *)sourceImage {
    CGSize newSize = CGSizeMake(sourceImage.size.width, sourceImage.size.height);
    
    CGFloat tempHeight = newSize.height / size.height;
    CGFloat tempWidth = newSize.width / size.width;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempWidth, sourceImage.size.height / tempWidth);
    } else if (tempHeight > 1.0 && tempWidth < tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempHeight, sourceImage.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [sourceImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
#pragma mark 二分法
+ (NSData *)halfFuntion:(NSArray *)arr image:(UIImage *)image sourceData:(NSData *)finallImageData maxSize:(NSInteger)maxSize {
    NSData *tempData = [NSData data];
    NSUInteger start = 0;
    NSUInteger end = arr.count - 1;
    NSUInteger index = 0;
    
    NSUInteger difference = NSIntegerMax;
    while(start <= end) {
        index = start + (end - start)/2;
        
        finallImageData = UIImageJPEGRepresentation(image,[arr[index] floatValue]);
        
        NSUInteger sizeOrigin = finallImageData.length;
        NSUInteger sizeOriginKB = sizeOrigin / 1024;
//        NSLog(@"当前降到的质量：%ld", (unsigned long)sizeOriginKB);
//        NSLog(@"\nstart：%zd\nend：%zd\nindex：%zd\n压缩系数：%lf", start, end, (unsigned long)index, [arr[index] floatValue]);
        
        if (sizeOriginKB > maxSize) {
            start = index + 1;
        } else if (sizeOriginKB < maxSize) {
            if (maxSize-sizeOriginKB < difference) {
                difference = maxSize-sizeOriginKB;
                tempData = finallImageData;
            }
            if (index<=0) {
                break;
            }
            end = index - 1;
        } else {
            break;
        }
    }
    return tempData;
}
//加半透明水印
- (UIImage *)addImage:(UIImage *)useImage addMsakImage:(UIImage *)maskImage msakRect:(CGRect)rect
{
    UIGraphicsBeginImageContext(useImage.size);
    [useImage drawInRect:CGRectMake(0, 0, useImage.size.width, useImage.size.height)];
    
    //四个参数为水印图片的位置
    [maskImage drawInRect:rect];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}
//添加文字水印到图片
- ( UIImage *)createShareImage:( NSString *)str image:(UIImage *)image andRect:(CGRect )rect andFont:(UIFont *)font andColor:(UIColor *)color;

{
    CGSize size= CGSizeMake (image.size.width, image.size.height); // 画布大小

    UIGraphicsBeginImageContextWithOptions (size, NO , 0.0 );

    [image drawAtPoint : CGPointMake ( 0 , 0 )];

    // 获得一个位图图形上下文

    CGContextRef context= UIGraphicsGetCurrentContext ();

    CGContextDrawPath (context, kCGPathStroke );
    //判定是横屏还是竖屏
    if (image.size.width < image.size.height) {
        font = [UIFont systemFontOfSize:30];
    }else {
        font =  [UIFont systemFontOfSize:20];
    }
    //计算文字所占的size,文字居中显示在画布上
    CGSize sizeText = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName :font, NSForegroundColorAttributeName : color } context:nil].size;
    
    // 画 打败了多少用户
    [str drawInRect :CGRectMake(10, image.size.height - sizeText.height - 20,image.size.width, image.size.height) withAttributes : @{ NSFontAttributeName :font, NSForegroundColorAttributeName :color } ];
    
    // 返回绘制的新图形
    UIImage *newImage= UIGraphicsGetImageFromCurrentImageContext ();

    UIGraphicsEndImageContext ();
    
    return newImage;
}

/**

 生成二维码(中间有小图片)
 qrString：所需字符串
 centerImage：二维码中间的image对象
 */
+ (UIImage *)createImgQRCodeWithString:(NSString *)qrString centerImage:(UIImage *)centerImage{
    // 创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 恢复滤镜的默认属性
    [filter setDefaults];
    // 将字符串转换成 NSdata
    NSData *dataString = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    // 设置过滤器的输入值, KVC赋值
    [filter setValue:dataString forKey:@"inputMessage"];
    // 获得滤镜输出的图像
    CIImage *outImage = [filter outputImage];
    // 图片小于(27,27),我们需要放大
    outImage = [outImage imageByApplyingTransform:CGAffineTransformMakeScale(20, 20)];
    // 将CIImage类型转成UIImage类型
    UIImage *startImage = [UIImage imageWithCIImage:outImage];
    // 开启绘图, 获取图形上下文
    UIGraphicsBeginImageContext(startImage.size);
    // 把二维码图片画上去 (这里是以图形上下文, 左上角为(0,0)点
    [startImage drawInRect:CGRectMake(0, 0, startImage.size.width, startImage.size.height)];
    // 再把小图片画上去
    CGFloat icon_imageW = 400;
    CGFloat icon_imageH = icon_imageW;
    CGFloat icon_imageX = (startImage.size.width - icon_imageW) * 0.5;
    CGFloat icon_imageY = (startImage.size.height - icon_imageH) * 0.5;
    [centerImage drawInRect:CGRectMake(icon_imageX, icon_imageY, icon_imageW, icon_imageH)];
    // 获取当前画得的这张图片
    UIImage *qrImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    //返回二维码图像
    return qrImage;

}
/** 将CIImage转换成UIImage 并放大(内部转换使用)*/
+ (UIImage *)imageWithImageSize:(CGFloat)size withCIIImage:(CIImage *)ciiImage{
    CGRect extent = CGRectIntegral(ciiImage.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:ciiImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}
@end
