//
//  HDDBaseNavigationController.h
//  Driver
//
//  Created by caesar on 2020/1/16.
//  Copyright © 2020 caesar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDDBaseNavigationController : UINavigationController
@property (nonatomic,assign) BOOL editing;//是否编辑
@property (nonatomic,assign) BOOL backHome;//返回到首页
//禁用边缘侧滑手势
- (void)enableScreenEdgePanGestureRecognizer:(BOOL)isEnable;

@end

NS_ASSUME_NONNULL_END
