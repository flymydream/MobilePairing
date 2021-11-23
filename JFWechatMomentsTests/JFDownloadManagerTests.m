//
//  JFDownloadManagerTests.m
//  JFWechatMomentsTests
//
//  Created by hero on 2021/11/23.
//  Copyright © 2021 fanzhiying. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "JFDownloadManager.h"

@interface JFDownloadManagerTests : XCTestCase

@end

@implementation JFDownloadManagerTests

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
        //测试性能
        [[JFDownloadManager shareDownloadManage] jf_getImageWithUrl:@"https://thoughtworks-mobile-2018.herokuapp.com/images/user/profile-image.jpg" placeholderImage:[UIImage imageNamed:@"ic_bg_header"] completeCallback:^(UIImage * _Nonnull picImage) {
            NSLog(@"JFDownloadManager获取图片完成");
        }];
        
    }];
}

@end
