//
//  HDDMediaViewer.h
//  Driver
//
//  Created by caesar on 2020/7/1.
//  Copyright © 2020 caesar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDDMediaViewer : UIView
typedef void (^finshBlock)(void);
+ (void)showImage:(NSString *)imageURL withSourceView:(UIImageView *)sourceView;
+ (void)showImages:(NSArray *)imageURLs withSourceView:(UIImageView *)sourceView atIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
