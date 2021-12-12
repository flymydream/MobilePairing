//
//  HDDVehicleNumberKeyBoardView.m
//  Shipper
//
//  Created by caesar on 2021/3/2.
//  Copyright © 2021 caesar. All rights reserved.
//

#import "HDDVehicleNumberKeyBoardView.h"
#define kWidth  self.frame.size.width
#define kHeight self.frame.size.height

@interface HDDVehicleNumberKeyBoardView()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *backView1;//第一个view
@property (nonatomic, strong) UIView *backView2; //第二个view
@property (nonatomic, strong) NSArray *array1; //省市简写数组
@property (nonatomic, strong) NSArray *array2; //车牌号码字母数字数组

@property (nonatomic, assign) BOOL isDelating;//是否正在删除


@end

@implementation HDDVehicleNumberKeyBoardView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = HexRGBAlpha(0x000000, 0.01);
        
        //注册一个通知，后面会用到，来监听abc字母键
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFAction:) name:@"VehicleNumberKeyBoard" object:nil];
        
        //添加一个手势，点击键盘外面收回键盘
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenView)];
        recognizer.delegate = self;
        [self addGestureRecognizer:recognizer];
        
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    _backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, size.height, size.width, size.height * 0.33)];
    _backView1.backgroundColor = KCustomAdjustColor(HexRGB(0xd2d5da), DARKAppColor);
    _backView1.hidden = NO;
    
    _backView2 = [[UIView alloc] initWithFrame:CGRectMake(0, size.height, size.width, size.height * 0.33)];
    _backView2.hidden = YES;
    _backView2.backgroundColor = KCustomAdjustColor(HexRGB(0xd2d5da), DARKAppColor);
    
    [self addSubview:_backView1];
    [self addSubview:_backView2];
    
    int row = 4;
    int column1 = 9;
    int column2 = 10;
    CGFloat btnY = 4;
    CGFloat btnX = 2;
    CGFloat maginR = 5;
    CGFloat maginC = 10;
    CGFloat btnW = (size.width - maginR * (column1 -1) - 2 * btnX)/column1;
    CGFloat btnH = (_backView1.frame.size.height - kBottomBarHeight - maginC * (row - 1) - 6) / row;
    
    CGFloat btnW2 = (size.width - maginR * (column2 -1) - 2 * btnX)/column2;
    //纯汉字键盘
    for (int i = 0; i < self.array1.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnW * (i % column1) + i % column1 * maginR + btnX, btnY + i / column1 * (btnH + maginC),btnW, btnH);
        [btn setBackgroundColor:KCustomAdjustColor(WhiteColor, DarkBgColor)];
        [btn setTitleColor:MainTextColor forState:UIControlStateNormal];
        [btn setTitle:self.array1[i] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = YES;
        btn.tag = i;
        [btn addTarget:self action:@selector(btn1Click:) forControlEvents:UIControlEventTouchUpInside];
        [_backView1 addSubview:btn];
    }
    //字母和数字键盘
    for (int i = 0; i < self.array2.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
       if (i == 35) {//完成
            btn.frame = CGRectMake(btnW2 * (i % column2) + i % column2 * maginR + btnX, btnY + i /column2 * (btnH + maginC),btnW2 * 3 + maginR * 2, btnH);
            [btn setBackgroundColor:APPColor];
           [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         }else {
            btn.frame = CGRectMake(btnW2 * (i % column2) + i % column2 * maginR + btnX, btnY + i /column2 * (btnH + maginC), btnW2, btnH);
             if (i == 29) { //删除
                 [btn setBackgroundImage:[UIImage imageNamed:@"key_over"] forState:UIControlStateNormal];
             }else {
                 [btn setBackgroundColor:KCustomAdjustColor(WhiteColor, DarkBgColor)];
             }
             [btn setTitleColor:MainTextColor forState:UIControlStateNormal];
        }
        [btn setTitle:self.array2[i] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = YES;
        btn.tag = i;
        [btn addTarget:self action:@selector(btn2Click:) forControlEvents:UIControlEventTouchUpInside];
        [_backView2 addSubview:btn];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.backView1.frame;
        frame.origin.y = size.height - size.height * 0.33;
        self.backView1.frame = frame;
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.backView2.frame;
        frame.origin.y = size.height - size.height * 0.33;
        self.backView2.frame = frame;
    }];
}
//点击汉字键盘
- (void)btn1Click:(UIButton *)sender {
    
//    NSLog(@"LY >>> array1: - %@ -- tag - %zd", self.array1[sender.tag],sender.tag);
    _backView1.hidden = YES;
    _backView2.hidden = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickWithString:)]) {
        [self.delegate clickWithString:self.array1[sender.tag]];
    }
}
//数字键盘按钮的点击事件
- (void)btn2Click:(UIButton *)sender {
    
    if (sender.tag == 29) {
//        NSLog(@"点击了删除键");
        self.isDelating = YES;
        if (self.delegate && [self.delegate respondsToSelector:@selector(deleteBtnClick)]) {
            [self.delegate deleteBtnClick];
        }
    }else if (sender.tag == 35) {
        self.isDelating = NO;
//        NSLog(@"点击了完成");
        [self hiddenView];
    }else {
        self.isDelating = NO;
        if (self.delegate && [self.delegate respondsToSelector:@selector(clickWithString:)]) {
            [self.delegate clickWithString:self.array2[sender.tag]];
        }
    }
}
- (void)deleteEnd {
    _backView1.hidden = NO;
    _backView2.hidden = YES;
}
//初次弹出键盘时
- (void)showWithString:(NSString *)string {
    _backView1.hidden = YES;
    _backView2.hidden = NO;
    if (string.length == 1) {
        [self clickNumberButton:NO];
    }
}
//隐藏数字键盘
- (void)clickNumberButton:(BOOL)isEnable{
    NSInteger index = 0;
    for (UIButton *btn in self.backView2.subviews) {
        if (index == 10) {
            break;
        }
        btn.enabled = isEnable;
        if (!isEnable) {
           [btn setTitleColor:KCustomAdjustColor(HexRGB(0x999999), HexRGB(0x666666)) forState:UIControlStateNormal];
            [btn setBackgroundColor:KCustomAdjustColor([UIColor lightTextColor], DarkBgColor)];
        }else{
           [btn setTitleColor:MainTextColor forState:UIControlStateNormal];
           [btn setBackgroundColor:KCustomAdjustColor(WhiteColor, DarkBgColor)];
        }
        index++;
    }
}
//通知的监听方法
- (void)textFAction:(NSNotification *)notification {
    
//    NSLog(@"LY >> info -- %@", notification.userInfo);
    NSString *str = notification.userInfo[@"text"];
    if (str.length == 0) {
        _backView1.hidden = NO;
        _backView2.hidden = YES;
    }else if (str.length == 1){
        [self clickNumberButton:NO];
    }else if (str.length == 7) {
        [self hiddenView];
    } else {
        [self clickNumberButton:YES];
        _backView1.hidden = YES;
        _backView2.hidden = NO;
    }
}

