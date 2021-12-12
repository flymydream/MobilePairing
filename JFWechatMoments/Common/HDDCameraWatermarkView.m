//
//  HDDCameraWatermarkView.m
//  textDemo
//
//  Created by caesar on 2020/5/6.
//  Copyright © 2020 caesar. All rights reserved.
//

#import "HDDCameraWatermarkView.h"

@implementation HDDCameraWatermarkView

- (instancetype)initWithFrame:(CGRect)frame withImagePickerType:(NSString *)type{
    
    self = [super initWithFrame:frame];
    if (self) {  
        [self setupUIWithFrom:type];
    }
    return self;
}

- (void)setupUIWithFrom:(NSString *)fromType{
    NSMutableAttributedString *first = [[NSMutableAttributedString alloc] initWithString:@"请将" attributes:@{NSForegroundColorAttributeName :HexRGB(0xFFFFFF), NSFontAttributeName : FontSize(16)}];
    NSString *imageNameStr = @"";
    if ([fromType isEqualToString:DRIVER_IDCARD_FRONT]) {
        NSMutableAttributedString *second = [[NSMutableAttributedString alloc] initWithString:@"身份证" attributes:@{NSForegroundColorAttributeName :HexRGB(0xFF6701), NSFontAttributeName : FontSize(16)}];
        NSMutableAttributedString *third = [[NSMutableAttributedString alloc] initWithString:@"人像面对齐边框，避免反光模糊" attributes:@{NSForegroundColorAttributeName :HexRGB(0xFFFFFF), NSFontAttributeName : FontSize(16)}];
        [second appendAttributedString:third];
        [first appendAttributedString:second];
        imageNameStr = @"id_reverse";
    }else if ([fromType isEqualToString:DRIVER_IDCARD_BACK]){
        NSMutableAttributedString *second = [[NSMutableAttributedString alloc] initWithString:@"身份证" attributes:@{NSForegroundColorAttributeName :HexRGB(0xFF6701), NSFontAttributeName : FontSize(16)}];
        NSMutableAttributedString *third = [[NSMutableAttributedString alloc] initWithString:@"国徽面对齐边框，避免反光模糊" attributes:@{NSForegroundColorAttributeName :HexRGB(0xFFFFFF), NSFontAttributeName : FontSize(16)}];
        [second appendAttributedString:third];
        [first appendAttributedString:second];
        imageNameStr = @"id_positive";
    }else if ([fromType isEqualToString:DRIVER_LICENSE_FRONT]){
        NSMutableAttributedString *second = [[NSMutableAttributedString alloc] initWithString:@"驾驶证" attributes:@{NSForegroundColorAttributeName :HexRGB(0xFF6701), NSFontAttributeName : FontSize(16)}];
        NSMutableAttributedString *third = [[NSMutableAttributedString alloc] initWithString:@"印章信息对齐边框，避免反光模糊" attributes:@{NSForegroundColorAttributeName :HexRGB(0xFFFFFF), NSFontAttributeName : FontSize(16)}];
        [second appendAttributedString:third];
        [first appendAttributedString:second];
        imageNameStr = @"driver_original";
    }else if ([fromType isEqualToString:DRIVER_LICENSE_BACK]){
        NSMutableAttributedString *second = [[NSMutableAttributedString alloc] initWithString:@"驾驶证" attributes:@{NSForegroundColorAttributeName :HexRGB(0xFF6701), NSFontAttributeName : FontSize(16)}];
        NSMutableAttributedString *third = [[NSMutableAttributedString alloc] initWithString:@"卡片对齐边框，避免反光模糊" attributes:@{NSForegroundColorAttributeName :HexRGB(0xFFFFFF), NSFontAttributeName : FontSize(16)}];
        [second appendAttributedString:third];
        [first appendAttributedString:second];
        imageNameStr = @"driver_deputy";
    }else if ([fromType isEqualToString:VEHICLE_LICENSE_FRONT]){
        NSMutableAttributedString *second = [[NSMutableAttributedString alloc] initWithString:@"行驶证" attributes:@{NSForegroundColorAttributeName :HexRGB(0xFF6701), NSFontAttributeName : FontSize(16)}];
        NSMutableAttributedString *third = [[NSMutableAttributedString alloc] initWithString:@"印章信息对齐边框，避免反光模糊" attributes:@{NSForegroundColorAttributeName :HexRGB(0xFFFFFF), NSFontAttributeName : FontSize(16)}];
        [second appendAttributedString:third];
        [first appendAttributedString:second];
        imageNameStr = @"vehicle_original";
    }else if ([fromType isEqualToString:VEHICLE_LICENSE_BACK]){
        NSMutableAttributedString *second = [[NSMutableAttributedString alloc] initWithString:@"行驶证" attributes:@{NSForegroundColorAttributeName :HexRGB(0xFF6701), NSFontAttributeName : FontSize(16)}];
        NSMutableAttributedString *third = [[NSMutableAttributedString alloc] initWithString:@"条形码信息对齐边框，避免反光模糊" attributes:@{NSForegroundColorAttributeName :HexRGB(0xFFFFFF), NSFontAttributeName : FontSize(16)}];
        [second appendAttributedString:third];
        [first appendAttributedString:second];
        imageNameStr = @"vehicle_deputy";
    }else if([fromType isEqualToString:CARD_BANKCARD_FORM]){
        NSMutableAttributedString *second = [[NSMutableAttributedString alloc] initWithString:@"银行卡" attributes:@{NSForegroundColorAttributeName :HexRGB(0xFF67011), NSFontAttributeName : FontSize(16)}];
        NSMutableAttributedString *third = [[NSMutableAttributedString alloc] initWithString:@"正面对齐边框，避免反光模糊" attributes:@{NSForegroundColorAttributeName :HexRGB(0xFFFFFF), NSFontAttributeName : FontSize(16)}];
        [second appendAttributedString:third];
        [first appendAttributedString:second];
        imageNameStr = @"driver_deputy";
    }else {
        self.hidden = YES;
    }
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformRotate(transform, M_PI_2);
    
    UILabel *label = [[UILabel alloc]init];
    label.layer.borderWidth = 1;
    label.layer.borderColor = [UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:1.0].CGColor;

    label.layer.backgroundColor = [UIColor colorWithRed:52/255.0 green:52/255.0 blue:52/255.0 alpha:1.0].CGColor;
    label.layer.cornerRadius = 17;
    label.attributedText = first;
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    label.transform = transform;
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(self.width/ 2 - 34 - 10);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(358, 34));
    }];

    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.center = self.center;
    imageView.image = [self image:[UIImage imageNamed:imageNameStr] rotation:UIImageOrientationRight];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
}

- (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{

    return NO;
}

@end
