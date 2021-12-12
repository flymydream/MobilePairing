//
//  HDDHeaderSearchView.h
//  Shipper
//
//  Created by caesar on 2021/3/31.
//  Copyright © 2021 caesar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDDHeaderSearchView : UIView
@property (nonatomic,copy) void(^inputSearchContentBlock)(NSString* searchStr);
+ (instancetype)defaultHeaderSearchView;
@property (nonatomic, strong) NSString *placeholderStr;

@end

NS_ASSUME_NONNULL_END
