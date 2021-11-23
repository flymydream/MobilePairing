//
//  WebImageManageTests.m
//  JFWechatMomentsTests
//
//  Created by hero on 2021/11/23.
//  Copyright © 2021 fanzhiying. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WebImageManage.h"

@interface WebImageManageTests : XCTestCase

@end

@implementation WebImageManageTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testExample {
   
}

- (void)testPerformanceExample {
    [self measureBlock:^{
        [[WebImageManage shareWebImageManage] getImageWithURL:@"https://thoughtworks-mobile-2018.herokuapp.com/images/user/profile-image.jpg" DownloadCompletedBlock:^(UIImage *image, NSError *error, BOOL success) {
            if (success) {
                NSLog(@"WebImageManage获取图片完成");
            }
        }];
    }];
}

@end
