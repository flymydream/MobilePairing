//
//  HDDLoadingView.m
//  Driver
//
//  Created by caesar on 2020/1/17.
//  Copyright © 2020 caesar. All rights reserved.
//

#import "HDDLoadingView.h"
#import "MBProgressHUD+Message.h"

@implementation HDDLoadingView

#pragma mark ============加载gif动画===========
+(void)loadingWindowView{
     dispatch_async(dispatch_get_main_queue(), ^{
        [self creatHudCustomViewWithView:kKeyWindow withMessage:@"加载中..."];
     });
}
+(void)loadingWindowViewWithMessage:(NSString *)message{
    if(message.length == 0) {message = @"加载中...";}
    [self creatHudCustomViewWithView:kKeyWindow withMessage:message];
}
+(void)hideLoadingWindowView {
    UIView *customView = [kKeyWindow viewWithTag:9527];
    [customView removeFromSuperview];
}
+(void)loadingToView:(UIView *)view {

    [self creatHudCustomViewWithView:view withMessage:@"加载中..."];
}
+(void)loadingToView:(UIView *)view withMessage:(NSString *)message{
    if(message.length == 0){ message = @"加载中...";}
    [self creatHudCustomViewWithView:view withMessage:message];
}
+(void)hideLoadingToView:(UIView *)view {
    
    UIView *customView = [view viewWithTag:9527];
    [customView removeFromSuperview];
}
+ (void)creatHudCustomViewWithView:(UIView *)view withMessage:(NSString *)message{
    dispatch_async(dispatch_get_main_queue(), ^{
           UIView *customView = [view viewWithTag:9527];
            if (customView) {
                return;
            }
            UIView *bgView = [[UIView alloc]init];
            bgView.tag = 9527;
            bgView.backgroundColor = RGBACOLOR(235,235,235,0.3);
            [view addSubview:bgView];
            [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(view);
            }];
            
            UIView *hudCustomView = [[UIView alloc]init];
            hudCustomView.backgroundColor = RGBACOLOR(0, 0, 0, 0.6);
            hudCustomView.layer.masksToBounds = YES;
            hudCustomView.layer.cornerRadius = 5;
            hudCustomView.center = view.center;
            [bgView addSubview:hudCustomView];
            [hudCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(bgView.mas_centerX);
                make.centerY.equalTo(bgView.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(80, 80));
            }];
            
            //使用SDWebImage 放入gif
            NSString *filepath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:@"loading.gif" ofType:nil];
            NSData *imageData = [NSData dataWithContentsOfFile:filepath];
            UIImage *image = [UIImage sd_imageWithGIFData:imageData];
            //自定义imageView
             UIImageView *cusImageView = [[UIImageView alloc]initWithFrame:CGRectMake(25, 15, 30,30)];
             cusImageView.contentMode = UIViewContentModeScaleAspectFit;
             cusImageView.image = image;
            [hudCustomView addSubview:cusImageView];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, 56, 20)];
            label.text = message;
            label.font = FontSize(12);
            label.textColor = WhiteColor;
            [hudCustomView addSubview:label];
    });
 
}

#pragma mark ============菊花效果===========
//整个窗口的加载菊花效果
+(void)loadingWindowActivityIndicatorView{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [MBProgressHUD netWorkLoadingWindow];
}
+(void)hideLoadingActivityIndicatorWindowView{
     [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
     [MBProgressHUD hideHUD];
}
//具体页面加载菊花效果
+(void)loadingActivityIndicatorToView:(UIView *)view{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [MBProgressHUD netWorkLoadingView:view];
}
+(void)hideLoadingActivityIndicatorToView:(UIView *)view{
     [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
     [MBProgressHUD hideHUDForView:view];
}

@end
