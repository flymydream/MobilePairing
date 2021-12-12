//
//  HDDCallPhoneTool.h
//  Driver
//
//  Created by caesar on 2020/1/22.
//  Copyright © 2020 caesar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDDCallPhoneTool : NSObject
//拨打电话的方法
+ (void)openCallPhoneNumber:(NSString *)urlString;
//识别客服电话，并且拨打客服电话
+ (void)distinguishPhoneNumLabel:(UILabel *)label labelStr:(NSString *)labelStr;
@end

NS_ASSUME_NONNULL_END
