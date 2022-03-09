//
//  CMPedometerManager.m
//  JFWechatMoments
//
//  Created by hero on 2022/3/9.
//  Copyright © 2022 fanzhiying. All rights reserved.
//

#import "CMPedometerManager.h"

@interface CMPedometerManager ()
@property (nonatomic, strong) CMPedometer *pedometer;

@end

@implementation CMPedometerManager
static id manager;
static CMPedometer *pedometer;

+ (id)shareCMPedometerManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[[self class] alloc] init];
        pedometer = [[CMPedometer alloc]init];
    });
    return manager;
}

- (void)queryStepsFormStartDate:(NSDate *)startDate withHandler:(CMPedometerHandler)handler{
    if ([CMPedometer isStepCountingAvailable]) {
        [pedometer stopPedometerUpdates];
        [pedometer startPedometerUpdatesFromDate:startDate withHandler:handler];
    }else{
        NSLog(@"记步功能不可用");
    }
}
- (void)queryStepsFormNowDateWithHandler:(CMPedometerHandler)handler{
    [self queryStepsFormStartDate:[NSDate date] withHandler:handler];
}

- (void)queryStepsFormStartDate:(NSDate *)startDate
                         toDate:(NSDate *)endDate
                    withHandler:(CMPedometerHandler)handler{
    if ([CMPedometer isStepCountingAvailable]) {
        [pedometer queryPedometerDataFromDate:startDate toDate:endDate withHandler:handler];
    }else{
        NSLog(@"记步功能不可用");
    }
}
- (void)querySameDayStepsWithHandle:(CMPedometerHandler)handler{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    NSDate *startDate = [calendar dateFromComponents:components];
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    [self queryStepsFormStartDate:startDate toDate:endDate withHandler:handler];
    
}
