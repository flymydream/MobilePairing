//
//  UIView+netError.m
//  Driver
//
//  Created by caesar on 2020/1/19.
//  Copyright © 2020 caesar. All rights reserved.
//

#import "UIView+netError.h"
#import <objc/runtime.h>

@interface UIView ()

@property (nonatomic,copy) void(^reloadAction)(void);

@end

@implementation UIView (netError)

- (void)setReloadAction:(void (^)(void))reloadAction{
    objc_setAssociatedObject(self, @selector(reloadAction), reloadAction, OBJC_ASSOCIATION_COPY);
}
- (void (^)(void))reloadAction{
    return objc_getAssociatedObject(self, _cmd);
}

//HDDNetErrorPageView
- (void)setNetErrorPageView:(HDDNetErrorPageView *)netErrorPageView{
    
    [self willChangeValueForKey:NSStringFromSelector(@selector(netErrorPageView))];
    objc_setAssociatedObject(self, @selector(netErrorPageView), netErrorPageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:NSStringFromSelector(@selector(netErrorPageView))];
}

- (HDDNetErrorPageView *)netErrorPageView{
    return objc_getAssociatedObject(self, _cmd);
}
//点击重试操作
- (void)configReloadAction:(void (^)(void))block{
    self.reloadAction = block;
    if (self.netErrorPageView && self.reloadAction) {
        self.netErrorPageView.didClickReloadBlock = self.reloadAction;
    }
}
- (void)showNetErrorPageView{
    
    if (!self.netErrorPageView) {
        self.netErrorPageView = [[HDDNetErrorPageView alloc]initWithFrame:self.bounds];
        if (self.reloadAction) {
            self.netErrorPageView.didClickReloadBlock = self.reloadAction;
        }
    }
    [self addSubview:self.netErrorPageView];
    [self bringSubviewToFront:self.netErrorPageView];
}

- (void)hideNetErrorPageView{
    if (self.netErrorPageView) {
        [self.netErrorPageView removeFromSuperview];
    }
}


@end



#pragma mark ---  HDDNetErrorPageView
@interface HDDNetErrorPageView ()

@property (nonatomic,weak) UIImageView* errorImageView;
@property (nonatomic,weak) UIButton* reloadButton;

@end

@implementation HDDNetErrorPageView
- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView* errorImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"net_error"]];
        _errorImageView = errorImageView;
        [self addSubview:_errorImageView];
        
        UIButton* reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [reloadButton setTitle:@"  网络好像有点问题请点击重试~" forState:UIControlStateNormal];
        reloadButton.titleLabel.font = FontSize(15);
        [reloadButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [reloadButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
        [reloadButton addTarget:self action:@selector(_clickReloadButton:) forControlEvents:UIControlEventTouchUpInside];
        _reloadButton = reloadButton;
        [self addSubview:_reloadButton];
        
        [_errorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self.mas_centerY).offset(-80);
        }];
        [_reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.equalTo(@20);
            make.top.equalTo(_errorImageView.mas_bottom).offset(10);
        }];
    }
    return self;
}

- (void)_clickReloadButton:(UIButton* )btn{
    if (_didClickReloadBlock) {
        _didClickReloadBlock();
    }
}

@end

