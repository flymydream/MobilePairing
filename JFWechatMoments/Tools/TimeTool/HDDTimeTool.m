//
//  HDDTimeTool.m
//  Driver
//
//  Created by caesar on 2020/1/17.
//  Copyright © 2020 caesar. All rights reserved.
//

#import "HDDTimeTool.h"

@implementation HDDTimeTool
//获取时间戳
+ (long long)getCurrentSystemDateSecondString
{
    NSDate *currentDate = [[NSDate alloc] init];
    NSTimeInterval timeInterval = [currentDate timeIntervalSince1970] * 1000;
    NSString *strTimeInterval = [NSString stringWithFormat:@"%lld", (long long)timeInterval];
    long long timeSecond = (long long)[strTimeInterval longLongValue];
    return timeSecond;
}
//格式化日期
+ (NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+ (NSString *)stringFromDateChinese:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM月dd日 HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
//将时间戳转换为时间
+ (NSString *)dateWithTimeStamp:(NSString *)stamp {
    NSTimeInterval time= [stamp doubleValue]/1000;
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *result =[dateFormatter stringFromDate:detaildate];
    return result;
}

//根据不同的时间格式，得到时间
//timestamp:时间戳
+ (NSString*)getDateStringWithTimestamp:(double)timestamp andFormaterString:(NSString*)format{
    
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    fmt.dateFormat = format;
    NSTimeInterval _interval = timestamp / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    return [fmt stringFromDate: date];
}

//将时间戳转换为时间
+ (NSDate *)dateWithTimeStampMonthAndYear:(NSString *)stamp {
    NSTimeInterval time=[stamp longLongValue]/1000;
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM月dd日 HH:mm"];
    //得到日期
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    NSDate *date=[dateFormatter dateFromString:currentDateStr];
    return date;
}

+ (NSString *)dateWithTimeStampOrderTime:(NSString *)stamp formatter:(NSString *)formatter{
    NSTimeInterval time=[stamp longLongValue]/1000;
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:formatter];
    //得到日期
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    NSDate *date = [dateFormatter dateFromString:currentDateStr];
    //NSDate转NSString
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+ (UIImage *)resizableCustomImageWithImageName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat top = image.size.height * 0.5;
    CGFloat left = image.size.width * 0.5;
    CGFloat bottom = image.size.height * 0.5;
    CGFloat right = image.size.width * 0.5;
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
    UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets];
    return newImage;
}

//根据传入的日期格式获取当前的日期格式
+ (NSString* )getCurrentDateByFormatter:(NSString *)formatter{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:formatter];
    NSString *localTime = [dateformatter stringFromDate:date];
    return localTime;
}

/**
日期格式请传入：2013-08-05 12:12:12；如果修改日期格式，比如：2013-08-05，则将[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];修改为[dateFormatter setDateFormat:@"yyyy-MM-dd"];
 */
+(int)compareDate:(NSString*)date withDate:(NSString*)anotherDate{
        int difference;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSDate *date1 = [[NSDate alloc]init];
        NSDate *date2 = [[NSDate alloc]init];
        date1 = [dateFormatter dateFromString:date];
        date2 = [dateFormatter dateFromString:anotherDate];
        NSComparisonResult result = [date1 compare:date2];
        switch (result) {
            //anotherDate比date大
            case NSOrderedAscending : difference = 1;
                break;
            //anotherDate比date小
            case NSOrderedDescending : difference = -1;
                break;
            //anotherDate=date
            case NSOrderedSame: difference = 0;
                break;
            default:NSLog(@"erorr dates %@, %@", date2, date1);
                 break;
        }
        return difference;
}
/**
根据时间字符串获取时间戳
 */
+ (NSString *)getTimeStamp:(NSString *)dateStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:dateStr];
    NSTimeInterval timeInterval = [date timeIntervalSince1970] * 1000;
    NSString *strTimeInterval = [NSString stringWithFormat:@"%lld", (long long)timeInterval];
    return strTimeInterval;
}
+(NSTimeInterval)getTimeIntervalByStartTime:(NSString *)startTime endTime:(NSString *)endTime{
//    //首先创建格式化对象
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //然后创建日期对象
    NSDate *startDate = [NSDate date:startTime WithFormat:@"yyyy-MM-dd HH:mm:ss"];;
    NSDate *endDate = [NSDate date:endTime WithFormat:@"yyyy-MM-dd HH:mm:ss"];
    //计算时间间隔（单位是秒）
    NSTimeInterval inputInterval = [endDate timeIntervalSinceDate:startDate] / 60;
    //计算天数、时、分、秒
//    int days = ((int)time)/(3600*24);
//    int hours = ((int)time)%(3600*24)/3600;
//    int minutes = ((int)time)%(3600*24)%3600/60;
//    int seconds = ((int)time)%(3600*24)%3600%60;
    return inputInterval;
}

/**将UTC日期字符串转为本地时间字符串 */
+ (NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate format:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
    //输出格式
    [dateFormatter setDateFormat:format];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}
//获取当前的年月日
+ (NSString* )getCurrentYearMonthDayString{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *localTime = [formatter stringFromDate:date];
    return localTime;
}
//根据传入的时间和格式获取时间字符串 @"yyyy-MM-dd HH:mm:ss"
+ (NSString *)getDateStringByPushDate:(NSDate *)pushDate andFormaterString:(NSString*)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    NSString *localTime = [formatter stringFromDate:pushDate];
    return localTime;
}
//获得当前时间
+ (NSString *)getCurrentlTime{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *localTime = [formatter stringFromDate:date];
    return localTime;
}
@end
