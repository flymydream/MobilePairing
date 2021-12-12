//
//  HDDRegularCheckTool.h
//  Driver
//
//  Created by caesar on 2020/1/17.
//  Copyright © 2020 caesar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDDRegularCheckTool : NSObject
/**校验车牌号码*/
+ (BOOL)validateCarNo:(NSString *)carNo;

/**校验用户姓名*/
+ (BOOL)validateUserName:(NSString *)userName;

/**校验电话号码 不建议使用*/
//+ (BOOL)validateMobile:(NSString *)mobileNum;

/** 字符串是否为纯数字*/
+ (BOOL)isAllNum:(NSString *)string;

/**字符串是否为空*/
+ (BOOL)isBlankString:(NSString *)string;

/**判断字典key 和 判断 值是否为空*/
+ (BOOL)isBlank:(NSDictionary *)dic key:(NSString *)key;

//显示输入框小数点和小数点后两位
+ (void)limitTextFieldTextDecimalPointAfterTheTwo:(UITextField *)textField;
//传入位数
+(BOOL)dealWithPointWithTextField:(UITextField *)textField current:(NSString *)current limitNum:(NSInteger)limitNum;
//限制textField输入0-100000的数 并且保留after位
+ (BOOL)limitTextFieldDecimalPoint:(UITextField *)textField range:(NSRange)range tring:(NSString *)string pfrefix:(NSString *)pfrefix maxValue:(int)maxValue after:(int)after;
/**检验是否正确的银行卡号*/
+ (BOOL)validateBankCardNo:(NSString*)cardNo;
/**银行卡校验*/
+(BOOL)checkBankCardNumber:(NSString *)cardNumber;
/**身份证校验规则*/
+(BOOL)validateUserIdentityCard:(NSString *)userID;

@end

NS_ASSUME_NONNULL_END
