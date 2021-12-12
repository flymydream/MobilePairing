//
//  HDDSelectedTimeView.m
//  Driver
//
//  Created by caesar on 2021/9/8.
//  Copyright © 2021 caesar. All rights reserved.
//

#import "HDDSelectedTimeView.h"
#import "HDDDatePickView.h"

typedef void(^doneBlock)(NSString *);

@interface HDDSelectedTimeView ()<UIGestureRecognizerDelegate>


@property (strong, nonatomic) UIView *bottomView;

@property (strong, nonatomic) UIButton *sureBtn;

@property (nonatomic,strong)doneBlock doneBlock;

@property (nonatomic, strong) HDDDatePickView *pickerView;
@property (nonatomic, strong) NSString *timeStr;//选择的时间
@property (nonatomic, strong) NSDate *pushDate;//传入的时间

@end

@implementation HDDSelectedTimeView

- (instancetype)initSelectedTimeType:(DatePickViewType)timeType completeBlock:(void(^)(NSString *))completeBlock {
    self = [super init];
    if (self) {
        
        _datePickerType = timeType;
        
        [self setupUI];
        
        if (completeBlock) {
            self.doneBlock = ^(NSString *startDate) {
                completeBlock(startDate);
            };
        }
    }
    return self;
}
- (void)setupUI{
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
    
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(10, kScreenHeight - kBottomBarHeight - 276, kScreenWidth-20,  276)];
    [self.bottomView rounded:6];
    self.bottomView.backgroundColor = WhiteColor;
    [self addSubview:self.bottomView];
    
    _pickerView =  [[HDDDatePickView alloc]initWithFrame:CGRectMake(0, 0,self.bottomView.width, 226) withDatePickerType:self.datePickerType];
    _pickerView.maxLimitDate = [NSDate date];
    _pickerView.themeColor = KCustomAdjustColor(HomeTextColor, DarkTextColor);
    [self.bottomView addSubview:_pickerView];
    kWeakSelf(self);
    _pickerView.selectedDateCompleteBlock = ^(NSString * timeStr) {
        kStrongSelf(self);
        self.timeStr =  timeStr;
    };
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    sureBtn.backgroundColor = APPColor;
    [self.bottomView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.bottomView);
        make.height.mas_equalTo(@50);
    }];
    self.sureBtn = sureBtn;
    [self.sureBtn addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //点击背景是否影藏
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
}
- (void)getNowDate:(NSDate *)date animated:(BOOL)animated{
    _pushDate = date;
    [self.pickerView getNowDate:date animated:animated];
}
#pragma mark ============点击确定按钮的回调事件===========
- (void)clickButtonAction:(UIButton *)sender {
    if (self.timeStr.length == 0) {
        self.timeStr = self.pushDate ? [HDDTimeTool getDateStringByPushDate:self.pushDate andFormaterString:@"yyyy-MM-dd HH:mm:ss"] : [HDDTimeTool getCurrentlTime];
    }
    self.doneBlock(self.timeStr);
    [self dismiss];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if( [touch.view isDescendantOfView:self.bottomView]) {
        return NO;
    }
    return YES;
}
#pragma mark - Action
- (void)showPickerView {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0 animations:^{
        self.backgroundColor = RGBA(0, 0, 0, 0.4);
        [self layoutIfNeeded];
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0 animations:^{
        self.backgroundColor = RGBA(0, 0, 0, 0);
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self removeFromSuperview];
    }];
}



@end
