//
//  NSDate+TimeStamp.m
//  Driver
//
//  Created by caesar on 2020/7/2.
//  Copyright © 2020 caesar. All rights reserved.
//

#import "NSDate+TimeStamp.h"

@implementation NSDate (TimeStamp)

//将时间戳转换为NSDate类型
- (NSDate *)getDateTimeFromMilliSeconds:(long long) miliSeconds{

    NSTimeInterval tempMilli = miliSeconds;

    NSTimeInterval seconds = tempMilli/1000.0;//这里的.0一定要加上，不然除下来的数据会被截断导致时间不一致

    NSLog(@"传入的时间戳=%f",seconds);

    return [NSDate dateWithTimeIntervalSince1970:seconds];
}

//将NSDate类型的时间转换为时间戳,从1970/1/1开始
- (long long)getDateTimeTOMilliSeconds:(NSDate *)datetime{

    NSTimeInterval interval = [datetime timeIntervalSince1970];

    NSLog(@"转换的时间戳=%f",interval);

    long long totalMilliseconds = interval*1000 ;

    NSLog(@"totalMilliseconds=%llu",totalMilliseconds);

    return totalMilliseconds;

}
//比较两个日期大小
+ (int)compareDate:(NSString*)startDate withDate:(NSString*)endDate{
    
    int comparisonResult;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date1 = [[NSDate alloc] init];
    NSDate *date2 = [[NSDate alloc] init];
    date1 = [formatter dateFromString:startDate];
    date2 = [formatter dateFromString:endDate];
    NSComparisonResult result = [date1 compare:date2];
//    NSLog(@"result==%ld",(long)result);
    switch (result)
    {
            //date02比date01大
        case NSOrderedAscending:
            comparisonResult = 1;
            break;
            //date02比date01小
        case NSOrderedDescending:
            comparisonResult = -1;
            break;
            //date02=date01
        case NSOrderedSame:
            comparisonResult = 0;
            break;
        default:
            NSLog(@"erorr dates %@, %@", date1, date2);
            break;
    }
    return comparisonResult;
}



@end
