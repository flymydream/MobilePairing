//
//  HDDDatePickView.m
//  Driver
//
//  Created by caesar on 2020/10/26.
//  Copyright © 2020 caesar. All rights reserved.
//

#import "HDDDatePickView.h"
#import "UIView+Extension.h"

//#define MAXYEAR 2021
//#define MINYEAR 2018
#define kPickerSize self.datePicker.frame.size

@interface HDDDatePickView ()<UIPickerViewDelegate,UIPickerViewDataSource> {
    //日期存储数组
    NSMutableArray *_yearArray;
    NSMutableArray *_monthArray;
    NSMutableArray *_dayArray;
    NSMutableArray *_hourArray;
    NSMutableArray *_minuteArray;
    NSMutableArray *_secondsArray;
    
    //记录时间
    NSInteger _MAXYAER;
    NSInteger _MINYEAR;
    
    NSString *_dateFormatter;
    //记录位置
    NSInteger yearIndex;
    NSInteger monthIndex;
    NSInteger dayIndex;
    NSInteger hourIndex;
    NSInteger minuteIndex;
    NSInteger secondsIndex;
    
    NSInteger preRow;
    
    NSDate *_startDate;

}
@property (nonatomic, retain) NSDate *systemDate;//系统时间

@property (nonatomic,strong)UIPickerView *datePicker;

@end

@implementation HDDDatePickView


- (instancetype)initWithFrame:(CGRect)frame withDatePickerType:(DatePickViewType)type{
    
    self = [super initWithFrame:frame];
    if (self) {
        _datePickerType = type;
        [self setupUI];
        [self defaultConfig];
    }
    return self;
}

- (void)setupUI{
    _dateFormatter = @"yyyy-MM-dd";
    self.systemDate = [NSDate date];
    NSDate *date = self.systemDate;
    _MAXYAER = date.year + 1;
    _MINYEAR = date.year - 2;
    
    [self addSubview:self.datePicker];
}

