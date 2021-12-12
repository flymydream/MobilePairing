//
//  UIView+netError.h
//  Driver
//
//  Created by caesar on 2020/1/19.
//  Copyright © 2020 caesar. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HDDNetErrorPageView;

NS_ASSUME_NONNULL_BEGIN

@interface UIView (netError)
//CDMNetErrorPageView
@property (nonatomic,strong) HDDNetErrorPageView * netErrorPageView;
- (void)configReloadAction:(void(^)(void))block;
- (void)showNetErrorPageView;
- (void)hideNetErrorPageView;
@end

NS_ASSUME_NONNULL_END


#pragma mark --- HDDNetErrorPageView
@interface HDDNetErrorPageView : UIView
@property (nonatomic,copy) void(^ _Nullable didClickReloadBlock)(void);
@end
