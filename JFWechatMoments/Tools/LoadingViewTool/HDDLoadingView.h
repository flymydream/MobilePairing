//
//  HDDLoadingView.h
//  Driver
//
//  Created by caesar on 2020/1/17.
//  Copyright © 2020 caesar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDDLoadingView : UIView
//整个窗口的加载gif动画
+(void)loadingWindowView;
+(void)loadingWindowViewWithMessage:(NSString *)message;
+(void)hideLoadingWindowView;
//具体页面加载gif动画
+(void)loadingToView:(UIView *)view;
+(void)loadingToView:(UIView *)view withMessage:(NSString *)message;
+(void)hideLoadingToView:(UIView *)view;
//整个窗口的加载菊花效果
+(void)loadingWindowActivityIndicatorView;
+(void)hideLoadingActivityIndicatorWindowView;
//具体页面加载菊花效果
+(void)loadingActivityIndicatorToView:(UIView *)view;
+(void)hideLoadingActivityIndicatorToView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
