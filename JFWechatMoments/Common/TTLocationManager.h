//
//  TTLocationManager.h
//  TZH_Project
//
//  Created by 王家强 on 2017/6/29.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>


typedef void(^KSystemLocationBlock)(CLLocation *loction, NSError *error);
typedef void(^KMALocationBlock)(CLLocation *loction, NSError *error);
typedef void(^KMALocationDetailInfoBlock)(CLLocation *loction, AMapLocationReGeocode *regeocode,NSError *error);

@interface TTLocationManager : NSObject

+ (instancetype)shareInstance;

/**
 *  启动系统定位
 *
 *  @param systemLocationBlock 系统定位成功或失败回调成功
 */
- (void)startSystemLocationWithRes:(KSystemLocationBlock)systemLocationBlock;

/**
 *  启动高德地图定位
 *
 *  @param maLocationBlock 地图定位成功或失败回调成功
 */
- (void)startMALocationWithReg:(KMALocationBlock)maLocationBlock;


//获取定位详情
- (void)getAddressDetainInfo:(KMALocationDetailInfoBlock)addressDetailInfoBlock;
@end
