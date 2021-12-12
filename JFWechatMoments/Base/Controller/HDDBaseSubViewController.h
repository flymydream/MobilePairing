//
//  HDDBaseSubViewController.h
//  Driver
//
//  Created by caesar on 2020/6/20.
//  Copyright © 2020 caesar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//二级页面的基类控制器
@interface HDDBaseSubViewController : UIViewController

@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) NSString *btnText;

//点击右侧按钮
- (void)clickRightButtonItem:(UIButton *)sender;
- (void)back;
@end

NS_ASSUME_NONNULL_END
