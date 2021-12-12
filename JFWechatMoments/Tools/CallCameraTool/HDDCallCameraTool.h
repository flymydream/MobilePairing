//
//  HDDCallCameraTool.h
//  Driver
//
//  Created by caesar on 2020/1/20.
//  Copyright © 2020 caesar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ImagePickerCompletionHandler)(NSData *imageData, UIImage *image);

@interface HDDCallCameraTool : NSObject

/**
  调用相机或者图片的方法
  @param imagesCount 最大选择的图片数量
  @param crop 允许裁剪
 */
+ (void)callAlbumAndCameraWithMaxImagesCount:(NSInteger )imagesCount withAllowCrop:(BOOL)crop success:(void (^)(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto))success;



@end

NS_ASSUME_NONNULL_END
