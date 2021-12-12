//
//  HDDUploadImageAlertView.h
//  Shipper
//
//  Created by caesar on 2021/3/31.
//  Copyright © 2021 caesar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDDUploadImageAlertView : UIView
@property (nonatomic,copy) void(^selectedImageBlock)(BOOL isSuccess,NSDictionary *dict);
@property (nonatomic, weak) UIViewController *parentVc;
@property (nonatomic, strong) NSString *imageType;//图片的类型
+ (instancetype)defaultUploadAlertView;
@end

NS_ASSUME_NONNULL_END
