//
//  HDDCustomToastView.h
//  Driver
//
//  Created by caesar on 2020/1/17.
//  Copyright © 2020 caesar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDDCustomToastView : NSObject
//中间横向固定宽度提示条
+ (void)toastViewWithString:(NSString *)string delayTime:(CGFloat)delayTime;
+ (void)showSuccee:(NSString *)succee toView:(UIView *)view;
+ (void)showSuccee:(NSString *)succee;
+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (void)showError:(NSString *)error;
+ (void)toastMessage:(NSString *)message toView:(UIView *)view;
+ (void)toastMessage:(NSString *)message;

+(void)showMessageTitle:(NSString *)title andDelay:(NSTimeInterval)timeInt;

@end

NS_ASSUME_NONNULL_END
