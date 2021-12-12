//
//  MBProgressHUD+GIF.m
//  Driver
//
//  Created by clack on 2019/6/21.
//  Copyright © 2019 huodada. All rights reserved.
//

#import "MBProgressHUD+GIF.h"

@implementation MBProgressHUD (GIF)

+ (void)showGifToView:(UIView *)view{
    //加载动画添加到window上
    if (view == nil) {
        view = (UIView*)[UIApplication sharedApplication].delegate.window;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    //使用SDWebImage 放入gif
    NSString *filepath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:@"car_loading.gif" ofType:nil];
    NSData *imageData = [NSData dataWithContentsOfFile:filepath];
    UIImage *image = [UIImage sd_imageWithGIFData:imageData];
    //自定义imageView
    UIImageView *cusImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 250, 176)];
    cusImageView.contentMode = UIViewContentModeScaleAspectFit;
    cusImageView.image = image;
    cusImageView.center = view.center;
    //设置hud模式
    hud.mode = MBProgressHUDModeCustomView;
    //设置在hud影藏时将其从SuperView上移除,自定义情况下默认为NO
    hud.removeFromSuperViewOnHide = YES;
    //设置方框view为该模式后修改颜色才有效果
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    //设置方框view背景色
    hud.bezelView.backgroundColor = USEBACKGROUNDCOLOR;
    //设置总背景view的背景色，并带有透明效果
    hud.backgroundColor = USEBACKGROUNDCOLOR;
    hud.customView = cusImageView;
}


+ (void)hideGifForView:(UIView *)view {
    if (view == nil) {
        view = (UIView*)[UIApplication sharedApplication].delegate.window;
    }
    [self hideHUDForView:view animated:YES];
}
@end
