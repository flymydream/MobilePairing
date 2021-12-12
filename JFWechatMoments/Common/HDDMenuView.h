//
//  HDDMenuView.h
//  Shipper
//
//  Created by caesar on 2021/3/4.
//  Copyright © 2021 caesar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDDMenuView : UIView
@property (nonatomic, strong) NSMutableArray *titleSource;
@property (nonatomic,copy) void(^clickMenuSelctedText)(NSString *string);

@end

NS_ASSUME_NONNULL_END
