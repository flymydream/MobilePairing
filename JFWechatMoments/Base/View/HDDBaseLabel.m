//
//  HDDBaseLabel.m
//  Shipper
//
//  Created by caesar on 2021/3/9.
//  Copyright © 2021 caesar. All rights reserved.
//

#import "HDDBaseLabel.h"

@implementation HDDBaseLabel

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initSettings];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSettings];
    }
    return self;
}

- (instancetype)init{
    self = [self initWithFrame:CGRectZero];
    return self;
}

- (void)initSettings{
    self.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.textColor = MainTextColor;
}

- (void)setLabelType:(NSInteger)LabelType{
    _LabelType = LabelType;
    switch (LabelType) {
        case 1:
            //主文字
            self.textColor = MainTextColor;
            self.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
            break;
        case 2:
            //提示文字
            self.textColor = SubtitleTextColor;
            self.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
            break;
        case 3:
            //提示文字
            self.textColor = SubtitleTextColor;
            self.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
            break;
        case 4:
            //提示问题颜色
            self.textColor = PlaceTextColor;
            self.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
            break;
        case 5:
            //单位标题的文字颜色（元、方）
            self.textColor = UnitTextColor;
            self.font = [UIFont fontWithName:@"PingFangSC-Regular" size:10];
            break;
        case 6:
            //输入框颜色和请选择的文字颜色
            self.textColor = TFPlacholderColor;
            self.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
            break;
        case 7:
            //规则类的颜色
            self.backgroundColor = RegulesBgColor;
            self.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
            self.textColor = MainTextColor;
            [self rounded:3];
            break;
        case 8:
            //分割线的颜色
            self.backgroundColor = DividerlineBgColor;
            break;
        case 9:
            //元/吨
            self.textColor = MainTextColor;
            self.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
            break;
        case 10:
            //子标题
            self.textColor = SubtitleTextColor;
            self.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
            break;
        case 11:
            self.textColor = MainTextColor;
            self.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
            break;
        default:
            self.textColor = MainTextColor;
            break;
    }
}
@end
