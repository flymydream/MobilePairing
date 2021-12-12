//
//  HDDPromptPopView.h
//  Driver
//
//  Created by caesar on 2020/7/29.
//  Copyright © 2020 caesar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDDPromptPopView : UIView
//右侧按钮的回调事件
@property (nonatomic,copy) void(^clickRightButtonBlock)(void);
//左侧按钮的回调事件
@property (nonatomic,copy) void(^clickCancelButtonBlock)(void);
//点击知道了按钮的回调事件
@property (nonatomic,copy) void(^clickKnowButtonBlock)(void);

@property (nonatomic,assign) BOOL isRegularPhone;//是否验证客户电话
@property (nonatomic, strong) NSString *titleString;//标题。默认温馨提示
@property (nonatomic, strong) NSString *imageName;//标题
@property (nonatomic,assign) BOOL isShowLeftImage;//是否显示左侧图标
/**
底部显示两个按钮
 @param contentStr 中间的内容
 @param titleStr 右侧按钮的标题
 @param cancelString 左侧按钮的标题
*/
- (void)setShowDoubleButtonContentString:(NSString *)contentStr rightTitleString:(NSString *)titleStr cancelString:(NSString *)cancelString;
/**
底部显示两个按钮
 @param contentStr 中间的内容
  右侧按钮的标题为确定
  左侧按钮的标题为取消
*/
- (void)setShowDoubleSureButtonContentString:(NSString *)contentStr;

/**
 显示底部单个按钮
 @param contentStr 中间的内容
  底部按钮的标题为知道了
 */
- (void)setShowSingleKnowButtonContentString:(NSString *)contentStr;

/**
 显示底部单个按钮
 @param contentStr 中间的内容
 @param titleStr 底部按钮的标题
 */
- (void)setShowSingleButtonContentString:(NSString *)contentStr signleString:(NSString *)titleStr;

//显示提示视图
- (void)showRemindPopView;
//初始化提示视图
+ (instancetype)defaultPopView;
@end

NS_ASSUME_NONNULL_END
