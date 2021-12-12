//
//  HDDBaseTabelView.h
//  Driver
//
//  Created by caesar on 2020/1/17.
//  Copyright © 2020 caesar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDDBaseTabelView : UITableView
- (void)registerNibIdentifier:(NSString *)identifier;
- (void)registerClassIdentifier:(NSString *)identifier;
@property (strong, nonatomic) NSString * identifier;
@property (nonatomic, strong) NSString *remindStr;//提示语

@end

NS_ASSUME_NONNULL_END
