//
//  HDDCallCameraTool.m
//  Driver
//
//  Created by caesar on 2020/1/20.
//  Copyright © 2020 caesar. All rights reserved.
//

#import "HDDCallCameraTool.h"

@implementation HDDCallCameraTool

+ (void)callAlbumAndCameraWithMaxImagesCount:(NSInteger )imagesCount withAllowCrop:(BOOL)crop success:(void (^)(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto))succes{
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:imagesCount columnNumber:4 delegate:nil pushPhotoPickerVc:YES];
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowCrop = crop;//允许裁剪
    imagePickerVc.needCircleCrop = crop;//默认圆形裁剪
    imagePickerVc.allowTakeVideo = NO;//不需拍摄视频
    imagePickerVc.navigationBar.translucent = NO;
    if (imagesCount == 1 && !crop) {
        imagePickerVc.showSelectBtn = YES;
    }
//    imagePickerVc.naviBgColor = [UIColor whiteColor];
//    imagePickerVc.barItemTextColor = [UIColor whiteColor];
//    if (@available(iOS 13.0, *)) {
//        imagePickerVc.statusBarStyle = UIStatusBarStyleDarkContent;
//    } else {
//        imagePickerVc.statusBarStyle = UIStatusBarStyleDefault;
//    }
//    imagePickerVc.navigationBar.tintColor = [UIColor whiteColor];
//    imagePickerVc.naviTitleColor = [UIColor whiteColor];
    
    [imagePickerVc.navigationBar setBackgroundImage:ImageNamed(@"navi_bg") forBarMetrics:UIBarMetricsDefault];
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
       
        if (succes) {
            succes(photos,assets,isSelectOriginalPhoto);
        }
    }];
    [imagePickerVc setImagePickerControllerDidCancelHandle:^{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"isHiddenLoadView" object:nil];
    }];
    
    imagePickerVc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [kRootViewController presentViewController:imagePickerVc animated:YES completion:nil];
}


@end
