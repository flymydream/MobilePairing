//
//  CustomKeybord.m
//  autobole
//
//  Created by wyz on 2017/7/18.
//  Copyright © 2017年 autobole. All rights reserved.
//

#import "CustomKeyboard.h"
#import "HDDBaseLabel.h"
#define labelWidth ((kScreenWidth-80)/9)

@interface CustomKeyboard ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *provinceView;
@property (nonatomic, strong) UIView *letterView;
@property (nonatomic, strong) UIButton *doneBtn;
@property (nonatomic, strong) UIButton *isNewEnergy;
@property (nonatomic, strong) NSArray *letters;
@property (nonatomic, strong) NSArray *provinces;
@property (nonatomic, strong) NSMutableArray *values;
@property (nonatomic, strong) NSMutableArray *labels;
@property (nonatomic, assign) NSInteger plateNumberLength;
@property (nonatomic, assign) UIButton *zeroBtn;
@property (nonatomic, assign) UIButton *oneBtn;
@property (nonatomic, assign) UIButton *twoBtn;
@property (nonatomic, assign) UIButton *threeBtn;
@property (nonatomic, assign) UIButton *fourBtn;
@property (nonatomic, assign) UIButton *fiveBtn;
@property (nonatomic, assign) UIButton *sixBtn;
@property (nonatomic, assign) UIButton *sevenBtn;
@property (nonatomic, assign) UIButton *eightBtn;
@property (nonatomic, assign) UIButton *nineBtn;

@property (nonatomic, strong) HDDBaseLabel *titleLable;

@end

@implementation CustomKeyboard


