//
//  UIDevice+DeviceExtension.h
//  Driver
//
//  Created by caesar on 2020/1/17.
//  Copyright © 2020 caesar. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (DeviceExtension)

/*
 获取设备描述
 */
+ (NSString *)getCurrentDeviceModelDescription;
/*
 由获取到的设备描述，来匹配设备型号
 */
+ (NSString *)getCurrentDeviceModel;

@end

NS_ASSUME_NONNULL_END
