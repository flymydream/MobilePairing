//
//  MBProgressHUD+Message.h
//  Driver
//
//  Created by caesar on 2020/1/17.
//  Copyright © 2020 caesar. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (Message)
//成功与失败
+ (void)showSuccess:(NSString *)success toView:(UIView *_Nullable)view;
+ (void)showError:(NSString *)error toView:(UIView *_Nullable)view;
+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;
//提示消息
+ (void)showMessage:(NSString *)message toView:(UIView *_Nullable)view;
+ (void)showMessage:(NSString *)message;

//加载动画
+ (MBProgressHUD *)netWorkLoadingView:(UIView *_Nullable)view;
+ (MBProgressHUD *)netWorkLoadingWindow;

//隐藏
+ (void)hideHUDForView:(UIView *_Nullable)view;
+ (void)hideHUD;
@end

NS_ASSUME_NONNULL_END
