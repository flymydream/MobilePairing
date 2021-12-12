//
//  HDDLocationTool.m
//  Driver
//
//  Created by caesar on 2020/11/11.
//  Copyright © 2020 caesar. All rights reserved.
//

#import "HDDLocationTool.h"
@interface HDDLocationTool ()<CLLocationManagerDelegate>

@property (nonatomic, strong)CLLocationManager *locationManager;
@property (nonatomic, strong)CLLocation *location;

@end

@implementation HDDLocationTool
SingletonM
 - (void)startUpdateLocationWithCoordinateCompletion:(LocationCallBackWithCoordinateBlock) locationCallBack {
     
    self.locationCallbackBlock = locationCallBack;
    [self startUpdateLocation];
}

- (void)startUpdateLocation {
    if ([self canUseLocation]) {
        [self.locationManager startUpdatingLocation];
    } else {
        if (self.locationCallbackBlock) {
            self.locationCallbackBlock(NO, nil, nil);
        }
    }
}
/*
  获取手机权限
 */
- (BOOL)requestLocationAuthorized {
    
    if ([CLLocationManager locationServicesEnabled]) {
        return YES;
    }else {
        return NO;
    }
}

/**
 是否可以使用定位
 
 即授权未拿到或者未定义plist文件里的授权描述
 info.plist里需要定义的两个key-value信息如下：
 <key>NSLocationAlwaysUsageDescription</key>
 <string>我们将使用你的位置为你提供就近咨询和信息服务</string>
 <key>NSLocationWhenInUseUsageDescription</key>
 <string>我们将使用你的位置为你提供就近咨询和信息服务</string>
 @return YES表示可以使用，NO表示不可以使用，
 */
- (BOOL)canUseLocation {
    
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways &&
        [CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
        if(@available(iOS 8.0,*)) {
            [self.locationManager requestWhenInUseAuthorization];
        }
        return NO;
    }
    [self.locationManager startUpdatingLocation];
    return YES;
}

#pragma mark- CLLocationManagerDelegate
/**
 授权状态变更代理回调

 @param manager 位置管理器
 @param status 状态值
 */
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSString *message = nil;
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
            [self startUpdateLocation];
            message = @"一直使用地理位置";
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [self startUpdateLocation];
            message = @"使用期间使用地理位置";
            break;
        case kCLAuthorizationStatusDenied:
            message = @"用户禁用地理位置访问服务";
            break;
        case kCLAuthorizationStatusRestricted:
            message = @"系统定位服务功能被限制";
            break;
        case kCLAuthorizationStatusNotDetermined:
            message = @"用户未决定地理位置的使用";
            break;
        default:
            break;
    }
#ifdef DEBUG
    NSLog(@"地理位置授权状态变化：%@", message);
#endif
    
}
/*
 获取到了定位数据
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    _location = [locations lastObject];
#ifdef DEBUG
    NSLog(@"经纬度可能会获取多次");
    NSLog(@"纬度 = %f", _location.coordinate.latitude);
    NSLog(@"经度  = %f", _location.coordinate.longitude);
#endif
    [self.locationManager stopUpdatingLocation];
    if (self.locationCallbackBlock) {
        self.locationCallbackBlock(YES, _location, nil);
    }
}
/*
*停止定位
*/
- (void)stopUpdateLocation{
    [self.locationManager stopUpdatingLocation];
    _locationManager = nil;
}
/*
 *定位失败
 */
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
#ifdef DEBUG
    NSLog(@"定位失败 error: %@", [error description]);
#endif
    if (self.locationCallbackBlock) {
        self.locationCallbackBlock(YES, NULL, error);
    }
}

#pragma mark- getter
- (CLLocationManager *)locationManager {
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc]init];;
        _locationManager.delegate = self;
        ///期望的精准度。有五个选项值。我们使用的是最好精度
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        ///刷新距离
        _locationManager.distanceFilter = 10;
        if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0) {
            [_locationManager requestWhenInUseAuthorization];//使用程序其间允许访问位置数据（iOS8定位需要）
        }
    }
    return _locationManager;
}

@end
