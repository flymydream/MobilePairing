//
//  HDDLocationTool.h
//  Driver
//
//  Created by caesar on 2020/11/11.
//  Copyright © 2020 caesar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
NS_ASSUME_NONNULL_BEGIN

/**
 地理位置获取之后的回调block


 @param isAuthorized 是否授权
 @param location 获取CLLocation
 @param error 定位失败时返回的信息，成功时为nil
 */
typedef void(^LocationCallBackWithCoordinateBlock) (BOOL isAuthorized,CLLocation* location,  NSError * _Nullable error);

@interface HDDLocationTool : NSObject
SingletonH
@property (nonatomic, copy)LocationCallBackWithCoordinateBlock locationCallbackBlock;


/**
 开启地理位置获取，并且传递地理位置获取成功后的回调block

 因为地理位置的获取是异步的，所以等拿到数据之后再上传
 

 @param locationCallBack 地理位置获取成功后的回调
 */
- (void)startUpdateLocationWithCoordinateCompletion:(LocationCallBackWithCoordinateBlock) locationCallBack;
/**
 开始更新定位信息。当授权完成之后，仍然使用当前定位对象时，可以使用该方法更新定位数据
 */
- (void)startUpdateLocation;

/**
  停止定位操作
 */
- (void)stopUpdateLocation;

@end

NS_ASSUME_NONNULL_END
