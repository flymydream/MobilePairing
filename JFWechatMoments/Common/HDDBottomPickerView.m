//
//  HDDBottomPickerView.m
//  Shipper
//
//  Created by caesar on 2021/2/22.
//  Copyright © 2021 caesar. All rights reserved.
//

#import "HDDBottomPickerView.h"

@interface HDDBottomPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *innerView;
@property (weak, nonatomic) IBOutlet UIView *lightGrayView;
@property (weak, nonatomic) IBOutlet UILabel *themeLabel;//标题
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *cancelLabel;//取消
@property (weak, nonatomic) IBOutlet UILabel *determineLabel;//确定
@property (weak, nonatomic) IBOutlet UILabel *line;//分割线
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;

@end

@implementation HDDBottomPickerView


- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [[NSBundle mainBundle]loadNibNamed:[[self class] description] owner:self options:nil];
        _innerView.frame = self.bounds;
        [self addSubview:_innerView];
        
        [self setupUI];
    }
    return self;
}
+ (instancetype)defaultPickerView{
    return [[HDDBottomPickerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
}
- (void)setupUI{
    
    self.bottomView.backgroundColor = UnitBGColor;
    self.cancelLabel.textColor = PlaceTextColor;
    self.line.backgroundColor = DividerlineBgColor;
    self.themeLabel.textColor = MainTextColor;
    self.bottomView.frame = CGRectMake(0, kScreenHeight + 279, kScreenWidth, 279);
    kWeakSelf(self);
    [self.innerView setTapActionWithBlock:^(UIGestureRecognizer * _Nonnull gesture) {
        kStrongSelf(self);
        [self hiddenPickerView];
    }];
    [self.cancelLabel setTapActionWithBlock:^(UIGestureRecognizer * _Nonnull gesture) {
        kStrongSelf(self);
        [self hiddenPickerView];
    }];
    //确定按钮
    [self.determineLabel setTapActionWithBlock:^(UIGestureRecognizer * _Nonnull gesture) {
        kStrongSelf(self);
        [self clickSureAction];
    }];
    
}
- (void)setThemeText:(NSString *)themeText{
    if (themeText.length > 0) {
        self.themeLabel.text = themeText;
    }
}
- (void)setShowContent:(NSString *)showContent{
    _showContent = showContent;
    if (showContent.length > 0) {
        if ([self.pickArray containsObject:showContent]) {
            NSInteger index = [self.pickArray indexOfObject:showContent];
            [self.pickView selectRow:index inComponent:0 animated:YES];
        } else {
            [self.pickView selectRow:0 inComponent:0 animated:YES];
        }
    }
}
- (void)showPickerView{
    [kKeyWindow addSubview:self];
    self.hidden = NO;
    __weak typeof (self) weakSelf = self;
    [UIView animateWithDuration:0.3 // 动画时长
                          delay:0.0 // 动画延迟
                        options:UIViewAnimationOptionCurveEaseOut // 动画过渡效果
                     animations:^{
                         __strong typeof (weakSelf) strongSelf = weakSelf;
                         strongSelf.bottomView.frame = CGRectMake(0, kScreenHeight - 279-kBottomBarHeight, kScreenWidth, 279);
                     }
                     completion:^(BOOL finished) {
                         // 动画完成后执行
                         __strong typeof (weakSelf) strongSelf = weakSelf;
                         strongSelf.bottomView.hidden = NO;
                     }];
}

- (void)hiddenPickerView{
    __weak typeof (self) weakSelf = self;
    [UIView animateWithDuration:0.3 // 动画时长
                          delay:0.0 // 动画延迟
                        options:UIViewAnimationOptionCurveEaseIn // 动画过渡效果
                     animations:^{
                         __strong typeof (weakSelf) strongSelf = weakSelf;
                         strongSelf.lightGrayView.hidden = YES;
                 strongSelf.bottomView.frame = CGRectMake(0, kScreenHeight + 279, kScreenWidth, 279);
                     }
                     completion:^(BOOL finished) {
                         // 动画完成后执行
                         __strong typeof (weakSelf) strongSelf = weakSelf;
                         strongSelf.hidden = YES;
                         strongSelf.bottomView.hidden = YES;
                     }];
}
#pragma mark ============点击确定事件===========
- (void)clickSureAction{
    NSInteger selectedRow = [self.pickView selectedRowInComponent:0];
    NSString *str = self.pickArray[selectedRow];
    if (self.clickPickerSureBlock) {
        self.clickPickerSureBlock(str);
    }
    if (self.clickSurePickerBlock) {
        self.clickSurePickerBlock(str,selectedRow);
    }
    [self hiddenPickerView];
}

#pragma mark ============UIPickerViewDelegate===========
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.pickArray.count;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 48;
}
//设置每行每列显示的内容
 -(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
     return NSStringFormat(@"%@",self.pickArray[row]);
 }
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    [self changeSpearatorLineColor];
    UILabel *rowLabel = [[UILabel alloc]init];
    rowLabel.textAlignment = NSTextAlignmentCenter;
    rowLabel.frame = CGRectMake(0, 0, self.frame.size.width,48);
    rowLabel.textAlignment = NSTextAlignmentCenter;
    rowLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    rowLabel.textColor = KCustomAdjustColor([UIColor blackColor], DarkTextColor);
    rowLabel.text = self.pickArray[row];
    [rowLabel sizeToFit];
    return rowLabel;
}
#pragma mark - 改变分割线的颜色
- (void)changeSpearatorLineColor {
    
    for(UIView *speartorView in _pickView.subviews) {
        if (speartorView.frame.size.height < 60) {//找出当前的 View
            // 添加分割线 (判断只添加一次  滑动不断刷新)
            if (speartorView.subviews.count ==0){
                UIView *line = [self lineView];
                line.frame = CGRectMake(10, 0, kScreenWidth - 38, 1.5);
                [speartorView addSubview:line];
                
                UIView *line2 = [self lineView];
                line2.frame = CGRectMake(10, speartorView.mj_h-1.5, kScreenWidth - 38, 1.5);
                [speartorView addSubview:line2];
            }
            speartorView.backgroundColor = [UIColor clearColor];
        }else{
            speartorView.backgroundColor = [UIColor clearColor];
        }
    }
}
//分割线
- (UIView *)lineView {
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 38,1.5)];
    line.backgroundColor = APPColor;
    return line;
}
@end
