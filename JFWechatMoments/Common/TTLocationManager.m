//
//  TTLocationManager.m
//  TZH_Project
//
//  Created by 王家强 on 2017/6/29.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "TTLocationManager.h"

@interface TTLocationManager ()<CLLocationManagerDelegate,AMapLocationManagerDelegate>

/**
 *  定位管理
 */
@property (nonatomic, readwrite, strong) CLLocationManager *locationManager;

@property (nonatomic, readwrite, strong) AMapLocationManager *locationService;

@property (nonatomic, readwrite, copy) KSystemLocationBlock  kSystemLocationBlock;
@property (nonatomic, readwrite, copy) KMALocationBlock      kMALocationBlock;
@property (nonatomic, readwrite, copy) KMALocationDetailInfoBlock addressDetailInfoBlock;

@end

@implementation TTLocationManager

+ (instancetype)shareInstance{
    static id helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[TTLocationManager alloc]  init];
    });
    return helper;
}

#pragma mark - 苹果
/**
 *  苹果系统自带地图定位
 */
- (void)startSystemLocationWithRes:(KSystemLocationBlock)systemLocationBlock{
    self.kSystemLocationBlock = systemLocationBlock;
    
    if(!self.locationManager){
        self.locationManager =[[CLLocationManager alloc] init];
        self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        //        self.locationManager.distanceFilter=10;
        if ([UIDevice currentDevice].systemVersion.floatValue >=8) {
            [self.locationManager requestWhenInUseAuthorization];//使用程序其间允许访问位置数据（iOS8定位需要）
        }
    }
    self.locationManager.delegate=self;
    [self.locationManager startUpdatingLocation];//开启定位
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *currLocation=[locations lastObject];
    self.locationManager.delegate = nil;
    [self.locationManager stopUpdatingLocation];
    
    self.kSystemLocationBlock(currLocation, nil);
}
/**
 *定位失败，回调此方法
 */
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if ([error code]==kCLErrorDenied) {
        NSLog(@"访问被拒绝");
    }
    if ([error code]==kCLErrorLocationUnknown) {
        NSLog(@"无法获取位置信息");
    }
    self.locationManager.delegate = nil;
    [self.locationManager stopUpdatingLocation];
    
    self.kSystemLocationBlock(nil, error);
}


#pragma mark - 高德

- (void)startMALocationWithReg:(KMALocationBlock)maLocationBlock
{
    self.kMALocationBlock = maLocationBlock;
    
    self.locationService.delegate = self;
    [self.locationService startUpdatingLocation];//开启定位
}


- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    //定位错误
    NSLog(@"%s, amapLocationManager = %@, error = %@", __func__, [manager class], error);
    
    self.locationService.delegate = nil;
    [self.locationService stopUpdatingLocation];
    
    self.kMALocationBlock(nil, error);
    
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    //定位结果
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    self.locationService.delegate = nil;
    [self.locationService stopUpdatingLocation];
    
    self.kMALocationBlock(location, nil);
}

- (AMapLocationManager *)locationService{
    if(!_locationService){
        _locationService = [[AMapLocationManager alloc] init];
        _locationService.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        _locationService.delegate = self;
    }
    
    return _locationService;
}

- (void)getAddressDetainInfo:(KMALocationDetailInfoBlock)addressDetailInfoBlock{
    WEAKSELF
    [self.locationService requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        weakSelf.addressDetailInfoBlock=addressDetailInfoBlock;
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        
        NSLog(@"location:%@", location);
        
        if (regeocode)
        {
            NSLog(@"reGeocode:%@", regeocode);
        }
        if (weakSelf.addressDetailInfoBlock) {
            weakSelf.addressDetailInfoBlock(location, regeocode, error);
        }
    }];
}

@end
