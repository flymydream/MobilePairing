//
//  MBProgressHUD+Message.m
//  Driver
//
//  Created by caesar on 2020/1/17.
//  Copyright © 2020 caesar. All rights reserved.
//

#import "MBProgressHUD+Message.h"

@implementation MBProgressHUD (Message)
#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *_Nullable)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = RGBACOLOR(0, 0, 0, 0.8);
    hud.contentColor = [UIColor whiteColor];
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:1];
    
}

#pragma mark- 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *_Nullable)view{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *_Nullable)view
{
    [self show:success icon:@"success.png" view:view];
}

#pragma mark - 显示一些信息
+ (void)showMessage:(NSString *)message toView:(UIView *_Nullable)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = RGBACOLOR(0, 0, 0, 0.6);
    hud.contentColor = [UIColor whiteColor];
    hud.label.text = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 1.0秒之后再消失
    [hud hideAnimated:YES afterDelay:1.0];
}

+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

+ (void)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (MBProgressHUD *)netWorkLoadingView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // 设置模式
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = RGBACOLOR(0, 0, 0, 0.6);
//    hud.bezelView.
    hud.contentColor = [UIColor whiteColor];
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}
+ (MBProgressHUD *)netWorkLoadingWindow{
   return [self netWorkLoadingView:[UIApplication sharedApplication].keyWindow];
}
+ (void)hideHUDForView:(UIView *_Nullable)view

{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [self hideHUDForView:view animated:YES];
    MBProgressHUD *hud = [self HUDForView:view];
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}
@end
