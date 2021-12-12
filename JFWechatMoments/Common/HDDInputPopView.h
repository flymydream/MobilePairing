//
//  HDDInputPopView.h
//  Shipper
//
//  Created by caesar on 2021/9/6.
//  Copyright © 2021 caesar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDDInputPopView : UIView
@property (nonatomic, strong) NSString *titleString;//标题。默认温馨提示
//确定按钮的回调事件
@property (nonatomic,copy) void(^clickConfirmButtonBlock)(NSString *inputStr);
//取消按钮的回调事件
@property (nonatomic,copy) void(^clickCancelButtonBlock)(void);

+ (instancetype)defaultInputPopView;
- (void)showInputRemindPopView;
- (void)hiddenInputRemindPopView;
@end

NS_ASSUME_NONNULL_END