-(void)defaultConfig {
    
    if (!_scrollToDate) {
        _scrollToDate = self.systemDate;
    }
   
    //循环滚动时需要用到
    preRow = (self.scrollToDate.year-_MINYEAR)*12+self.scrollToDate.month-1;
    
    //设置年月日时分数据
    _yearArray = [self setArray:_yearArray];
    _monthArray = [self setArray:_monthArray];
    _dayArray = [self setArray:_dayArray];
    _hourArray = [self setArray:_hourArray];
    _minuteArray = [self setArray:_minuteArray];
    _secondsArray = [self setArray:_secondsArray];
    
    
    NSDate *date = self.systemDate;
    [self getCurrentMonthWith:NSStringFormat(@"%ld",date.year)];
    [self getCurrentHourMinuteSecondsWithDate:date];
    for (NSInteger i=_MINYEAR; i<_MAXYAER; i++) {
        NSString *num = [NSString stringWithFormat:@"%ld",(long)i];
        [_yearArray addObject:num];
    }
    
    //最大限制
    if (!self.maxLimitDate) {
        self.maxLimitDate = [NSDate date:@"2049-12-31 23:59:59" WithFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    //最小限制
    if (!self.minLimitDate) {
        self.minLimitDate = [NSDate dateWithTimeIntervalSince1970:0];
    }
}
- (NSMutableArray *)setArray:(id)mutableArray
{
    if (mutableArray)
        [mutableArray removeAllObjects];
    else
        mutableArray = [NSMutableArray array];
    return mutableArray;
}
#pragma mark - UIPickerViewDelegate,UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    switch (self.datePickerType) {
        case DatePickViewTypeYearMonthDay:
            [self addLabelWithName:@[@"年",@"月",@"日"]];
            return 3;
        case DatePickViewTypeYearMonth:
            [self addLabelWithName:@[@"年",@"月"]];
            return 2;
        case DatePickViewTypeYearMonthDayHourMinuteSeconds:
            [self addLabelWithName:@[@"年",@"月",@"日",@"时",@"分",@"秒"]];
            return 6;
        default:
            return 0;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray *numberArr = [self getNumberOfRowsInComponent];
    return [numberArr[component] integerValue];
}

-(void)addLabelWithName:(NSArray *)nameArr {
    for (id subView in self.subviews) {
        if ([subView isKindOfClass:[UILabel class]]) {
            [subView removeFromSuperview];
        }
    }
    for (int i=0; i<nameArr.count; i++) {
        CGFloat labelX = kPickerSize.width/(nameArr.count*2)+15+kPickerSize.width/nameArr.count*i;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(labelX, self.frame.size.height/2-15/2.0, 15, 15)];
        label.text = nameArr[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = self.themeColor;
        label.backgroundColor = [UIColor clearColor];
        [self addSubview:label];
    }
}

-(NSArray *)getNumberOfRowsInComponent {
    
    NSInteger yearNum = _yearArray.count;
    NSInteger monthNum = _monthArray.count;
    NSInteger dayNum = [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
    NSInteger hourNum = _hourArray.count;
    NSInteger minuteNUm = _minuteArray.count;
    NSInteger secondNum = _secondsArray.count;
    
    switch (self.datePickerType) {
        case DatePickViewTypeYearMonthDay:
            return @[@(yearNum),@(monthNum),@(dayNum)];
            break;
        case DatePickViewTypeYearMonth:
            return @[@(yearNum),@(monthNum)];
            break;
        case DatePickViewTypeYearMonthDayHourMinuteSeconds:
            return @[@(yearNum),@(monthNum),@(dayNum),@(hourNum),@(minuteNUm),@(secondNum)];
            break;
        default:
            return @[];
            break;
    }
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *customLabel = (UILabel *)view;
    if (!customLabel) {
        customLabel = [[UILabel alloc] init];
        customLabel.textAlignment = NSTextAlignmentCenter;
        [customLabel setFont:[UIFont systemFontOfSize:17]];
    }
    NSString *title;
    
    switch (self.datePickerType) {
        case DatePickViewTypeYearMonthDay:
            if (component==0) {
                title = _yearArray[row];
            }
            if (component==1) {
                title = _monthArray[row];
            }
            if (component==2) {
                title = _dayArray[row];
            }
            break;
        case DatePickViewTypeYearMonth:
            if (component==0) {
                title = _yearArray[row];
            }
            if (component==1) {
                title = _monthArray[row];
            }
            break;
        case DatePickViewTypeYearMonthDayHourMinuteSeconds:
            if (component==0) {
                title = _yearArray[row];
            }
            if (component==1) {
                title = _monthArray[row];
            }
            if (component==2) {
                title = _dayArray[row];
            }
            if (component==3) {
                title = _hourArray[row];
            }
            if (component==4) {
                title = _minuteArray[row];
            }
            if (component==5) {
                title = _secondsArray[row];
            }
            break;
        default:
            title = @"";
            break;
    }
    
    customLabel.text = title;
    customLabel.textColor = self.themeColor;
    return customLabel;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        [self getCurrentMonthWith:_yearArray[row]];
    }
    switch (self.datePickerType) {
        case DatePickViewTypeYearMonthDay:{
            
            if (component == 0) {
                yearIndex = row;
            }
            if (component == 1) {
                monthIndex = row;
            }
            if (component == 2) {
                dayIndex = row;
            }
            if (component == 0 || component == 1){
                [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
                if (_dayArray.count-1<dayIndex) {
                    dayIndex = _dayArray.count-1;
                }
                
            }
        }
            break;
        case DatePickViewTypeYearMonth:{
            
            if (component == 0) {
                yearIndex = row;
            }
            if (component == 1) {
                monthIndex = row;
            }
            if (component == 0 || component == 1){
                [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
            }
        }
            break;
        case DatePickViewTypeYearMonthDayHourMinuteSeconds:{
            
            if (component == 0) {
                yearIndex = row;
            }
            if (component == 1) {
                monthIndex = row;
            }
            if (component == 2) {
                dayIndex = row;
            }
            if (component == 3) {
                hourIndex = row;
            }
            if (component == 4) {
                minuteIndex = row;
            }
            if (component == 5) {
                secondsIndex = row;
            }
            if (component == 0 || component == 1){
                [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
                if (_dayArray.count-1<dayIndex) {
                    dayIndex = _dayArray.count-1;
                }
            }
           NSString *dateStr = [NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@",_yearArray[yearIndex],_monthArray[monthIndex],_dayArray[dayIndex],_hourArray[hourIndex],_minuteArray[minuteIndex],_secondsArray[secondsIndex]];
            NSDate *date = [NSDate date:dateStr WithFormat:@"yyyy-MM-dd HH:mm:ss"];
            [self getCurrentHourMinuteSecondsWithDate:date];
        }
            break;
        default:
            break;
    }
    
    [pickerView reloadAllComponents];
    
    NSString *dateStr;
    NSDate *selectDate;
    if (self.datePickerType == DatePickViewTypeYearMonthDay) {
       dateStr = [NSString stringWithFormat:@"%@-%@-%@",_yearArray[yearIndex],_monthArray[monthIndex],_dayArray[dayIndex]];
        self.scrollToDate = [NSDate date:dateStr WithFormat:@"yyyy-MM-dd"];
        selectDate = self.scrollToDate;
    }else if (self.datePickerType == DatePickViewTypeYearMonth){
         dateStr = [NSString stringWithFormat:@"%@-%@",_yearArray[yearIndex],_monthArray[monthIndex]];
        self.scrollToDate = [NSDate date:dateStr WithFormat:@"yyyy-MM"];
        selectDate = self.scrollToDate;
    }else if (self.datePickerType == DatePickViewTypeYearMonthDayHourMinuteSeconds) {
        dateStr = [NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@",_yearArray[yearIndex],_monthArray[monthIndex],_dayArray[dayIndex],_hourArray[hourIndex],_minuteArray[minuteIndex],_secondsArray[secondsIndex]];
        self.scrollToDate = [NSDate date:dateStr WithFormat:@"yyyy-MM-dd HH:mm:ss"];
         selectDate = self.scrollToDate;
     }
    
    if ([self.scrollToDate compare:self.minLimitDate] == NSOrderedAscending) {
        self.scrollToDate = self.minLimitDate;
        [self getNowDate:self.minLimitDate animated:YES];
    }else if ([self.scrollToDate compare:self.maxLimitDate] == NSOrderedDescending){
        self.scrollToDate = self.maxLimitDate;
        [self getNowDate:self.maxLimitDate animated:YES];
    }
    
    _startDate = self.scrollToDate;
    if ([selectDate compare:self.scrollToDate] != NSOrderedDescending) {
        if (self.selectedDateCompleteBlock) {
            self.selectedDateCompleteBlock(dateStr);
        }
    }else{
        NSDate *date = self.systemDate;
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM"];
        NSString *localTime = [formatter stringFromDate:date];
        NSString *dayStr = self.datePickerType == DatePickViewTypeYearMonth ? localTime : [HDDTimeTool getCurrentYearMonthDayString];
        if (self.selectedDateCompleteBlock) {
            self.selectedDateCompleteBlock(dayStr);
        }
    }
}

//滚动到指定的时间位置
- (void)getNowDate:(NSDate *)date animated:(BOOL)animated
{
    if (!date) {
        date = self.systemDate;
    }
    [self getCurrentMonthWith:NSStringFormat(@"%ld",date.year)];
    [self DaysfromYear:date.year andMonth:date.month];
    [self getCurrentHourMinuteSecondsWithDate:date];
    
    yearIndex = date.year-_MINYEAR;
    monthIndex = date.month-1;
    dayIndex = date.day-1;
    hourIndex = [NSDate compareDate:[date stringWithFormat:@"YYYY-MM-dd HH:mm:ss"] withDate:[self.systemDate stringWithFormat:@"YYYY-MM-dd HH:mm:ss"]] == 1 ? date.hour : self.systemDate.hour;
    minuteIndex = [NSDate compareDate:[date stringWithFormat:@"YYYY-MM-dd HH:mm:ss"] withDate:[self.systemDate stringWithFormat:@"YYYY-MM-dd HH:mm:ss"]] == 1 ? date.minute : self.systemDate.minute;
    secondsIndex = [NSDate compareDate:[date stringWithFormat:@"YYYY-MM-dd HH:mm:ss"] withDate:[self.systemDate stringWithFormat:@"YYYY-MM-dd HH:mm:ss"]] == 1 ? date.seconds : self.systemDate.seconds;
    
    //循环滚动时需要用到
    preRow = (self.scrollToDate.year-_MINYEAR)*12+self.scrollToDate.month-1;
    
    NSArray *indexArray;
    if (self.datePickerType == DatePickViewTypeYearMonthDay){
        indexArray = @[
            @(yearIndex),@(monthIndex),@(dayIndex)];
    }else if (self.datePickerType == DatePickViewTypeYearMonth){
        indexArray = @[@(yearIndex),@(monthIndex)];
    }else if (self.datePickerType == DatePickViewTypeYearMonthDayHourMinuteSeconds){
        indexArray = @[
            @(yearIndex),@(monthIndex),@(dayIndex),@(hourIndex),@(minuteIndex),@(secondsIndex)];
    }
    
    [self.datePicker reloadAllComponents];
    
    for (int i=0; i<indexArray.count; i++) {
//        if ((self.datePickerType == DatePickViewTypeYearMonthDay)&& i==0) {
//            NSInteger mIndex = [indexArray[i] integerValue]+(12*(self.scrollToDate.year - _MINYEAR));
//            [self.datePicker selectRow:mIndex inComponent:i animated:animated];
//        }else{
            [self.datePicker selectRow:[indexArray[i] integerValue] inComponent:i animated:animated];
//        }
    }
}

- (void)yearChange:(NSInteger)row {
    
    monthIndex = row%12;
    
    //年份状态变化
    if (row-preRow <12 && row-preRow>0 && [_monthArray[monthIndex] integerValue] < [_monthArray[preRow%12] integerValue]) {
        yearIndex ++;
    } else if(preRow-row <12 && preRow-row > 0 && [_monthArray[monthIndex] integerValue] > [_monthArray[preRow%12] integerValue]) {
        yearIndex --;
    }else {
        NSInteger interval = (row-preRow)/12;
        yearIndex += interval;
    }
    
//    self.showYearView.text = _yearArray[yearIndex];
    
    preRow = row;
}

#pragma mark - tools
//获取当前月份
- (void)getCurrentMonthWith:(NSString *)curentYear{
    NSDate *date = self.systemDate;
    if (![curentYear isEqualToString:NSStringFormat(@"%ld",(long)date.year)]) {
        if (_monthArray.count == 12) {
            return;
        }
    }
    [_monthArray removeAllObjects];
    for (int i=0; i<13; i++) {
        NSString *num = [NSString stringWithFormat:@"%02d",i];
        if (i>0){
            if ([curentYear isEqualToString:NSStringFormat(@"%ld",(long)date.year)]) {
                if (i<=date.month) {
                    [_monthArray addObject:num];
                }
            }else{
                [_monthArray addObject:num];
            }
        }
    }
    if (_monthArray.count-1<monthIndex) {
        monthIndex = _monthArray.count-1;
    }
    
}
//通过年月求每月天数
- (NSInteger)DaysfromYear:(NSInteger)year andMonth:(NSInteger)month
{
    NSInteger num_year  = year;
    NSInteger num_month = month;
    NSDate *date = self.systemDate;
    if (num_month == date.month && num_year == date.year) {
        [self setdayArray:date.day];
         return date.day;
    }
    BOOL isrunNian = num_year%4==0 ? (num_year%100==0? (num_year%400==0?YES:NO):YES):NO;
     switch (num_month) {
       case 1:case 3:case 5:case 7:case 8:case 10:case 12:{
             [self setdayArray:31];
             return 31;
       }
       case 4:case 6:case 9:case 11:{
           [self setdayArray:30];
             return 30;
       }
       case 2:{
           if (isrunNian) {
               [self setdayArray:29];
               return 29;
           }else{
               [self setdayArray:28];
               return 28;
           }
       }
       default:
           break;
   }
    return 0;
}
//获取当前的时分秒
- (void)getCurrentHourMinuteSecondsWithDate:(NSDate *)currentDate{
    [_hourArray removeAllObjects];
    [_minuteArray removeAllObjects];
    [_secondsArray removeAllObjects];
    
    NSDate *date = self.systemDate;
    //当前时间大于传入的
    //时间相等的话
    if ([NSDate compareDate:[date stringWithFormat:@"YYYY-MM-dd HH:mm:ss"] withDate:[currentDate stringWithFormat:@"YYYY-MM-dd HH:mm:ss"]] != -1){
        NSLog(@"传入时间大于或者等于当前时间");
        for (int i=0; i<=date.hour; i++) {
            NSString *num = [NSString stringWithFormat:@"%02d",i];
            [_hourArray addObject:num];
        }
        for (int i=0; i<=date.minute; i++) {
            NSString *num = [NSString stringWithFormat:@"%02d",i];
            [_minuteArray addObject:num];
        }
        for (int i=0; i<=date.seconds; i++) {
            NSString *num = [NSString stringWithFormat:@"%02d",i];
            [_secondsArray addObject:num];
        }
    }else {
        NSLog(@"传入时间小于等于当前时间");
        //传入的大于当前时间
        for (int i=0; i<24; i++) {
            NSString *num = [NSString stringWithFormat:@"%02d",i];
            if (date.year == currentDate.year && date.month == currentDate.month && date.day == currentDate.day) {
                if (i<=date.hour) {
                    [_hourArray addObject:num];
                }
            }else{
                [_hourArray addObject:num];
            }
        }
        for (int i=0; i<60; i++) {
            NSString *num = [NSString stringWithFormat:@"%02d",i];
            if (date.year == currentDate.year && date.month == currentDate.month && date.day == currentDate.day && date.hour == currentDate.hour) {
                if (i<= date.minute) {
                    [_minuteArray addObject:num];
                }
            }else{
                [_minuteArray addObject:num];
            }
        }
        for (int i=0; i<60; i++) {
            NSString *num = [NSString stringWithFormat:@"%02d",i];
            if (date.year == currentDate.year && date.month == currentDate.month && date.day == currentDate.day && date.hour == currentDate.hour && date.minute == currentDate.minute) {
                if (i<=date.seconds) {
                    [_secondsArray addObject:num];
                }
            }else{
                [_secondsArray addObject:num];
            }
        }
    }
    if (_hourArray.count-1<hourIndex) {
        hourIndex = _hourArray.count-1;
    }
    if (_minuteArray.count-1<minuteIndex) {
        minuteIndex = _minuteArray.count-1;
    }
    if (_secondsArray.count-1<secondsIndex) {
        secondsIndex = _secondsArray.count-1;
    }
}
//设置每月的天数数组
- (void)setdayArray:(NSInteger)num
{
    [_dayArray removeAllObjects];
    for (int i=1; i<=num; i++) {
        [_dayArray addObject:[NSString stringWithFormat:@"%02d",i]];
    }
}

#pragma mark - getter / setter
- (UIPickerView *)datePicker {
    if (!_datePicker) {
        [self layoutIfNeeded];
        _datePicker = [[UIPickerView alloc] initWithFrame:self.bounds];
        _datePicker.showsSelectionIndicator = YES;
        _datePicker.delegate = self;
        _datePicker.dataSource = self;
    }
    return _datePicker;
}

-(void)setMinLimitDate:(NSDate *)minLimitDate {
    _minLimitDate = minLimitDate;
    if ([_scrollToDate compare:self.minLimitDate] == NSOrderedAscending) {
        _scrollToDate = self.minLimitDate;
    }
    [self getNowDate:self.scrollToDate animated:NO];
}

-(void)setThemeColor:(UIColor *)themeColor {
    _themeColor = themeColor;
    
}
- (void)setDatePickerType:(DatePickViewType)datePickerType{
    _datePickerType = datePickerType;
    [self.datePicker reloadAllComponents];
}




@end
