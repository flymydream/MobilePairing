//
//  HDDVehicleNumberKeyBoardView.h
//  Shipper
//
//  Created by caesar on 2021/3/2.
//  Copyright © 2021 caesar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//键盘view的代理，用来监控键盘输入
@protocol HDDVehicleNumberKeyBoardViewDelegate <NSObject>

//点击键盘上的按钮
- (void)clickWithString:(NSString *)string;

//点击删除按钮
- (void)deleteBtnClick;
//键盘回收
- (void)keyboardHidden;

@end
@interface HDDVehicleNumberKeyBoardView : UIView

@property (nonatomic, weak) id<HDDVehicleNumberKeyBoardViewDelegate> delegate;

//公共方法 - 字符串已经删除完毕
- (void)deleteEnd;
- (void)showWithString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
