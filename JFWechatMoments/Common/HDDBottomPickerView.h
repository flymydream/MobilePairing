//
//  HDDBottomPickerView.h
//  Shipper
//
//  Created by caesar on 2021/2/22.
//  Copyright © 2021 caesar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDDBottomPickerView : UIView

@property (nonatomic,copy) void(^clickSurePickerBlock)(NSString *titleStr,NSInteger index);
@property (nonatomic,copy) void(^clickPickerSureBlock)(NSString *titleStr);
@property (nonatomic, strong) NSArray *pickArray;
@property (nonatomic, strong) NSString *themeText;//标题
@property (nonatomic, strong) NSString *showContent;//展示的内容
+ (instancetype)defaultPickerView;
- (void)showPickerView;

@end

NS_ASSUME_NONNULL_END
