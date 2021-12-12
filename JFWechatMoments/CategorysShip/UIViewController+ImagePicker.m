//
//  UIViewController+ImagePicker.m
//  Driver
//
//  Created by caesar on 2020/3/12.
//  Copyright © 2020 caesar. All rights reserved.
//

#import "UIViewController+ImagePicker.h"

#import <objc/runtime.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/PHPhotoLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import "HDDCameraWatermarkView.h"

static void *kImagePickerCompletionHandlerKey = @"kImagePickerCompletionHandlerKey";
static void *kCameraPickerKey = @"kCameraPickerKey";
static void *kPhotoLibraryPickerKey = @"kPhotoLibraryPickerKey";
static void *kImageSizeKey = @"kimageSizeKey";
static void *isCut =  @"isCut"; //截取
static void *kFromType = @"kFromType";


@interface UIViewController ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *cameraPicker;
@property (nonatomic, strong) UIImagePickerController *photoLibraryPicker;
@property (nonatomic, copy) ImagePickerCompletionHandler completionHandler;

@property (nonatomic, assign) BOOL isCutImageBool;
@property (nonatomic, assign) CGSize imageSize;
@property (nonatomic, strong) NSString *fromType;

@end

@implementation UIViewController (ImagePicker)

- (void)pickImageWithCompletionHandler:(ImagePickerCompletionHandler)completionHandler {
    self.completionHandler = completionHandler;
    [self presentChoseActionSheet];
}

- (void)pickImageWithpickImageCutImageWithImageSize:(CGSize)imageSize CompletionHandler:(ImagePickerCompletionHandler)completionHandler
{
    self.completionHandler = completionHandler;
    self.isCutImageBool = YES;
    self.imageSize = imageSize;
    [self presentChoseActionSheet];
}

- (void)setUpCameraPickControllerIsEdit:(BOOL)isEdit {
    self.cameraPicker = [[UIImagePickerController alloc] init];
    self.cameraPicker.allowsEditing = isEdit; //拍照选去是否可以截取，和代理中的获取截取后的方法配合使用
    self.cameraPicker.delegate = self;
    self.cameraPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
}

- (void)setUpPhotoPickControllerIsEdit:(BOOL)isEdit {
    self.photoLibraryPicker = [[UIImagePickerController alloc] init];
    self.photoLibraryPicker.allowsEditing = isEdit; // 相册选取是否截图
    self.photoLibraryPicker.delegate = self;
    //去掉毛玻璃效果 否则在ios11 下 全局设置了UIScrollViewContentInsetAdjustmentNever 导致导航栏遮住了内容视图
    self.photoLibraryPicker.navigationBar.translucent = NO;
    self.photoLibraryPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
}

- (void)presentChoseActionSheet{
    
    //先创建好 不然调用的时候 第一次创建很慢 有2秒的延迟
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        //判断相机可用
        [self setUpCameraPickControllerIsEdit:self.isCutImageBool];
    }
    [self setUpPhotoPickControllerIsEdit:self.isCutImageBool];
    
    UIAlertController * actionController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction * takePhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
    
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (self.presentedViewController == nil){
                        [self presentViewController: self.cameraPicker
                                           animated: NO
                                         completion: nil];
                    }
               });
            }
            else {
                UIAlertController * noticeAlertController = [UIAlertController alertControllerWithTitle:@"未开启相机权限，请到设置界面开启" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"现在就去" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //跳转到设置界面
                    if (@available(iOS 10.0, *)) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:^(BOOL success) {}];
                    } else {
                       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                    }
                }];
                [noticeAlertController addAction:cancelAction];
                [noticeAlertController addAction:okAction];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                    [self presentViewController:noticeAlertController animated:YES completion:nil];
                });
            }
        }];
    }];
    
    UIAlertAction * choseFromAlbumAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //判断相册权限
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusNotDetermined || status == PHAuthorizationStatusAuthorized) {
                //未知的   第一次访问
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:self.photoLibraryPicker animated:YES completion:nil];
    });
            }
            else {
                UIAlertController * noticeAlertController = [UIAlertController alertControllerWithTitle:@"未开启相册权限，请到设置界面开启" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"现在就去" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //跳转到设置界面
                    if (@available(iOS 10.0, *)) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:^(BOOL success) {}];
                    } else {
                       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                    }
                }];
                
                [noticeAlertController addAction:cancelAction];
                [noticeAlertController addAction:okAction];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:noticeAlertController animated:YES completion:nil];
            });
                
            }
        }];

    }];
    
    [actionController addAction:cancelAction];
    [actionController addAction:takePhotoAction];
    [actionController addAction:choseFromAlbumAction];
    
    [self presentViewController:actionController animated:YES completion:^{
    }];
}

