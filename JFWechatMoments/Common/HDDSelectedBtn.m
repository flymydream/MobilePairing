//
//  HDDSelectedBtn.m
//  Driver
//
//  Created by caesar on 2020/6/23.
//  Copyright © 2020 caesar. All rights reserved.
//

#import "HDDSelectedBtn.h"

@interface HDDSelectedBtn ()

@property (nonatomic, strong) UIImageView *selectedImageView;
@end
@implementation HDDSelectedBtn

//xib中
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self seupUI];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
       [self seupUI];
    }
    return self;
}
- (void)seupUI{
    [self rounded:3];
    UIImageView *angle = [[UIImageView alloc]init];
    angle.image = ImageNamed(COMMON_SELECTED_ANGLE);
    angle.hidden = YES;
    [self addSubview:angle];
    [angle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
    _selectedImageView = angle;
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    if (selected) {//选中状态的话
        _selectedImageView.hidden = NO;
        self.backgroundColor = KCustomAdjustColor(HexRGB(0xE8F4F0), HexRGB(0x4F4F4F));
        self.titleLabel.textColor = HexRGB(0x219A6A);
        [self setTitleColor:HexRGB(0x219A6A) forState:UIControlStateNormal];
        [self rounded:3 width:1 color:HexRGB(0x219A6A)];
    }else{
        _selectedImageView.hidden = YES;
        [self setTitleColor:MainTextColor forState:UIControlStateNormal];
        self.backgroundColor = BtnBgColor;
        [self rounded:3 width:0 color:ClearColor];
    }
    
}



@end
