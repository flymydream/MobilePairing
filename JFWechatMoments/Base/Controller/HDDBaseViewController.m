//
//  HDDBaseViewController.m
//  Driver
//
//  Created by caesar on 2020/1/16.
//  Copyright © 2020 caesar. All rights reserved.
//

#import "HDDBaseViewController.h"
@interface HDDBaseViewController ()

@end

@implementation HDDBaseViewController
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
#pragma mark ============设置右侧按钮===========
- (void)setupRightItem{
    
    UIButton *rightButton = [[UIButton alloc] init];
    [rightButton setTitle:@"查询" forState:UIControlStateNormal];
    [rightButton setTitleColor:WhiteColor forState:UIControlStateNormal];
    rightButton.titleLabel.font = FontSize(16);
    rightButton.titleEdgeInsets = UIEdgeInsetsMake(0,0,0,-10);
    [rightButton addTarget:self action:@selector(clickRightButtonItem:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.hidden = YES;
    self.rightButton = rightButton;
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
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