//直接获取相机
- (void)callCamareImageWithCompletionHandler:(ImagePickerCompletionHandler)completionHandler{
    
   self.completionHandler = completionHandler;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        //判断相机可用
        [self setUpCameraPickControllerIsEdit:self.isCutImageBool];
    }
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 if (self.presentedViewController == nil) {
                     [self presentViewController:self.cameraPicker animated:YES completion:nil];
                 }
             });
            }else {
                UIAlertController * noticeAlertController = [UIAlertController alertControllerWithTitle:@"未开启相机权限，请到设置界面开启" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"现在就去" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //跳转到设置界面
                    if (@available(iOS 10.0, *)) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:^(BOOL success) {}];
                    } else {
                       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                    }
                }];
                [noticeAlertController addAction:cancelAction];
                [noticeAlertController addAction:okAction];
            dispatch_async(dispatch_get_main_queue(), ^{
                    [self presentViewController:noticeAlertController animated:YES completion:nil];
                });
            }
        }];
}


//直接获取相册
- (void)callAlbumImageWithCompletionHandler:(ImagePickerCompletionHandler)completionHandler{
    self.completionHandler = completionHandler;
    //判断相册权限
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusNotDetermined || status == PHAuthorizationStatusAuthorized) {
                //未知的   第一次访问
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (self.presentedViewController == nil){
                        [self presentViewController: self.photoLibraryPicker
                                           animated: NO
                                         completion: nil];
                    }
                });
            }else {
                UIAlertController * noticeAlertController = [UIAlertController alertControllerWithTitle:@"未开启相册权限，请到设置界面开启" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"现在就去" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //跳转到设置界面
                    if (@available(iOS 10.0, *)) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:^(BOOL success) {}];
                    } else {
                       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                    }
                }];
                
                [noticeAlertController addAction:cancelAction];
                [noticeAlertController addAction:okAction];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:noticeAlertController animated:YES completion:nil];
            });
            }
        }];
}
//调起相机，带有来源
- (void)callCamareImageWithCompletionHandler:(ImagePickerCompletionHandler)completionHandler withFromType:(NSString *)fromType{
    [self callCamareImageWithCompletionHandler:completionHandler];
    self.fromType = fromType;
}

#pragma mark <UIImagePickerControllerDelegate>
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *editedimage = info[@"UIImagePickerControllerOriginalImage"];
    CGSize imageSize = CGSizeMake(1500, 1200); //4032 3024
    if (self.imageSize.height>0) {
        imageSize = self.imageSize;
    }
    editedimage = [UIImage reSizeImage:editedimage toSize:imageSize];
    NSData *imageData = UIImageJPEGRepresentation(editedimage, 0.5);
    UIImage *image = [UIImage imageWithData:imageData];
    
    self.completionHandler(imageData, image);
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"isHiddenLoadView" object:nil];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(nonnull UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.fromType.length > 0) {
        [self creatCameraWatermarkView:viewController.view];
    }
}
#pragma mark ============创建水印视图===========
- (void)creatCameraWatermarkView:(UIView *)cameraOverlayView{
    
    HDDCameraWatermarkView *waterView = [[HDDCameraWatermarkView alloc]initWithFrame:cameraOverlayView.bounds withImagePickerType:self.fromType];
    waterView.tag = 4444;
    [cameraOverlayView addSubview:waterView];
}
#pragma mark - setters & getters

- (void)setCompletionHandler:(ImagePickerCompletionHandler)completionHandler {
    objc_setAssociatedObject(self, kImagePickerCompletionHandlerKey, completionHandler, OBJC_ASSOCIATION_COPY);
}

- (ImagePickerCompletionHandler)completionHandler {
    return objc_getAssociatedObject(self, kImagePickerCompletionHandlerKey);
}

- (void)setCameraPicker:(UIImagePickerController *)cameraPicker {
    objc_setAssociatedObject(self, kCameraPickerKey, cameraPicker, OBJC_ASSOCIATION_RETAIN);
}

- (UIImagePickerController *)cameraPicker {
    return objc_getAssociatedObject(self, kCameraPickerKey);;
}

- (void)setPhotoLibraryPicker:(UIImagePickerController *)photoLibraryPicker {
    objc_setAssociatedObject(self, kPhotoLibraryPickerKey, photoLibraryPicker, OBJC_ASSOCIATION_RETAIN);
}

- (UIImagePickerController *)photoLibraryPicker {
    return objc_getAssociatedObject(self, kPhotoLibraryPickerKey);
}

- (void)setIsCutImageBool:(BOOL)isCutImageBool {
    return objc_setAssociatedObject(self, isCut, @(isCutImageBool), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)isCutImageBool {
    return [objc_getAssociatedObject(self, isCut) boolValue];
}

- (void)setImageSize:(CGSize)imageSize {
    return objc_setAssociatedObject(self, kImageSizeKey, [NSValue valueWithCGSize:imageSize], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGSize)imageSize {
    NSValue * value = objc_getAssociatedObject(self, kImageSizeKey);
    return  value.CGSizeValue;
}

- (void)setFromType:(NSString *)fromType{
    
    return objc_setAssociatedObject(self, kFromType, fromType, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)fromType{
    return objc_getAssociatedObject(self, kFromType);
}

@end
