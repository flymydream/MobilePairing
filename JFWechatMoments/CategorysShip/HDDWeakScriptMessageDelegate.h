//
//  HDDWeakScriptMessageDelegate.h
//  Driver
//
//  Created by caesar on 2020/2/28.
//  Copyright © 2020 caesar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDDWeakScriptMessageDelegate : NSObject<WKScriptMessageHandler>

@property (nonatomic,weak)id<WKScriptMessageHandler> scriptDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end

NS_ASSUME_NONNULL_END