-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self setup];
        [self setupBackView];
        [self setupHeaderView];
        [self setupProvinceView];
        [self setupLetterView];
    }
    return self;
}
+(CustomKeyboard *)initWithDelegate:(id)delegate{
    CustomKeyboard *keyboard=[[CustomKeyboard alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    keyboard.backgroundColor=[UIColor clearColor];
    keyboard.delegate=delegate;
    return keyboard;
}
-(void)setup{
    UIButton *hideBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight- 395 - kBottomBarHeight)];
    [hideBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:hideBtn];
    _letters=@[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"J",@"K",@"L",@"M",@"N",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"挂"];
    _provinces=@[@"京",@"津",@"冀",@"晋",@"蒙",@"辽",@"吉",@"黑",@"沪",@"苏",@"浙",@"皖",@"闽",@"赣",@"鲁",@"豫",@"鄂",@"湘",@"粤",@"桂",@"琼",@"渝",@"川",@"贵",@"云",@"藏",@"陕",@"甘",@"青",@"宁",@"新"];
    _values=[NSMutableArray array];
    _labels=[NSMutableArray array];
    _plateNumberLength = 7;
}
- (void)setupBackView {
    _backView=[[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 425)];
    _backView.backgroundColor=[UIColor whiteColor];
    [self addSubview:_backView];
}
-(void)setShowTrailer:(BOOL)showTrailer {
    _showTrailer = showTrailer;
    if (_showTrailer) {
       _titleLable.text = @"输入挂车车牌号";
    } else {
       _titleLable.text = @"输入车牌号";
    }
}
- (void)setupHeaderView {
    _headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 165)];
    _headerView.backgroundColor=[UIColor whiteColor];
    [_backView addSubview:_headerView];
    
    UIButton *cancel=[[UIButton alloc]initWithFrame:CGRectMake(15, 8, 44, 30)];
    [cancel setImage:[UIImage imageNamed:@"common_delete"] forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:cancel];
    
  
    _titleLable = [[HDDBaseLabel alloc]init];
    _titleLable.text = @"输入车牌号";
    _titleLable.LabelType = 1;
    _titleLable.textAlignment=NSTextAlignmentCenter;
    [_headerView addSubview:_titleLable];
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_headerView);
        make.top.mas_equalTo(15);
    }];
    
    UIButton *doneBtn=[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-50, 7, 44, 30)];
    doneBtn.enabled = NO;
    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [doneBtn setTitleColor:HexRGB(0xCFCFCF) forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:doneBtn];
    _doneBtn = doneBtn;
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 45, kScreenWidth, 1)];
    line.backgroundColor = KCustomAdjustColor(HexRGB(0xF0EFF4), HexRGB(0x3E3E3E));
    [_headerView addSubview:line];
    
    for (int i=0; i<_plateNumberLength; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(i*(32 + 13) + 45, 80, 32, 40)];
        view.tag = 9998 + i;
        [_headerView addSubview:view];
        
        HDDBaseLabel *label = [[HDDBaseLabel alloc]initWithFrame:CGRectMake(0, 0, 32, 40)];
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.borderColor = i == 0 ? HexRGB(0x27B57D).CGColor : HexRGB(0xA0A0A0).CGColor;
        label.layer.borderWidth = 1;
        label.layer.cornerRadius = 4;
        label.textColor = MainTextColor;
        label.LabelType = 1;
        [view addSubview:label];
        [_labels addObject:label];
    }
    
    UIButton *isNewEnergy=[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-150, 125, 150 , 35)];
    isNewEnergy.titleLabel.font = FontSize(15);
    [isNewEnergy setTitle:@" 新能源车" forState:UIControlStateNormal];
    [isNewEnergy setTitleColor:HexRGB(0x27B57D) forState:UIControlStateNormal];
    [isNewEnergy setImage:[UIImage imageNamed:@"choose_unselected"] forState:UIControlStateNormal];
    [isNewEnergy setImage:[UIImage imageNamed:@"choose_selected"] forState:UIControlStateSelected];
    [isNewEnergy addTarget:self action:@selector(isNewEnergyClick:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:isNewEnergy];
    self.isNewEnergy = isNewEnergy;
}
- (void)setupProvinceView {
    
    _provinceView=[[UIView alloc]initWithFrame:CGRectMake(0, 155, kScreenWidth, 395 + kBottomBarHeight - 155)];
    _provinceView.backgroundColor=WhiteColor;
    float viewWidth=(kScreenWidth-40)/9;
    
    for (int i=0; i<_provinces.count; i++) {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(i%9*viewWidth + 20, i/9*54+15, labelWidth, 42 + 12)];
        [_provinceView addSubview:view];
        
        UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, labelWidth, 42)];
        [btn setTitle:_provinces[i] forState:UIControlStateNormal];
        btn.tag=i;
        btn.titleLabel.font = [UIFont systemFontOfSize:18 weight:0.2];
        btn.layer.cornerRadius = 4;
        btn.layer.masksToBounds = YES;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = HexRGB(0xE0E0E0).CGColor;
        [btn setTitleColor:HexRGB(0x333333) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.layer.cornerRadius=4;
        [view addSubview:btn];
    }
    
    UIView *deleteView=[[UIView alloc]init];
    [_provinceView addSubview:deleteView];
    [deleteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-15 - kBottomBarHeight);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(42);
    }];
    
    UIButton *deleteBtn=[[UIButton alloc]init];
    [deleteBtn setImage:[UIImage imageNamed:@"icon_keyboard_delete"] forState:UIControlStateNormal];
    [deleteBtn setBackgroundColor:HexRGB(0xD8D8D8)];
    [deleteBtn addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    deleteBtn.layer.cornerRadius = 4;
    deleteBtn.layer.masksToBounds = YES;
    [deleteView addSubview:deleteBtn];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.width.height.mas_equalTo(deleteView);
    }];
    [_backView addSubview:_provinceView];
}
- (void)setupLetterView {
    _letterView=[[UIView alloc]initWithFrame:CGRectMake(0, 155, kScreenWidth, 395 + kBottomBarHeight - 155)];
    _letterView.hidden=YES;
    float viewWidth=(kScreenWidth-55)/10;
    for (int i=0; i<_letters.count; i++) {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(i%10*(viewWidth+5) + 5, i/10*54+15, viewWidth, 42 + 12)];
        view.tag = i;
        if (i == _letters.count - 1) {
            view.hidden = YES;
        }
        [_letterView addSubview:view];
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, viewWidth, 42)];
        btn.tag=i;
        btn.titleLabel.font = [UIFont systemFontOfSize:18 weight:0.2];
        btn.layer.cornerRadius = 4;
        btn.layer.masksToBounds = YES;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = HexRGB(0xE0E0E0).CGColor;
        if (i<10) {
            [btn setTitleColor:HexRGB(0x999999) forState:UIControlStateNormal];
        } else {
            [btn setTitleColor:HexRGB(0x333333) forState:UIControlStateNormal];
        }
        [btn setTitle:_letters[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.layer.cornerRadius=5;
        [view addSubview:btn];
        switch (i) {
            case 0:
                self.zeroBtn = btn;
                break;
            case 1:
                self.oneBtn = btn;
                break;
            case 2:
                self.twoBtn = btn;
                break;
            case 3:
                self.threeBtn = btn;
                break;
            case 4:
                self.fourBtn = btn;
                break;
            case 5:
                self.fiveBtn = btn;
                break;
            case 6:
                self.sixBtn = btn;
                break;
            case 7:
                self.sevenBtn = btn;
                break;
            case 8:
                self.eightBtn = btn;
                break;
            case 9:
                self.nineBtn = btn;
                break;
            default:
                break;
        }
    }
    
    UIView *deleteView=[[UIView alloc]init];
    deleteView.tag = _letters.count;
    [_letterView addSubview:deleteView];
    [deleteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-15 - kBottomBarHeight);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(42);
    }];
    
    UIButton *deleteBtn=[[UIButton alloc]init];
    [deleteBtn setImage:[UIImage imageNamed:@"icon_keyboard_delete"] forState:UIControlStateNormal];
    [deleteBtn setBackgroundColor:HexRGB(0xD8D8D8)];
    [deleteBtn addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    deleteBtn.layer.cornerRadius = 4;
    deleteBtn.layer.masksToBounds = YES;
    [deleteView addSubview:deleteBtn];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.width.height.mas_equalTo(deleteView);
    }];

    [_backView addSubview:_letterView];
}

