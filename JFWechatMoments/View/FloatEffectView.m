//
//  FloatEffectView.m
//  WMZFloatView
//
//  Created by hero on 2021/12/11.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "FloatEffectView.h"
#import "HKFloatManager.h"


#define  faloatWindow   [UIApplication sharedApplication].keyWindow

#define  FloatWidth   [UIScreen mainScreen].bounds.size.width
#define  FloatHeight  [UIScreen mainScreen].bounds.size.height

#define  FloatShowColor FloatColor(0x1d76db)

@interface FloatEffectView()
@property(nonatomic,strong)UIVisualEffectView *effectView;

@property(nonatomic,strong)UIImageView *playIconImageView;
@property(nonatomic,strong)UILabel *playTextLabel;
@property(nonatomic,strong)UIButton *closeButton;


@end


@implementation FloatEffectView

- (UIView *)effectView{
    if (!_effectView) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _effectView= [[UIVisualEffectView alloc] initWithEffect:effect];
        _effectView.frame = [UIApplication sharedApplication].keyWindow.bounds;
        UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(effectViewAction)];
        _effectView.userInteractionEnabled = YES;;
        [_effectView addGestureRecognizer:pan];
    }
    return _effectView;
}
-(UIImageView *)playIconImageView {
    if (!_playIconImageView) {
        _playIconImageView = [[UIImageView alloc] init];
        _playIconImageView.image = [UIImage imageNamed:@"icon_1"];
    }
    return _playIconImageView;
}
-(UILabel *)playTextLabel {
    if (!_playTextLabel) {
        _playTextLabel = [[UILabel alloc] init];
        _playTextLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _playTextLabel;
}
-(UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"float_close"] forState:UIControlStateNormal];
    }
    return _closeButton;
}

- (instancetype)initWithFrame:(CGRect)frame rect:(CGRect)rect{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUIWithRect:rect];
    }
    return self;
}
- (void)createUIWithRect:(CGRect)rect {
    //添加毛玻璃效果
    [self addSubview:self.effectView];
    //添加播放的view
    UIView *contentVIew = [[UIView alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y,150, 40)];
    if (rect.origin.x > FloatWidth / 2) {//右边
        contentVIew.frame = CGRectMake(FloatWidth - 150 - 10, rect.origin.y,150, 40);
    }
    [self addSubview:contentVIew];
    contentVIew.backgroundColor = [UIColor yellowColor];
    
    self.playIconImageView.frame = CGRectMake(5, 0, 40, 40);
    [contentVIew addSubview:self.playIconImageView];
    
    
    self.playTextLabel.text = @"黄志忠是朗诵天才是怎么炼成的测试标题说话的时候";
    self.playTextLabel.numberOfLines = 0;
    self.playTextLabel.font = [UIFont systemFontOfSize:12];
    self.playTextLabel.frame = CGRectMake(CGRectGetMaxX(self.playIconImageView.frame)+10, 0, 60, 40);
    [contentVIew addSubview:self.playTextLabel];
    
    
    self.closeButton.frame = CGRectMake(CGRectGetMaxX(self.playTextLabel.frame)+10, 0, 40, 40);
    [contentVIew addSubview:self.closeButton];
    [self.closeButton addTarget:self action:@selector(clickCloseButton) forControlEvents:UIControlEventTouchUpInside];
}

//背景点击 关闭
- (void)effectViewAction{
    [HKFloatManager shared].floatBall.hidden = NO;
    [self removeFromSuperview];
}
- (void)clickCloseButton {
    [HKFloatManager shared].floatBall.hidden = NO;
    [self removeFromSuperview];
}

@end
