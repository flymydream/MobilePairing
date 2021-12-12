//
//  UITextField+ExtentRange.h
//  Driver
//
//  Created by caesar on 2020/7/15.
//  Copyright © 2020 caesar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (ExtentRange)
- (NSRange) selectedRange;
- (void) setSelectedRange:(NSRange) range;

@end

NS_ASSUME_NONNULL_END
