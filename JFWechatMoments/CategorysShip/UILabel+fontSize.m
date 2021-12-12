//
//  UILabel+fontSize.m
//  Driver
//
//  Created by caesar on 2020/3/14.
//  Copyright © 2020 caesar. All rights reserved.
//

#import "UILabel+fontSize.h"
#import <objc/runtime.h>

@implementation UILabel (fontSize)
//只执行一次的方法，在这个地方 替换方法
+ (void)load{
//保证线程安全
static dispatch_once_t onceToken;
dispatch_once(&onceToken, ^{
    Class class = [self class];
    //拿到系统方法
    SEL orignalSel3 = @selector(awakeFromNib);
    Method orignalM3 = class_getInstanceMethod(class, orignalSel3);
    SEL swizzledSel3 = @selector(testFontAwakeFromNib);
    Method swizzledM3 = class_getInstanceMethod(class, swizzledSel3);
    BOOL didAddMethod3 = class_addMethod(class, orignalSel3, method_getImplementation(swizzledM3), method_getTypeEncoding(swizzledM3));
    if (didAddMethod3) {
        class_replaceMethod(class, swizzledSel3, method_getImplementation(orignalM3), method_getTypeEncoding(orignalM3));
    }else{
        method_exchangeImplementations(orignalM3, swizzledM3);
    }
});
}
#pragma mark -使用的替换方法
- (void)testFontAwakeFromNib{
    [self testFontAwakeFromNib];

    self.font = [UIFont systemFontOfSize:self.font.pointSize];
}
//根据字符串，字体，计算UILabel的高度
+(CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}
//根据字符串，字体，高度，计算UILabel的宽度
+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}




@end
