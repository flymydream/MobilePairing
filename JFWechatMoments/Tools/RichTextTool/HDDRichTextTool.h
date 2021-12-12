//
//  HDDRichTextTool.h
//  Shipper
//
//  Created by huodada on 2021/7/1.
//  Copyright © 2021 caesar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDDRichTextTool : NSObject
#pragma mark - 富文本设置部分字体颜色
+ (NSMutableAttributedString *)setupAttributeString:(NSString *)text rangeText:(NSString *)rangeText textColor:(UIColor *)color font:(UIFont *)font;
//设置文字左右缩进
+ (NSMutableAttributedString *)setupAttributeStrIndent:(CGFloat)indet text:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
