//
//  HDDBaseCell.h
//  Driver
//
//  Created by caesar on 2020/1/17.
//  Copyright © 2020 caesar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class HDDBaseCell;

@protocol BaseCellDelegate<NSObject>

@optional
- (void)cell:(HDDBaseCell*)cell didClickButtonWithTag:(NSInteger)tag forModel:(id)model;
@end

@interface HDDBaseCell : UITableViewCell

@property (weak, nonatomic) id <BaseCellDelegate> delegate;
@property (strong, nonatomic) id model;

@end

NS_ASSUME_NONNULL_END