//action
-(void)switchProvinceAndLetter:(UIButton*)sender{
    _provinceView.hidden=[sender.titleLabel.text isEqualToString:@"ABC"];
    _letterView.hidden=!_provinceView.hidden;
}
#pragma mark ============点击删除按钮===========
-(void)delete:(UIButton*)sender{
    //移除最后一位数据
    [_values removeLastObject];
    //自定义键盘未隐藏的话
    if (_letterView.hidden == NO) {
        if (_values.count <2) {
            [self isShowShallowColor];
        } else {
            [self isShowDeepColor];
        }
    }
    //修改挂车车牌 确定按钮可点击
    if (_values.count < _plateNumberLength) {
        _doneBtn.enabled = NO;
        [_doneBtn setTitleColor:HexRGB(0xCFCFCF) forState:UIControlStateNormal];
    }
    if (self.isChangeTrailer && [_values count] == 0) {
       _doneBtn.enabled = YES;
       [_doneBtn setTitleColor:HexRGB(0x27B57D) forState:UIControlStateNormal];
    }
    [self refreshData];
}
-(void)textChanged:(UIButton*)sender{
    NSString* value=_letterView.hidden==YES?_provinces[sender.tag]:_letters[sender.tag];
    if (_letterView.hidden == NO && _values.count <2) {
        if ([value isEqualToString:@"0"] ||
            [value isEqualToString:@"1"] ||
            [value isEqualToString:@"2"] ||
            [value isEqualToString:@"3"] ||
            [value isEqualToString:@"4"] ||
            [value isEqualToString:@"5"] ||
            [value isEqualToString:@"6"] ||
            [value isEqualToString:@"7"] ||
            [value isEqualToString:@"8"] ||
            [value isEqualToString:@"9"]) {
            return;
        }
        [self isShowDeepColor];
    }
    if (_values.count < _plateNumberLength) {
        [_values addObject:value];
    }
    [self dealDoneButtonEnableEvent];
    [self refreshData];
}
#pragma mark ============处理确定按钮能否点击事件===========
- (void)dealDoneButtonEnableEvent{
    if (_values.count < _plateNumberLength) {
        _doneBtn.enabled = NO;
        [_doneBtn setTitleColor:HexRGB(0xCFCFCF) forState:UIControlStateNormal];
    } else {
        _doneBtn.enabled = YES;
        [_doneBtn setTitleColor:HexRGB(0x27B57D) forState:UIControlStateNormal];
    }
    if ([_values count] == 0 && self.isChangeTrailer) {
        _doneBtn.enabled = YES;
        [_doneBtn setTitleColor:HexRGB(0x27B57D) forState:UIControlStateNormal];
    }
    
}
#pragma mark ============点击确定按钮===========
-(void)done{
    [self hide];
    if (self.isNewEnergy.selected) {
        [_delegate customKeyboard:self didFinished:[_values componentsJoinedByString:@""]];
    }else{
        if (self.values.count == 8) {
           [_values removeLastObject];
           [_delegate customKeyboard:self didFinished:[_values componentsJoinedByString:@""]];
        }else{
           [_delegate customKeyboard:self didFinished:[_values componentsJoinedByString:@""]];
        }
    }
}
-(void)refreshData{
    _provinceView.hidden=_values.count>0;
    _letterView.hidden=!_provinceView.hidden;
    //挂的话
    if (self.showTrailer && _values.count >= 6) {
        for (UIView *view in self.letterView.subviews) {
            if (view.tag < _letters.count - 1) {
                UIButton *btn  = view.subviews.firstObject;
                [btn setTitleColor:HexRGB(0x999999) forState:UIControlStateNormal];
                view.userInteractionEnabled = NO;
            }else if (view.tag == _letters.count - 1){
                view.userInteractionEnabled = YES;
                view.hidden = NO;
            }
        }
    }else{
        if (_letterView.hidden == NO) {
            for (UIView *view in self.letterView.subviews) {
                if (view.tag < _letters.count - 1) {
                    UIButton *btn  = view.subviews.firstObject;
                    [btn setTitleColor:HexRGB(0x333333) forState:UIControlStateNormal];
                    view.userInteractionEnabled = YES;
                }else if (view.tag == _letters.count - 1){
                    view.hidden = YES;
                }
            }
            if (_values.count <2) {
                [self isShowShallowColor];
            }
        }
    }
    for (int i=0; i<_plateNumberLength; i++) {
        HDDBaseLabel* label = self.labels[i];
        if (i+1 > self.values.count) {
            label.text=@"";
            label.layer.borderColor=i==_values.count?[UIColor redColor].CGColor:[UIColor blackColor].CGColor;
        }else{
            [label rounded:4 width:1 color:[UIColor blackColor]];
            [label setText:self.values[i]];
            label.textColor = HexRGB(0x333333);
        }
    }
}
//
-(void)show{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor=[UIColor colorWithWhite:0 alpha:.3];
        self->_backView.frame=CGRectMake(0, kScreenHeight - 405 - kBottomBarHeight, kScreenWidth, 405);
        if (self.vehicleNo.length) {
            self.values = [self.vehicleNo getCharacter];
            self.doneBtn.enabled = YES;
            [self isShowDeepColor];
            [self.doneBtn setTitleColor:HexRGB(0x27B57D) forState:UIControlStateNormal];
            if (self.vehicleNo.length == 8) {
                self.plateNumberLength = 8;
                [self ishowLastLabel:YES];
                self.isNewEnergy.selected = YES;
            }
            [self refreshData];
        }
        //挂车的话，隐藏新能源
        if (self.showTrailer) {
            self.isNewEnergy.hidden = YES;
        }
    }];
}
-(void)hide{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor=[UIColor clearColor];
        self->_backView.frame=CGRectMake(0, kScreenHeight, kScreenWidth, 465 - kBottomBarHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)cancelClick {
    [self hide];
}
#pragma mark ============点击新能源按钮事假===========
- (void)isNewEnergyClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    _plateNumberLength = sender.selected ? 8 : 7;
    [self ishowLastLabel: sender.selected];
    [self dealDoneButtonEnableEvent];
}

