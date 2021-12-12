//
//  HDDRichTextTool.m
//  Shipper
//
//  Created by huodada on 2021/7/1.
//  Copyright © 2021 caesar. All rights reserved.
//

#import "HDDRichTextTool.h"

@implementation HDDRichTextTool


#pragma mark - 富文本设置部分字体颜色
+ (NSMutableAttributedString *)setupAttributeString:(NSString *)text rangeText:(NSString *)rangeText textColor:(UIColor *)color font:(UIFont *)font{
    NSRange hightlightTextRange = [text rangeOfString:rangeText];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:text];
    if (hightlightTextRange.length > 0) {
        [attributeStr addAttribute:NSForegroundColorAttributeName value:color range:hightlightTextRange];
        [attributeStr addAttribute:NSFontAttributeName value:font range:hightlightTextRange];
        return attributeStr;
    }else {
        return [rangeText copy];
    }
}
//设置文字左右缩进
+ (NSMutableAttributedString *)setupAttributeStrIndent:(CGFloat)indet text:(NSString *)text {
  NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
// 对齐方式
  style.alignment = NSTextAlignmentCenter;
// 首行缩进
 style.firstLineHeadIndent = indet;
// 头部缩进
  style.headIndent = indet;
// 尾部缩进
   style.tailIndent = -indet;
    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] initWithString:text attributes:@{ NSParagraphStyleAttributeName : style}];
    return attrText;
}




@end
