//
//  HDDInputPopView.m
//  Shipper
//
//  Created by caesar on 2021/9/6.
//  Copyright © 2021 caesar. All rights reserved.
//

#import "HDDInputPopView.h"

@interface HDDInputPopView ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIView *innerView;
@property (weak, nonatomic) IBOutlet HDDBaseView *bgView;
//标题
@property (weak, nonatomic) IBOutlet UILabel *themeLabel;
//输入框
@property (weak, nonatomic) IBOutlet HDDBaseTextField *teamTF;
//取消按钮
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
//确定按钮
@property (weak, nonatomic) IBOutlet UIButton *comfireBtn;

@end

@implementation HDDInputPopView
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        
        [[NSBundle mainBundle]loadNibNamed:[[self class] description] owner:self options:nil];
        _innerView.frame = self.bounds;
        [self addSubview:_innerView];
        [self setupUI];
    }
    return self;
}
+ (instancetype)defaultInputPopView{
    return [[HDDInputPopView alloc]initWithFrame:kKeyWindow.bounds];
}
- (void)setupUI{
    self.teamTF.backgroundColor = ClearColor;
    self.themeLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    //司机姓名
    [self.teamTF addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    self.teamTF.delegate = self;
}
- (void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    if (titleString.length > 0) {
        self.themeLabel.text = titleString;
    }
}
#pragma mark ============取消按钮事件===========
- (IBAction)cancelButtonAction:(UIButton *)sender {
    [self hiddenInputRemindPopView];
    if (self.clickCancelButtonBlock) {
        self.clickCancelButtonBlock();
    }
}
#pragma mark ============点击确定按钮事件===========
- (IBAction)sureButtonAction:(UIButton *)sender {
    if (self.teamTF.text.length == 0) {
        [HDDCustomToastView toastMessage:@"请输入分组名称"];
        return;
    }
    if (self.clickConfirmButtonBlock) {
        self.clickConfirmButtonBlock(self.teamTF.text);
    }
}
- (void)showInputRemindPopView{
   [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = RGBA(0, 0, 0, 0.3);
    }];
}
- (void)hiddenInputRemindPopView{
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = RGBA(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self removeFromSuperview];
    }];
}
#pragma mark ============UITextFeildDelegate===========
- (void)textFieldChanged:(UITextField *)textField{
    if (textField.text.length > 20) {
        textField.text = [textField.text substringToIndex:20];
    }
}




@end
