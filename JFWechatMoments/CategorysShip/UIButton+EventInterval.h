//
//  UIButton+EventInterval.h
//  Driver
//
//  Created by caesar on 2020/4/2.
//  Copyright © 2020 caesar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
#define defaultInterval 0.5  //默认时间间隔
@interface UIButton (EventInterval)

///**设置点击时间间隔*/
@property (nonatomic, assign) NSTimeInterval timeInterval;
/**bool 类型   设置是否执行点UI方法*/
@property (nonatomic, assign) BOOL isIgnoreEvent;
//开始加载动画
- (void)startButtonActivityIndicatorView;
//停止加载动画
- (void)endButtonActivityIndicatorView;
@end

NS_ASSUME_NONNULL_END
