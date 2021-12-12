//
//  HDDUpdateView.m
//  Driver
//
//  Created by caesar on 2020/9/25.
//  Copyright © 2020 caesar. All rights reserved.
//

#import "HDDUpdateView.h"
@interface HDDUpdateView ()

@property (strong, nonatomic) IBOutlet UIView *innerView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *hLine;//横向分割线
@property (weak, nonatomic) IBOutlet UILabel *vLine;//竖向分割线
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *regularView;//普通更新的视图
@property (weak, nonatomic) IBOutlet UIView *forcedView;//强制更新的视图
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;//取消按钮

@end

@implementation HDDUpdateView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.tag = 1111111111;
        [kKeyWindow addSubview:self];
        [[NSBundle mainBundle]loadNibNamed:[[self class] description] owner:self options:nil];
        _innerView.frame = self.bounds;
        [self addSubview:self.innerView];
//        self.alpha = 0;
        self.backgroundColor = HexRGBAlpha(0x0000, 0.3);
        self.hidden = YES;
        [self setupUI];
    }
    return self;
}
+(instancetype)defaultUpdateView{
    
    return [[HDDUpdateView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
}
- (void)setupUI{
    _bgView.backgroundColor = KCustomAdjustColor(WhiteColor, DarkBgColor);
    _themeLabel.font = [NSString setHelveticaBoldFont:15];
    _contentLabel.textColor = KCustomAdjustColor(HomeTextColor, DarkTextColor);
    [_cancelBtn setTitleColor:KCustomAdjustColor(HomeTextColor, DarkTextColor) forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:KCustomAdjustColor(HomeTextColor, DarkTextColor) forState:UIControlStateHighlighted];
    _regularView.backgroundColor = KCustomAdjustColor(WhiteColor, DarkBgColor);
    _forcedView.backgroundColor = KCustomAdjustColor(WhiteColor, DarkBgColor);
    _hLine.backgroundColor = KCustomAdjustColor(BackColor, DarkBgColor);
    _vLine.backgroundColor = KCustomAdjustColor(BackColor, DarkBgColor);
}
- (void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.hidden = NO;
    [kKeyWindow bringSubviewToFront:self];
    [self setViewAnimantionFadeInAndOut:1.0f withAnimationDuration:1.2];
    //1.普通更新 2.强制更新
    if ([dict[@"forceUpdate"] integerValue] == 1) {
        _regularView.hidden = NO;
        _forcedView.hidden = YES;
    }else{
        _forcedView.hidden = NO;
        _regularView.hidden = YES;
    }
    _themeLabel.text = NSStringFormat(@"%@%@：",UPDATE_REMIND_TITLE,dict[@"newVersion"]);
    _contentLabel.text = [dict[@"updateDesc"] stringByReplacingOccurrencesOfString:@"\\n" withString:@"\r"];
    _bgView.height = CGRectGetMaxY(self.contentLabel.frame) + 65;
}
//普通的取消按钮事件
- (IBAction)regularCancelButtonAction:(UIButton *)sender {
    [self setViewAnimantionFadeInAndOut:0.0f withAnimationDuration:0.03];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.04* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}
//立即升级按钮的点击事件
- (IBAction)forceButtonAction:(UIButton *)sender {
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/id1584269521?mt=8"]];
//    @throw [NSException exceptionWithName:NSGenericException
//                                   reason:@"crash-self-ensure"
//                                 userInfo:nil];
}

@end
