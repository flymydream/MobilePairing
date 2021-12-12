//
//  NSString+Extension.h
//  Shipper
//
//  Created by caesar on 2020/1/11.
//  Copyright © 2020 huodada. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extension)

//设置苹果加粗字体
+ (UIFont *)setHelveticaBoldFont:(int)fontSize;
//设置字体的黑体
+ (UIFont *)setPingFangSCMediumFont:(int)fontSize;
//手机号的判断
+ (BOOL)isPhoneNumber:(NSString *)number;
//替换空格操作
- (NSString *)replaceSpaceString;
////正则匹配用户登录密码8-16位数字,字母,数字和字母组合(只有登录密码)
+(BOOL)detectionIsPasswordQualified:(NSString *)inputStr;
//正则匹配数字,字母,数字和字母组合(支付密码)
+(BOOL)checkIsPaymentPasswordQualified:(NSString *)inputStr;
//判断字符为空或者是空格
+ (BOOL)isBlankString:(NSString *)string;
//返回保留字符串的位数
+ (NSString *)keepDecimalpointAfterDigits:(NSInteger)digits withNeedKeepObj:(CGFloat)obj;
//MD5加密
+ (NSString*)stringToMD5:(NSString *)str;
//检查银行卡的正确性
+ (BOOL)checkCardNo:(NSString*)cardNo;
//校验车牌号的方法
+ (BOOL)checkVehicleNoMethod:(NSString *)vehicleNo;
//对比两个数组对象中，数值是否相等
+ (BOOL)compareArrayValuesIsEqual:(NSArray *)oldArrObj withNewArray:(NSArray *)newArrObj;
//拼接成中间有空格的字符串
+ (NSString *)jointWithString:(NSString *)str;
//精确的身份证号码有效性检测
+ (BOOL)accurateVerifyIDCardNumber:(NSString *)value;
//替换账单中的名称
+ (NSString *)replaceBillName:(NSString*)originalName;
// 在指定的位置添加空格
+(NSString*)insertString:(NSString*)string withBlankLocations:(NSArray<NSNumber *>*)locations;
//正则表达式只能输入汉字
+ (NSString *)filterNonChineseCharactor:(NSString *)string;
//正则表达式只能输入身份证号
+ (BOOL)filterNonCardIDWithTextField:(UITextField *)textField withInputString:(NSString *)string;
//只能输入数字
+ (BOOL)filterNonNumberWithTextField:(UITextField *)textField withInputString:(NSString *)string;
//可以输入数字、字母
+ (BOOL)filterNumberOrLetterWithTextField:(UITextField *)textField withInputString:(NSString *)string;
//浮点数处理并去掉多余的0
+ (NSString *)stringDisposeWithFloat:(double)floatValue;
//判断字符串中是否有连续相等的字符
+ (NSArray *)judgeCharacterEquel:(NSString *)firstStr withSecondString:(NSString *)secondStr;
//获取字符转数组
- (NSMutableArray *)getCharacter;
//连续相同的六位数字判断正则111111
- (BOOL)validateSameNumber;
//连续六位数字判断正则123456
- (BOOL)validateContinuousNumber;
//字符串脱敏处理，前面4位，后面4位，中间字符加密处理
- (NSString *)middleStringDesensitization;
//适配单位背景，提示文字和主文字的颜色
+ (void)configUnitBC:(UIView*)bgView withPlaceColor:(UILabel *)label withMainTextColor:(UIView*)mainLabel;
//获取首字母
+(NSString *)firstCharactor:(NSString *)name;
/**
 整数转小数点后几位并且防止崩溃处理
 */
+ (NSString *)toDealWithDecimalPoint:(NSString *)price afterPoint:(NSInteger)position ;

/**
获取当前是第几个派单
*/
+(NSString *)getStringBgSection:(NSInteger)section;

/**
替换固定字文字颜色和字体大小
changeColor 被替换的文字颜色
changeFont 被替换的文字大小
*/
+ (NSMutableAttributedString *)changePartRichText:(NSString *)text changeStr:(NSString *)changeStr changeColor:(UIColor *)changeColor changeFont:(UIFont *)changeFont;
/**
富文本设置部分字体颜色
*/
+ (NSMutableAttributedString *)setupAttributeString:(NSString *)text changeStr:(NSString *)changeStr changeColor:(UIColor *)changeColor changeFont:(UIFont *)changeFont;

/*
 通过计价方式获取对应的单位
 */
+ (NSString *)getUnitStringByPriceMethod:(NSInteger)priceMethod;
/**
 通过收款方式获取收款字符
 */
+ (NSString *)getPeymentMethodBySettlementObject:(NSInteger)settlementObject;

/**
 判断字符串是否为0
 */
- (BOOL)judgeLoadNumberIsZero;
/**校验货源名称是否是汉字/( ) - 这些字符组成*/
+(BOOL)checkGoodsName:(NSString *)name;

/**获取能源类型*/
+(NSArray *)getEnergyCodeSc:(NSString *)energyCodeSc;
/**获取油卡类型*/
+(NSString *)getOilBrandByOilName:(NSString *)oilName;

//获取身份证中的出生日期
+ (NSString *)getBirthdayByCardIdNo:(NSString*)cardidNo;

//把字符串转为 cgfloat 保留
+(CGFloat)transformTextToFloat:(NSString *)num;

/**
判断字符串中有几个汉字
*/
+(NSInteger)hasChineseCount:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
