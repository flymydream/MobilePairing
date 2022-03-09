//
//  CMPedometerManager.h
//  JFWechatMoments
//
//  Created by hero on 2022/3/9.
//  Copyright © 2022 fanzhiying. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>


NS_ASSUME_NONNULL_BEGIN

@interface CMPedometerManager : NSObject

+ (id)shareCMPedometerManager;
// error.code 105 隐私权限被拒绝
// info.plist 添加隐私权限 Privacy - Motion Usage Description

/**
 *  从某一时间段开始，连续的采集数据
 *  当设备中的活动数据发生变更就会回调此方法
 *  此方法是在串行队列中执行
 */
- (void)queryStepsFormStartDate:(NSDate *)startDate
                    withHandler:(CMPedometerHandler)handler;
/**
 *  查询从当前时间开始的数据，连续的采集数据
 *  此方法是在串行队列中执行
 */
- (void)queryStepsFormNowDateWithHandler:(CMPedometerHandler)handler;

/**
 *  查询某一时间段的数据，时间可长达7天，
 *  此方法是在串行队列中执行
 */
- (void)queryStepsFormStartDate:(NSDate *)startDate
                         toDate:(NSDate *)endDate
                    withHandler:(CMPedometerHandler)handler;
/**
 *  查询今天的数据
 *  此方法是在串行队列中执行
*/
- (void)querySameDayStepsWithHandle:(CMPedometerHandler)handler;

@end

NS_ASSUME_NONNULL_END
