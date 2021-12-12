//
//  HDDBaseViewController.h
//  Driver
//
//  Created by caesar on 2020/1/16.
//  Copyright © 2020 caesar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDDBaseViewController : UIViewController
@property (nonatomic, strong) UIButton *rightButton;
//点击右侧按钮事件
- (void)clickRightButtonItem:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
