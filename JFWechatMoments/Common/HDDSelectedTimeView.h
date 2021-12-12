//
//  HDDSelectedTimeView.h
//  Driver
//
//  Created by caesar on 2021/9/8.
//  Copyright © 2021 caesar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HDDSelectedTimeView : UIView

/*选择类型*/
@property (nonatomic,assign) DatePickViewType datePickerType;

- (instancetype)initSelectedTimeType:(DatePickViewType)timeType completeBlock:(void(^)(NSString *))completeBlock;
//滚动到当前时间
- (void)getNowDate:(NSDate *)date animated:(BOOL)animated;
//显示视图
- (void)showPickerView;

@end

