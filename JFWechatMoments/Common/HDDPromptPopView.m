//
//  HDDPromptPopView.m
//  Driver
//
//  Created by caesar on 2020/7/29.
//  Copyright © 2020 caesar. All rights reserved.
//

#import "HDDPromptPopView.h"
@interface HDDPromptPopView ()

@property (strong, nonatomic) IBOutlet UIView *innerView;
@property (weak, nonatomic) IBOutlet UIView *middleBgView;
@property (weak, nonatomic) IBOutlet UILabel *remindLabel;//温馨提示
@property (weak, nonatomic) IBOutlet UIImageView *leftimageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;//提示内容
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;//取消
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;//确定
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;//知道了

@end


@implementation HDDPromptPopView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        
        [[NSBundle mainBundle]loadNibNamed:[[self class] description] owner:self options:nil];
        _innerView.frame = self.bounds;
        [self addSubview:_innerView];
        [self setupUI];
        //最大宽度
        self.contentLabel.preferredMaxLayoutWidth = kScreenWidth - 120;
    }
    return self;
}
+ (instancetype)defaultPopView{
    return [[HDDPromptPopView alloc]initWithFrame:kKeyWindow.bounds];
}
- (void)setupUI{
    
    self.middleBgView.backgroundColor = KCustomAdjustColor(WhiteColor, DarkBgColor);
    self.remindLabel.textColor = KCustomAdjustColor(HomeTextColor, DarkTextColor);
    self.contentLabel.textColor = KCustomAdjustColor(HomeTextColor, DarkTextColor);
    [self.cancelBtn setTitleColor:KCustomAdjustColor(HomeTextColor, DarkTextColor) forState:UIControlStateNormal];
    self.remindLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    [self.middleBgView rounded:11];
    //点击知道了
    kWeakSelf(self);
    [self.bottomLabel setTapActionWithBlock:^(UIGestureRecognizer * _Nonnull gesture) {
        kStrongSelf(self);
        [self clickKnowButtonAction];
    }];
}
- (void)setShowDoubleSureButtonContentString:(NSString *)contentStr{
    [self setShowDoubleButtonContentString:contentStr rightTitleString:@"" cancelString:@""];
}
- (void)setShowDoubleButtonContentString:(NSString *)contentStr rightTitleString:(NSString *)titleStr cancelString:(NSString *)cancelString;{
    if (contentStr.length > 0) {
        self.contentLabel.text = contentStr;
    }
    if (titleStr.length > 0) {
        [self.sureBtn setTitle:titleStr forState:UIControlStateNormal];
    }else{
        [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    }
    if (cancelString.length > 0) {
        [self.cancelBtn setTitle:cancelString forState:UIControlStateNormal];
    }else{
        [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    }
}
//底部为单一按钮
- (void)setShowSingleKnowButtonContentString:(NSString *)contentStr{
    [self setShowSingleButtonContentString:contentStr signleString:@""];
}

- (void)setShowSingleButtonContentString:(NSString *)contentStr signleString:(NSString *)titleStr{
    self.bottomLabel.hidden = NO;
    self.bottomLabel.backgroundColor = KCustomAdjustColor(WhiteColor, DarkBgColor);
    if (contentStr.length > 0) {
        self.contentLabel.text = contentStr;
    }
    if (titleStr.length > 0) {
        self.bottomLabel.text = titleStr;
    }else{
        self.bottomLabel.text = @"知道了";
    }
}
- (void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    if (titleString.length > 0) {
        self.remindLabel.text = titleString;
    }
}
- (void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    if (imageName.length > 0) {
        self.leftimageView.image = ImageNamed(imageName);
    }
}
- (void)setIsRegularPhone:(BOOL)isRegularPhone{
    if (isRegularPhone) {
        [self distinguishPhoneNumLabel:self.contentLabel labelStr:self.contentLabel.text];
    }
}
- (void)setIsShowLeftImage:(BOOL)isShowLeftImage{
    if (isShowLeftImage) {
        self.leftimageView.hidden = isShowLeftImage;
    }
}
- (void)showRemindPopView{
   [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = RGBA(0, 0, 0, 0.3);
    }];
}
- (void)hiddenRemindPopView{
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = RGBA(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self removeFromSuperview];
    }];
}

#pragma mark ============取消按钮事件===========
- (IBAction)cancelButtonAction:(UIButton *)sender {
    [self hiddenRemindPopView];
    if (self.clickCancelButtonBlock) {
        self.clickCancelButtonBlock();
    }
}
#pragma mark ============点击确定按钮事件===========
- (IBAction)sureButtonAction:(UIButton *)sender {
    [self hiddenRemindPopView];
    if (self.clickRightButtonBlock) {
        self.clickRightButtonBlock();
    }
}
#pragma mark ============点击知道了按钮的回调事件===========
- (void)clickKnowButtonAction{
    [self hiddenRemindPopView];
    if (self.clickKnowButtonBlock) {
        self.clickKnowButtonBlock();
    }
}
#pragma mark ============匹配客户电话===========
-(void)distinguishPhoneNumLabel:(UILabel *)label labelStr:(NSString *)labelStr{

    //获取字符串中的电话号码
    NSString *regulaStr = @"400-993-7878";
    NSRange stringRange = NSMakeRange(0, labelStr.length);
    //正则匹配
    NSError *error;

    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:labelStr];

    NSRegularExpression *regexps = [NSRegularExpression regularExpressionWithPattern:regulaStr options:0 error:&error];
    if (!error && regexps != nil) {
        [regexps enumerateMatchesInString:labelStr options:0 range:stringRange usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            
            NSRange phoneRange = result.range;
            //定义一个NSAttributedstring接受电话号码字符串
    //         NSAttributedString *phoneNumber = [str attributedSubstringFromRange:phoneRange];
            //添加下划线
    //        NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    //        [str addAttributes:attribtDic range:phoneRange];
            //设置文本中的电话号码显示为黄色
            [str addAttribute:NSForegroundColorAttributeName value:APPColor range:phoneRange];
            
            label.attributedText = str;
            label.userInteractionEnabled = YES;
            
            //添加手势，可以点击号码拨打电话
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
            [label addGestureRecognizer:tap];
        }];
     }
}
#pragma mark ============拨打客服电话===========
- (void)tapGesture:(UITapGestureRecognizer *)sender{
// [HDDCallPhoneTool openCallPhoneNumber:kCustomerTelephone];
     
}



@end