//收回键盘
- (void)hiddenView {
    if (self.delegate) {
        [self.delegate keyboardHidden];
    }
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.backView1.frame;
        frame.origin.y = size.height;
        self.backView1.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.backView2.frame;
        frame.origin.y = size.height;
        self.backView2.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

//手势的代理方法
#pragma mark >> UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:_backView1] ||
        [touch.view isDescendantOfView:_backView2] ) {
        
        return NO;
    }
    return YES;
}

//  颜色转换为背景图片
//  这个之前用，后来让美工做了几张图片，一共就需要4张图片(abc建背景图，删除键 返回键 字符键)
- (UIImage *)imageWithColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//销毁通知
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (NSArray *)array1 {
    if (!_array1) {
//        _array1 = @[@"京",@"津",@"渝",@"沪",@"冀",@"晋",@"辽",@"吉",@"黑",@"苏",@"浙",@"皖",@"闽",@"赣",@"鲁",@"豫",@"鄂",@"湘",@"粤",@"琼",@"川",@"贵",@"云",@"陕",@"甘",@"青",@"蒙",@"桂",@"宁",@"新",@"藏",@"使",@"领",@"警",@"港",@"澳"];
        _array1 = @[@"京",@"津",@"渝",@"沪",@"冀",@"晋",@"辽",@"吉",@"黑",@"苏",@"浙",@"皖",@"闽",@"赣",@"鲁",@"豫",@"鄂",@"湘",@"粤",@"琼",@"川",@"贵",@"云",@"陕",@"甘",@"青",@"蒙",@"桂",@"宁",@"新",@"藏"];
    }
    return _array1;
}

- (NSArray *)array2 {
    if (!_array2) {
//        _array2 = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P",@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"",@"Z",@"X",@"C",@"V",@"B",@"N",@"M",@"完成"];
        _array2 = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"P",@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"Z",@"X",@"",@"C",@"V",@"B",@"N",@"M",@"完成"];
    }
    return _array2;
}
@end