- (void)ishowLastLabel:(BOOL)ishow {
    if (ishow) {
        if (_labels.count == 8) {
             [_labels.lastObject removeFromSuperview];
        }
        for (int i = 0; i < _plateNumberLength; i++) {
            if (self.headerView.subviews[i].tag >=1000) {
                
            }
        }
        NSInteger index = 1;
        for (UIView *subView in self.headerView.subviews) {
            if (subView.tag > 9998) {
                subView.x = subView.x - 5*index;
                index++;
            }
        }
        UIView* view=[[UIView alloc]initWithFrame:CGRectMake(7*(32 + 8) + 45, 80, 30, 40)];
        [_headerView addSubview:view];
        HDDBaseLabel* label=[[HDDBaseLabel alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.borderWidth = 1;
        label.layer.borderColor = HexRGB(0xA0A0A0).CGColor;
        label.layer.cornerRadius = 4;
        label.textColor = MainTextColor;
        if (self.values.count == 8) {
            label.text = self.values.lastObject;
            label.layer.borderColor=[UIColor blackColor].CGColor;
        }
        [view addSubview:label];
        [_labels addObject:label];
    } else {
        NSInteger index = 1;
        for (UIView *subView in self.headerView.subviews) {
            if (subView.tag > 9998) {
                subView.x = subView.x + 5*index;
                index++;
            }
        }
        [_labels.lastObject removeFromSuperview];
        [_labels removeLastObject];
    }
}

-(UIColor*)randomColor{
    CGFloat hue = (arc4random() %256/256.0);
    CGFloat saturation = (arc4random() %128/256.0) +0.5;
    CGFloat brightness = (arc4random() %128/256.0) +0.5;
    UIColor*color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}

- (void)isShowShallowColor {
    [self.zeroBtn setTitleColor:HexRGB(0x999999) forState:UIControlStateNormal];
    [self.oneBtn setTitleColor:HexRGB(0x999999) forState:UIControlStateNormal];
    [self.twoBtn setTitleColor:HexRGB(0x999999) forState:UIControlStateNormal];
    [self.threeBtn setTitleColor:HexRGB(0x999999) forState:UIControlStateNormal];
    [self.fourBtn setTitleColor:HexRGB(0x999999) forState:UIControlStateNormal];
    [self.fiveBtn setTitleColor:HexRGB(0x999999) forState:UIControlStateNormal];
    [self.sixBtn setTitleColor:HexRGB(0x999999) forState:UIControlStateNormal];
    [self.sevenBtn setTitleColor:HexRGB(0x999999) forState:UIControlStateNormal];
    [self.eightBtn setTitleColor:HexRGB(0x999999) forState:UIControlStateNormal];
    [self.nineBtn setTitleColor:HexRGB(0x999999) forState:UIControlStateNormal];
}

- (void)isShowDeepColor {
    [self.zeroBtn setTitleColor:HexRGB(0x333333) forState:UIControlStateNormal];
    [self.oneBtn setTitleColor:HexRGB(0x333333) forState:UIControlStateNormal];
    [self.twoBtn setTitleColor:HexRGB(0x333333) forState:UIControlStateNormal];
    [self.threeBtn setTitleColor:HexRGB(0x333333) forState:UIControlStateNormal];
    [self.fourBtn setTitleColor:HexRGB(0x333333) forState:UIControlStateNormal];
    [self.fiveBtn setTitleColor:HexRGB(0x333333) forState:UIControlStateNormal];
    [self.sixBtn setTitleColor:HexRGB(0x333333) forState:UIControlStateNormal];
    [self.sevenBtn setTitleColor:HexRGB(0x333333) forState:UIControlStateNormal];
    [self.eightBtn setTitleColor:HexRGB(0x333333) forState:UIControlStateNormal];
    [self.nineBtn setTitleColor:HexRGB(0x333333) forState:UIControlStateNormal];
}

@end
