//
//  UIView+TapGes.m
//  Shipper
//
//  Created by caesar on 2020/1/10.
//  Copyright © 2020 huodada. All rights reserved.
//

#import "UIView+TapGes.h"
#import <objc/runtime.h>

static char kLAActionHandlerTapGestureKey;
static char kLAActionHandlerTapBlockKey;

@implementation UIView (TapGes)
//运行时动态添加方法
- (void)setTapActionWithBlock:(void(^)(UIGestureRecognizer *gesture))block{
    
    //运行时获取点击对象
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kLAActionHandlerTapGestureKey);
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleActionForTapGesture:)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:gesture];
        
        //绑定gesture
        objc_setAssociatedObject(self, &kLAActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    //绑定一下block
    objc_setAssociatedObject(self, &kLAActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)handleActionForTapGesture:(UIGestureRecognizer *)gesture{
    
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        //取出上面绑定的block
        void (^block)(UIGestureRecognizer *) = objc_getAssociatedObject(self, &kLAActionHandlerTapBlockKey);
        if (block) {
            block(gesture);
        }
    }
}
//视图动画的渐显和渐隐
- (void)setViewAnimantionFadeInAndOut:(CGFloat)alpha withAnimationDuration:(CGFloat)duration{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:ctx];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
     [UIView setAnimationDuration:duration];
    [self setAlpha:alpha];
    [UIView commitAnimations];
}
//适配单位背景，提示文字和主文字的颜色
+ (void)configUnitBC:(UIView*)bgView withPlaceColor:(UILabel *)label withMainTextColor:(UIView*)mainLabel{
    bgView.backgroundColor = UnitBGColor;
    label.textColor  = SubtitleTextColor;
    if ([mainLabel isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)mainLabel;
        label.textColor = MainTextColor;
    }else {
        UITextField *label = (UITextField *)mainLabel;
        label.textColor = MainTextColor;
    }
}
@end
