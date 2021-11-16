//
//  Tweet.m
//  JFWechatMoments
//

#import "Tweet.h"
#import <UIKit/UIKit.h>

@implementation Tweet

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"comments": @"Comment"};
}

- (void)setIsOpening:(BOOL)isOpening {
    if (_shouldShowMoreButton == NO) {
        _isOpening = NO;
    } else {
        _isOpening = isOpening;
    }
}

@end
