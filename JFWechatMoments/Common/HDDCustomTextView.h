//
//  HDDCustomTextView.h
//  Driver
//
//  Created by caesar on 2020/6/28.
//  Copyright © 2020 caesar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger,placeholderLocation){
    PlaceholderLocationTop = 0,
    PlaceholderLocationCenter,
    PlaceholderLocationBottom,
    PlaceholderLocationRight,
};

@interface HDDCustomTextView : UITextView
@property (strong, nonatomic) UILabel *placeholderLabel;
@property (strong, nonatomic) UIColor *placeholderColor;
@property (strong, nonatomic) NSString *placeholderText;
@property (nonatomic,assign) NSInteger lengthMax;
@property (nonatomic,assign) placeholderLocation placeholderLocation;
@property (nonatomic,assign) BOOL showNumber;//显示字数
@property (strong, nonatomic) UILabel *numberLabel;
@end

NS_ASSUME_NONNULL_END
