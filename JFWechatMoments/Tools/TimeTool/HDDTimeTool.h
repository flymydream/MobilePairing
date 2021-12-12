//
//  HDDTimeTool.h
//  Driver
//
//  Created by caesar on 2020/1/17.
//  Copyright © 2020 caesar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDDTimeTool : NSObject
/**
 *  获取时间戳 *1000
 *
 */
+ (long long)getCurrentSystemDateSecondString;
/**
 *  格式化日期
 */
+ (NSString *)stringFromDate:(NSDate *)date;

/**
 *  将时间戳转化为时间
 */
+ (NSString *)dateWithTimeStamp:(NSString *)stamp;
+ (NSDate *)dateWithTimeStampMonthAndYear:(NSString *)stamp;

+ (NSString *)dateWithTimeStampOrderTime:(NSString *)stamp formatter:(NSString *)formatter;

//根据传入的日期格式获取当前的日期格式
+ (NSString* )getCurrentDateByFormatter:(NSString *)formatter;

/**
 * 根据不同的时间格式，得到时间
*/
+ (NSString*)getDateStringWithTimestamp:(double)timestamp andFormaterString:(NSString*)format;


/**
比较两个日期大小
 */
+(int)compareDate:(NSString*)date withDate:(NSString*)anotherDate;
/**
根据时间字符串获取时间戳
 */
+(NSString *)getTimeStamp:(NSString *)dateStr;

/**
计算两个时间的时间间隔分钟数
 */
+(NSTimeInterval)getTimeIntervalByStartTime:(NSString *)startTime endTime:(NSString *)endTime;
/**将UTC日期字符串转为本地时间字符串 */
+ (NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate format:(NSString *)format;
//获取当前的年月日
+ (NSString* )getCurrentYearMonthDayString;
/**
*  根据传入的时间和格式获取时间字符串
*  pushDate:传入的时间
*  format:时间格式 例如： @"yyyy-MM-dd HH:mm:ss"
*/
//根据传入的时间和格式获取时间字符串
+ (NSString *)getDateStringByPushDate:(NSDate *)pushDate andFormaterString:(NSString*)format;
//获得当前时间
+ (NSString *)getCurrentlTime;

@end

NS_ASSUME_NONNULL_END
