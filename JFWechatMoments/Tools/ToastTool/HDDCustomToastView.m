//
//  HDDCustomToastView.m
//  Driver
//
//  Created by caesar on 2020/1/17.
//  Copyright © 2020 caesar. All rights reserved.
//

#import "HDDCustomToastView.h"
#import "MBProgressHUD+Message.h"

@implementation HDDCustomToastView

+ (void)toastViewWithString:(NSString *)string delayTime:(CGFloat)delayTime {

    UIView *toastWindow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [[[UIApplication sharedApplication] keyWindow] addSubview:toastWindow];
    UIView *backgroundTextView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 50, 60)];
    backgroundTextView.center = toastWindow.center;
    backgroundTextView.alpha = 0.8;
    backgroundTextView.layer.masksToBounds = YES;
    backgroundTextView.layer.cornerRadius = 5;
    backgroundTextView.backgroundColor = [UIColor blackColor];
    [toastWindow addSubview:backgroundTextView];

    UILabel *showlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, kScreenWidth - 70 , 50)];
    showlabel.text = string;
    showlabel.adjustsFontSizeToFitWidth = YES;
    showlabel.numberOfLines = 0;
    showlabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    showlabel.textAlignment = NSTextAlignmentCenter;
    showlabel.textColor = WhiteColor;
    [backgroundTextView addSubview:showlabel];
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
          [UIView animateWithDuration:0.3 animations:^{
              [toastWindow setAlpha:0];
          } completion:^(BOOL finished){
              [toastWindow removeFromSuperview];
          }];

        });

}

+ (void)showSuccee:(NSString *)succee toView:(UIView *)view {
    [MBProgressHUD showSuccess:succee toView:view];
}
+ (void)showSuccee:(NSString *)succee {
    [MBProgressHUD showSuccess:succee];
}
+ (void)showError:(NSString *)error toView:(UIView *)view {
     [MBProgressHUD showError:error toView:view];
}
+ (void)showError:(NSString *)error {
    [MBProgressHUD showError:error];
}
+ (void)toastMessage:(NSString *)message toView:(UIView *)view {
     [MBProgressHUD showMessage:message toView:view];
}
+ (void)toastMessage:(NSString *)message {
    [MBProgressHUD showMessage:message];
}


+(void)showMessageTitle:(NSString *)title andDelay:(NSTimeInterval)timeInt{
    if ([title isKindOfClass:[NSString class]]) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
          hud.mode = MBProgressHUDModeText;
          hud.detailsLabel.text = title;
          hud.bezelView.backgroundColor = [UIColor blackColor];
          //  hud.label.textColor = [UIColor whiteColor];
          hud.detailsLabel.textColor = [UIColor whiteColor];
          hud.detailsLabel.font = [UIFont systemFontOfSize:15];
          [hud hideAnimated:YES afterDelay:timeInt];
    }
}



@end
