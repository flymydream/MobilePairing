//
//  HDDInputCheckTool.h
//  Shipper
//
//  Created by caesar on 2021/6/8.
//  Copyright © 2021 caesar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDDInputCheckTool : NSObject
//显示输入框小数点和小数点后两位
+ (void)limitTextFieldTextDecimalPointAfterTheTwo:(UITextField *)textField;
//是否是纯汉字
+ (BOOL)isChinese:(NSString *)content;
@end

NS_ASSUME_NONNULL_END
