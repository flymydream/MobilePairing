//
//  UIViewController+ImagePicker.h
//  Driver
//
//  Created by caesar on 2020/3/12.
//  Copyright © 2020 caesar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ImagePickerCompletionHandler)(NSData *imageData, UIImage *image);

@interface UIViewController (ImagePicker)
@property (nonatomic, strong) UIImagePickerController *cameraPicker;

//弹出选择是相册或者是相机
- (void)pickImageWithCompletionHandler:(ImagePickerCompletionHandler)completionHandler;

- (void)pickImageWithpickImageCutImageWithImageSize:(CGSize)imageSize CompletionHandler:(ImagePickerCompletionHandler)completionHandler;

//直接获取照相机
- (void)callCamareImageWithCompletionHandler:(ImagePickerCompletionHandler)completionHandler;
//直接获取相册
- (void)callAlbumImageWithCompletionHandler:(ImagePickerCompletionHandler)completionHandler;
//调起拍照，带有来源类型
- (void)callCamareImageWithCompletionHandler:(ImagePickerCompletionHandler)completionHandler withFromType:(NSString*)fromType;
//创建水印视图
- (void)creatCameraWatermarkView:(UIView *)cameraOverlayView;
@end

NS_ASSUME_NONNULL_END
