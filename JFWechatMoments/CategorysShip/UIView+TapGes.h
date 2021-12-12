//
//  UIView+TapGes.h
//  Shipper
//
//  Created by caesar on 2020/1/10.
//  Copyright © 2020 huodada. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (TapGes)
//设置view控件的点击手势
- (void)setTapActionWithBlock:(void(^)(UIGestureRecognizer *gesture))block;
//视图动画的渐显和渐隐，时长1.2s
- (void)setViewAnimantionFadeInAndOut:(CGFloat)alpha withAnimationDuration:(CGFloat)duration;
//适配单位背景，提示文字和主文字的颜色
+ (void)configUnitBC:(UIView*)bgView withPlaceColor:(UILabel *)label withMainTextColor:(UIView*)mainLabel;
@end

NS_ASSUME_NONNULL_END
