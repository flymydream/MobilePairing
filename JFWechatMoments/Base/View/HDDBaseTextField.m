//
//  HDDBaseTextField.m
//  Shipper
//
//  Created by caesar on 2021/3/10.
//  Copyright © 2021 caesar. All rights reserved.
//

#import "HDDBaseTextField.h"

@implementation HDDBaseTextField

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
    self.tintColor = APPColor;
}
- (void)setTextFieldType:(NSInteger)TextFieldType{
    _TextFieldType = TextFieldType;
    switch (TextFieldType) {
        case 1://主文字的颜色
            self.textColor = MainTextColor;
            break;
        case 2://place文字的颜色
            self.textColor = SubtitleTextColor;
            break;
        case 3://暂定
            self.textColor = PlaceTextColor;
            break;
        default:
            break;
    }
}
////控制文本所在的的位置，左右缩 10
//- (CGRect)textRectForBounds:(CGRect)bounds {
//    return CGRectInset( bounds , 3, 0 );
//}
//  
////控制编辑文本时所在的位置，左右缩 10
//- (CGRect)editingRectForBounds:(CGRect)bounds {
//    return CGRectInset( bounds , 3 , 0 );
//}
@end
