//
//  HDDBaseSubViewController.m
//  Driver
//
//  Created by caesar on 2020/6/20.
//  Copyright © 2020 caesar. All rights reserved.
//

#import "HDDBaseSubViewController.h"

@interface HDDBaseSubViewController ()

@end

@implementation HDDBaseSubViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:[NSString stringWithUTF8String:object_getClassName(self)]];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:[NSString stringWithUTF8String:object_getClassName(self)]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KCustomAdjustColor(BGMainColor, DARKAppColor);
    [self setupRightItem];
}
#pragma mark ============设置导航右侧按钮===========
- (void)setupRightItem{
    
    UIButton *rightButton = [[UIButton alloc] init];
    [rightButton setTitle:@"查询" forState:UIControlStateNormal];
    [rightButton setTitleColor:WhiteColor forState:UIControlStateNormal];
    rightButton.titleLabel.font = FontSize(16);
    rightButton.titleEdgeInsets = UIEdgeInsetsMake(0,0,0,-10);
    [rightButton addTarget:self action:@selector(clickRightButtonItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    _rightButton = rightButton;
    rightButton.hidden = YES;
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:(UIBarButtonItemStyleDone) target:self action:@selector(back)];
    
}
- (void)setBtnText:(NSString *)btnText{
    _btnText = btnText;
    if (btnText.length) {
       [_rightButton setTitle:btnText forState:UIControlStateNormal];
    }
}
-(void)back
{
    if(self.navigationController.viewControllers.count <= 1)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark ============点击右侧按钮===========
- (void)clickRightButtonItem:(UIButton *)sender{
    
}
- (void)dealloc{
    
    NSLog(@"%@ 控制器 销毁了",NSStringFromClass([self class]));
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


@end
