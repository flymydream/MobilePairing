//
//  NSDate+TimeStamp.h
//  Driver
//
//  Created by caesar on 2020/7/2.
//  Copyright © 2020 caesar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (TimeStamp)
//将时间戳转换为NSDate类型
- (NSDate *)getDateTimeFromMilliSeconds:(long long) miliSeconds;
//将NSDate类型的时间转换为时间戳
- (long long)getDateTimeTOMilliSeconds:(NSDate *)datetime;
//比较两个日期大小 -1 0 1
+ (int)compareDate:(NSString*)startDate withDate:(NSString*)endDate;

@end

NS_ASSUME_NONNULL_END
