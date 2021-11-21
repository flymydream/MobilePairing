//
//  NetRequestSpec.m
//  JFWechatMoments
//
//  Created by hero on 2021/11/21.
//  Copyright 2021 fanzhiying. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "NetRequest.h"


SPEC_BEGIN(NetRequestSpec)

describe(@"NetRequest", ^{
    context(@"request service user data", ^{
        __block BOOL isExecuteSuccess = NO;
        __block NSDictionary *fetchedData = nil;
        //当前scope内部的所有的其他block运行之前调用一次
//        beforeAll(^{
//
//        });
//        //当前scope内部的所有的其他block运行之后调用一次
//        afterAll(^{
//
//        });
        //在scope内的每个it之前调用一次，对于context的配置代码应该写在这里
        beforeEach(^{
             [NetRequest requestGetWithUrl:@"user/jsmith" success:^(id response) {
                 NSLog(@"That's it! %@", response);
                 isExecuteSuccess = YES;
                 fetchedData = (NSDictionary *)response;
             } failure:^(NSError *error) {
                 NSLog(@"have error! %@",error);
             }];
        });
        
        //在scope内的每个it之后调用一次，用于清理测试后的代码
//        afterEach(^{
//
//        });
        
        it(@"should eventually call successBlock", ^{
            [[expectFutureValue(theValue(isExecuteSuccess)) shouldEventually] beYes];
            [[expectFutureValue(fetchedData) shouldEventually] beNonNil];
        });
     
    });

    
});

SPEC_END
