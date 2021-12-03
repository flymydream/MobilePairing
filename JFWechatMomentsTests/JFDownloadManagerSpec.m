//
//  JFDownloadManagerSpec.m
//  JFWechatMoments
//
//  Created by hero on 2021/11/23.
//  Copyright 2021 fanzhiying. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "JFDownloadManager.h"


SPEC_BEGIN(JFDownloadManagerSpec)

describe(@"JFDownloadManager", ^{
    context(@"when created", ^{
        __block JFDownloadManager *manager = nil;
        beforeEach(^{
            manager = [JFDownloadManager shareDownloadManage];
        });
        afterEach(^{
            manager = nil;
        });
        it(@"should return a image", ^{
            [manager jf_getImageWithUrl:@"https://thoughtworks-mobile-2018.herokuapp.com/images/user/profile-image.jpg" placeholderImage:nil completeCallback:^(UIImage * _Nonnull picImage) {
                [[expectFutureValue(picImage) shouldEventually] beNonNil];
            }];
        });
 
        
    });
   
});

SPEC_END
