//
//  UILabel+fontSize.h
//  Driver
//
//  Created by caesar on 2020/3/14.
//  Copyright © 2020 caesar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (fontSize)
//根据字符串，字体，计算UILabel的高度
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font;

//根据字符串，字体，高度，计算UILabel的宽度
+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;


@end

NS_ASSUME_NONNULL_END
