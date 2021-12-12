//
//  HDDBaseView.m
//  Shipper
//
//  Created by caesar on 2021/3/9.
//  Copyright © 2021 caesar. All rights reserved.
//

#import "HDDBaseView.h"

@implementation HDDBaseView

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
    self.backgroundColor = UnitBGColor;
}
- (void)setViewType:(NSInteger)ViewType{
    _ViewType = ViewType;
    switch (ViewType) {
        case 1:
            self.backgroundColor = MainBGColor;
            break;
        case 2:
            self.backgroundColor = UnitBGColor;
            break;
        case 3:
            self.backgroundColor = F0EFF4BGColor;
            break;
        case 4: //白色背景，灰色边框
            self.backgroundColor = UnitBGColor;
            [self rounded:4 width:1 color:KCustomAdjustColor(HexRGB(0xE0E0E0), MainBGColor)];
            break;
        case 5: //背景添加向上的阴影
            [self shadow:HexRGBAlpha(0xA8A8A8, 0.5) opacity:0.8 radius:3 offset:CGSizeMake(0, -3)];
            break;
        case 6://置灰无法修改的背景视图
            self.backgroundColor = EnableViewBgColror;
            break;
        default:
            break;
    }
}

@end
