//
//  HDDBottomView.h
//  Shipper
//
//  Created by caesar on 2021/3/1.
//  Copyright © 2021 caesar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDDBottomView : UIView
@property (nonatomic,copy) void(^clickBottomActionBlock)(void);
@property (nonatomic, strong) NSString *textString;

@end

NS_ASSUME_NONNULL_END
