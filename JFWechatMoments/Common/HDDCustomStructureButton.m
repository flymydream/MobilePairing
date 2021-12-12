//
//  HDDCustomStructureButton.m
//  Shipper
//
//  Created by caesar on 2021/4/2.
//  Copyright © 2021 caesar. All rights reserved.
//

#import "HDDCustomStructureButton.h"
@interface HDDCustomStructureButton ()
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel  *textLabel;

@end
@implementation HDDCustomStructureButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    
    _numberLabel = [[UILabel alloc]init];
    _numberLabel.textColor = SubtitleTextColor;
    _numberLabel.font = [NSString setPingFangSCMediumFont:14];
    _numberLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_numberLabel];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(11);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(@16);
    }];
    
    _textLabel = [[UILabel alloc]init];
    _textLabel.textColor = MainTextColor;
    _textLabel.font = [NSString setPingFangSCMediumFont:14];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_textLabel];
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_numberLabel.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@22);
    }];
}
- (void)setSelected:(BOOL)selected{
    if (selected) {
        _textLabel.textColor = _numberLabel.textColor = HexRGB(0x2197FF);
    }else{
        _textLabel.textColor = MainTextColor;
        _numberLabel.textColor = SubtitleTextColor;
    }
}
- (void)setNumberStr:(NSString *)numberStr{
    _numberStr  = numberStr;
    if (numberStr.length) {
        _numberLabel.text = numberStr;
    }
}
- (void)setTextStr:(NSString *)textStr{
    _textStr = textStr;
    if (textStr) {
        _textLabel.text = textStr;
    }
}

@end
