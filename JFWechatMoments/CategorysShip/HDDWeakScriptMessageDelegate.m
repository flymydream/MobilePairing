//
//  HDDWeakScriptMessageDelegate.m
//  Driver
//
//  Created by caesar on 2020/2/28.
//  Copyright © 2020 caesar. All rights reserved.
//

#import "HDDWeakScriptMessageDelegate.h"

@implementation HDDWeakScriptMessageDelegate

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate{
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
}


- (void)dealloc {
    
}
@end
