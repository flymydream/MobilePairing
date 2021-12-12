//
//  HDDBottomView.m
//  Shipper
//
//  Created by caesar on 2021/3/1.
//  Copyright © 2021 caesar. All rights reserved.
//

#import "HDDBottomView.h"

@interface HDDBottomView ()
@property (nonatomic, strong) UILabel *saveLabel;

@end

@implementation HDDBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    self.backgroundColor = UnitBGColor;
    [self shadow:HexRGBAlpha(0xA8A8A8, 0.5) opacity:0.8 radius:3 offset:CGSizeMake(0, -3)];
    _saveLabel = [[UILabel alloc]init];
    _saveLabel.font = FontSize(15);
    _saveLabel.backgroundColor = APPColor;
    _saveLabel.textColor = WhiteColor;
    _saveLabel.textAlignment = NSTextAlignmentCenter;
    [_saveLabel rounded:6];
    [self addSubview:_saveLabel];
    [_saveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(7, 7, 7, 7));
    }];
    kWeakSelf(self);
    [self setTapActionWithBlock:^(UIGestureRecognizer * _Nonnull gesture) {
        kStrongSelf(self);
//        self.userInteractionEnabled = NO;
        if (self.clickBottomActionBlock) {
            self.clickBottomActionBlock();
        }
    }];
}
- (void)setTextString:(NSString *)textString{
    _textString = textString;
    if (textString.length > 0) {
        _saveLabel.text = textString;
    }
}


@end
