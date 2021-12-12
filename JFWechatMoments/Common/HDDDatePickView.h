//
//  HDDDatePickView.h
//  Driver
//
//  Created by caesar on 2020/10/26.
//  Copyright © 2020 caesar. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    DatePickViewTypeYearMonthDay = 0,//年月日
    DatePickViewTypeYearMonth,//年月
    DatePickViewTypeYearMonthDayHourMinuteSeconds,//年月日时分秒
    DatePickViewTypeOther,//其他
} DatePickViewType;

NS_ASSUME_NONNULL_BEGIN

@interface HDDDatePickView : UIView
@property (nonatomic,assign)DatePickViewType datePickerType;

@property (nonatomic,strong)UIColor *themeColor;

@property (nonatomic, retain) NSDate *maxLimitDate;//限制最大时间（没有设置默认2049）
@property (nonatomic, retain) NSDate *minLimitDate;//限制最小时间（没有设置默认1970）
@property (nonatomic, retain) NSDate *scrollToDate;//滚到指定日期

@property (nonatomic,copy) void(^selectedDateCompleteBlock)(NSString *);
- (instancetype)initWithFrame:(CGRect)frame withDatePickerType:(DatePickViewType)type;
- (void)getNowDate:(NSDate *)date animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
