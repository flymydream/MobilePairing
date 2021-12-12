//
//  NSString+Extension.m
//  Shipper
//
//  Created by caesar on 2020/1/11.
//  Copyright © 2020 huodada. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonCrypto.h>
@implementation NSString (Extension)
//设置字体的黑体
+ (UIFont *)setHelveticaBoldFont:(int)fontSize{
    return [UIFont fontWithName:@"Helvetica-Bold" size:fontSize];
}
//设置加粗字体
+ (UIFont *)setPingFangSCMediumFont:(int)fontSize{
    return [UIFont fontWithName:@"PingFangSC-Medium" size:fontSize];
    
}
//手机号的判断
+ (BOOL)isPhoneNumber:(NSString *)number{
    
    if (number.length != 11){
//        [HDDCustomToastView toastMessage:@"输入手机位数有误"];
        return NO;
    }
//    中国电信号段为：133、149、153、173、177。还有180、181、189、199。
//    中国联通号段：130、131、132、145、155、156、166、171、175、176、185、186、166。
// 中国移动号段：134(0-8)、135、136、137、138、139、147、150、151、152、157、158、159、172、178、182、183、184、187、188、198。
 //^(((13[0-9]{1})|(15[0-9]{1})|(16[0-9]{1})|(17[3-8]{1})|(18[0-9]{1})|(19[0-9]{1})|(14[5-7]{1}))+\d{8})$
//    NSString *MOBILE = @"^1(3[0-9]|4[579]|5[0-35-9]|6[6]|7[0-35-9]|8[0-9]|9[89])\\d{8}$";
    
    NSString *MOBILE = @"^1[3456789]\\d{9}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:number];
    
//    NSString *MOBILE = @"(^1\\d{10}$)";
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    if ([regextestmobile evaluateWithObject:number] == YES){
//        return YES;
//    }else{
//        return NO;
//    }

    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */

//    NSString *MOBILE = @"^1((3[0-9]|4[57]|5[0-35-9]|7[03678]|8[0-9])\\d{8}$)";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 134(0-8)、135、136、137、138、139、147、150、151、152、157、158、159、172、178、182、183、184、187、188、198
     */
//    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,175,176,1709
     * 130、131、132、155、156、166、175、176、185、186、166
     */

//    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[5]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700,166,199,198
     * 133、153、173、177、180、181、189、191、193、199
     *
     */

//    NSString *CT = @"(^1(33|53|77|8[019]|9[89]|66)\\d{8}$)|(^1700\\d{7}$)";
//
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//
//    if (([regextestmobile evaluateWithObject:number] == YES)
//        || ([regextestcm evaluateWithObject:number] == YES)
//        || ([regextestct evaluateWithObject:number] == YES)
//        || ([regextestcu evaluateWithObject:number] == YES)){
//
//          return YES;
//      }else{
//          return NO;
//      }
}
//精确的身份证号码有效性检测
+ (BOOL)accurateVerifyIDCardNumber:(NSString *)value{
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
 
    int length =0;
    if (!value) {
        return NO;
    }else {
        length = (int)value.length;
 
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
 
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag =NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
 
    if (!areaFlag) {
        return false;
    }
 
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
 
    int year =0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
 
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
 
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
 
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
 
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
 
            if(numberofMatch >0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
 
            }else {
                return NO;
            }
        default:
            return NO;
    }
}

//替换空格操作
- (NSString *)replaceSpaceString{
    
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

//正则匹配用户登录密码８-16位数字,字母,数字和字母组合(只有登录密码)
+(BOOL)detectionIsPasswordQualified:(NSString *)inputStr{
    NSString *pattern = @"^(?![a-zA-Z]+$)(?![0-9]+$)([a-zA-Z0-9]{8,16})$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:inputStr];
    return isMatch;
}
//正则匹配数字,字母,数字和字母组合(支付密码)
+(BOOL)checkIsPaymentPasswordQualified:(NSString *)inputStr{
    NSString *pattern = @"^[a-zA-Z0-9]{6,18}+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:inputStr];
    return isMatch;
}
//判断字符为空或者是空格
+ (BOOL)isBlankString:(NSString *)string{
   if (string == nil){
        return YES;
   }
  if (string == NULL){
      return YES;
   }
   if ([string isKindOfClass:[NSNull class]]){
        return YES;
    }
  if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0){
      
        return YES;
     }
    return NO;
 }
// 在指定的位置添加空格
+(NSString*)insertString:(NSString*)string withBlankLocations:(NSArray<NSNumber *>*)locations {
    if (!string) {
        return nil;
    }
    NSMutableString* mutableString = [NSMutableString stringWithString:[string stringByReplacingOccurrencesOfString:@" " withString:@""]];
    for (NSNumber *location in locations) {
        if (mutableString.length > location.integerValue) {
            [mutableString insertString:@" " atIndex:location.integerValue];
        }
    }
    return  mutableString;
}
//正则表达式只能输入汉字
+ (NSString *)filterNonChineseCharactor:(NSString *)string{
    NSString *searchText = string;
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\u4e00-\u9fa5]" options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *result = [regex stringByReplacingMatchesInString:searchText options:NSMatchingReportCompletion range:NSMakeRange(0, searchText.length) withTemplate:@""];
    return result;
}
//正则表达式只能输入身份证号
+ (BOOL)filterNonCardIDWithTextField:(UITextField *)textField withInputString:(NSString *)string{
    NSString *regex = nil;
    textField.text = [textField.text replaceSpaceString];
    if (textField.text.length < 17) {
        regex = @"0123456789";
    }else{
        regex = @"Xx0123456789";
    }
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:regex] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}
//只能输入数字
+ (BOOL)filterNonNumberWithTextField:(UITextField *)textField withInputString:(NSString *)string{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}
//可以输入数字、字母
+ (BOOL)filterNumberOrLetterWithTextField:(UITextField *)textField withInputString:(NSString *)string{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}
//返回保留字符串的位数
+ (NSString *)keepDecimalpointAfterDigits:(NSInteger )digits withNeedKeepObj:(CGFloat)obj{
    NSString *str = NSStringFormat(@"%f",obj);
    NSArray *numberArray = [str componentsSeparatedByString:@"."];
    NSString *firstStr = numberArray[0];
    NSString *secondStr = numberArray[1];
    secondStr = [secondStr substringToIndex:digits];
    return NSStringFormat(@"%@.%@",firstStr,secondStr);
}
//浮点数处理并去掉多余的0
+ (NSString *)stringDisposeWithFloat:(double)floatValue
{
    NSString *str = [NSString stringWithFormat:@"%f",floatValue];
    long len = str.length;
    for (int i = 0; i < len; i++){
        if (![str  hasSuffix:@"0"]){
            break;
        }else{
            str = [str substringToIndex:[str length]-1];
        }
    }
    if ([str hasSuffix:@"."])//避免像2.0000这样的被解析成2.
    {
        //s.substring(0, len - i - 1);
        return [str substringToIndex:[str length]-1];
    }else{
        return str;
    }
}
//MD5加密
+(NSString*)stringToMD5:(NSString *)str{
    // 将接受的参数转为UTF-8格式
    const char *cstr = [str UTF8String];
    // 设定接受的结果数组长度
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    // 将字符串转换成了32位的16进制数列
    CC_MD5(cstr, (CC_LONG)strlen(cstr), result);
    // 创建一个可变字符串
    NSMutableString *saveResult = [NSMutableString string];
    // 组装对应的字符串，%02x就是输出两位16进制数据，不足2为补0
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [saveResult appendFormat:@"%02x",result[i]];
    }
    
    return saveResult;
}
//校验车牌号的方法
+ (BOOL)checkVehicleNoMethod:(NSString *)vehicleNo{
    if (vehicleNo.length == 7) {
       //普通汽车，7位字符，不包含I和O，避免与数字1和0混淆
       NSString *carRegex = @"^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-HJ-NP-Z0-9]{4}[A-HJ-NP-Z0-9挂学警港澳]{1}$";
       NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
       return [carTest evaluateWithObject:vehicleNo];
    } else if(vehicleNo.length == 8) {
       //新能源车,8位字符，第一位：省份简称（1位汉字），第二位：发牌机关代号（1位字母）;
       //小型车，第三位：只能用字母D或字母F，第四位：字母或者数字，后四位：必须使用数字;([DF][A-HJ-NP-Z0-9][0-9]{4})
       //大型车3-7位：必须使用数字，后一位：只能用字母D或字母F。([0-9]{5}[DF])
       NSString *carRegex = @"^([京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}(([0-9]{5}[DF])|([DF]([A-HJ-NP-Z0-9])[0-9]{4})))|([京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-HJ-NP-Z0-9]{4}[A-HJ-NP-Z0-9挂学警港澳]{1})$";
       NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
       return [carTest evaluateWithObject:vehicleNo];
    }
    return NO;
}
//校验银行卡规则
+ (BOOL)checkCardNo:(NSString*)cardNo{

    if (cardNo.length < 15) {
          return NO;
    }
    NSString * lastNum = [[cardNo substringFromIndex:(cardNo.length-1)] copy];//取出最后一位
    NSString * forwardNum = [[cardNo substringToIndex:(cardNo.length -1)]copy];//前15或18位

    NSMutableArray *forwardArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<forwardNum.length; i++) {

        NSString * subStr = [forwardNum substringWithRange:NSMakeRange(i,1)];
        [forwardArr addObject:subStr];
    }

    NSMutableArray *forwardDescArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = (int)(forwardArr.count-1); i > -1; i--) {//前15位或者前18位倒序存进数组
        [forwardDescArr addObject:forwardArr[i]];
    }

    NSMutableArray * arrOddNum = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 < 9
    NSMutableArray * arrOddNum2 = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 > 9
    NSMutableArray * arrEvenNum = [[NSMutableArray alloc] initWithCapacity:0];//偶数位数组
    
    for (int i=0; i< forwardDescArr.count; i++) {
        int num = [forwardDescArr[i] intValue];
        if (i%2) {//偶数位
            [arrEvenNum addObject:[NSNumber numberWithInt:num]];
        }else{//奇数位
            if (num *2 < 9) {
                [arrOddNum addObject:[NSNumber numberWithInt:num *2]];
            }else{
                int decadeNum = (num *2) / 10;
                int unitNum = (num *2) % 10;
                [arrOddNum2 addObject:[NSNumber numberWithInt:unitNum]];
                [arrOddNum2 addObject:[NSNumber numberWithInt:decadeNum]];
            }
        }
    }
    __block  NSInteger sumOddNumTotal = 0;

    [arrOddNum enumerateObjectsUsingBlock:^(NSNumber * obj,NSUInteger idx, BOOL *stop) {

        sumOddNumTotal += [obj integerValue];

    }];

    __block NSInteger sumOddNum2Total = 0;

    [arrOddNum2 enumerateObjectsUsingBlock:^(NSNumber * obj,NSUInteger idx, BOOL *stop) {

        sumOddNum2Total += [obj  integerValue];

    }];

    __block  NSInteger sumEvenNumTotal =0 ;

    [arrEvenNum  enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {

        sumEvenNumTotal += [obj  integerValue];

    }];

    NSInteger lastNumber = [lastNum integerValue];

    NSInteger luhmTotal = lastNumber + sumEvenNumTotal + sumOddNum2Total + sumOddNumTotal;

    return (luhmTotal%10 ==0)?YES:NO;
}
//对比两个数组对象中，数值是否相等
+ (BOOL)compareArrayValuesIsEqual:(NSArray *)oldArrObj withNewArray:(NSArray *)newArrObj{
    //创建俩新的数组
    NSMutableArray *oldArr = [NSMutableArray arrayWithArray:oldArrObj];
    NSMutableArray *newArr = [NSMutableArray arrayWithArray:newArrObj];
    
    bool bol = false;
    //对数组1排序。
    [oldArr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return obj1 > obj2;
    }];
    //对数组2排序。
    [newArr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return obj1 > obj2;
    }];
    
    if (newArr.count == oldArr.count) {
        
       bol = true;
       for (int i = 0; i < oldArr.count; i++) {
           
           NSString *c1 = [NSString stringWithFormat:@"%@",[oldArr objectAtIndex:i]];
           NSString *newc = [NSString stringWithFormat:@"%@",[newArr objectAtIndex:i]];
           if (![newc isEqualToString:c1]) {
              bol = false;
              break;
              }
          }
     }
    if (bol) {
        NSLog(@"两个数组的内容相同！");
    }else {
        NSLog(@"两个数组的内容不相同！");
    }
    return bol;
}
//拼接成中间有空格的字符串
+ (NSString *)jointWithString:(NSString *)str
{
    NSString *getString = @"";
    
    int a = (int)str.length/4;
    int b = (int)str.length%4;
    int c = a;
    if (b>0){
        c = a+1;
    }else{
        c = a;
    }
    for (int i = 0 ; i<c; i++){
        NSString *string = @"";
        if (i == (c-1)){
            if (b>0){
                string = [str substringWithRange:NSMakeRange(4*(c-1), b)];
            }else{
                string = [str substringWithRange:NSMakeRange(4*i, 4)];
            }
        }else{
            string = [str substringWithRange:NSMakeRange(4*i, 4)];
        }
        getString = [NSString stringWithFormat:@"%@ %@",getString,string];
    }
    return getString;
}
//替换账单中的名称
+ (NSString *)replaceBillName:(NSString*)originalName{
    if ([originalName isEqualToString:@"预付线上运费"]) {
        return @"预付运费";
    }
    if ([originalName isEqualToString:@"支付线上运费"]) {
        return @"运费";
    }
    if ([originalName isEqualToString:@"预付油费"]) {
        return @"预付油费";
    }
    if ([originalName isEqualToString:@"支付油费"]) {
        return @"油费";
    }
    if ([originalName isEqualToString:@"支付车队长"]) {
        return @"车队长费用";
    }
    if ([originalName isEqualToString:@"预付线上运费退回"]) {
        return @"预付运费退回";
    }
    if ([originalName isEqualToString:@"支付线上运费退回"]) {
        return @"运费退回";
    }
    return originalName;
}
//判断字符串中是否有连续相等的字符
+ (NSArray *)judgeCharacterEquel:(NSString *)firstStr withSecondString:(NSString *)secondStr{
    if (firstStr.length == secondStr.length) {
        NSMutableArray *getArray = [NSMutableArray array];
        NSMutableArray *firstArr = [firstStr getCharacter];
        NSMutableArray *secondArr = [secondStr getCharacter];
        for (int i = 0; i < firstArr.count; i++) {
            if ([firstArr[i] isEqual:secondArr[i]]) {
                [getArray addObject:firstArr[i]];
            }
        }
        return [getArray copy];
    }
    return @[];
}
#pragma mark ============获取字符转数组===========
- (NSMutableArray *)getCharacter{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i< self.length; i++) {
        NSString *temp =  [self substringWithRange:NSMakeRange(i,1)];
        [array addObject:temp];
    }
    return array;
}
#pragma mark ============连续相同的六位数字判断正则111111===========
- (BOOL)validateSameNumber{
    //数字不是重复的
    NSString *regex = @"^(?=.*\\d+)(?!.*?([\\d])\\1{5})[\\d]{6}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat: @"SELF MATCHES %@",regex];

    return [pred evaluateWithObject:self];
}

#pragma mark ============连续六位数字判断正则123456===========
- (BOOL)validateContinuousNumber{
    //数字不是连续的
    NSString *regex = @"^(?:(\\d)(?!((?<=9)8|(?<=8)7|(?<=7)6|(?<=6)5|(?<=5)4|(?<=4)3|(?<=3)2|(?<=2)1|(?<=1)0){5})(?!\1{5})(?!((?<=0)1|(?<=1)2|(?<=2)3|(?<=3)4|(?<=4)5|(?<=5)6|(?<=6)7|(?<=7)8|(?<=8)9){5})){6}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat: @"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:self];
}
//字符串加密处理，前面4位，后面4位，中间字符加密处理
- (NSString *)middleStringDesensitization{
    if (self.length == 0) {
        return self;
    }
    if (self.length <= 8) {
        return self;
    }
    NSString *firstStr = [self substringToIndex:4];
    NSString *lastStr = [self substringWithRange:NSMakeRange(self.length - 4, 4)];
    NSString *middleStr = [self substringWithRange:NSMakeRange(4, self.length - 8)];
    NSString *tempStr = @"";
    for (int i = 0; i < middleStr.length; i++) {
        tempStr = NSStringFormat(@"%@*",tempStr);
    }
    NSString *resultStr = NSStringFormat(@"%@%@%@",firstStr,tempStr,lastStr);
    return resultStr ;
}
//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
+(NSString *)firstCharactor:(NSString *)name{
    //转成了可变字符串
    NSMutableString *pStr = [NSMutableString stringWithString:name];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)pStr,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)pStr,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pPinYin = [pStr capitalizedString];
    //获取并返回首字母
    return [pPinYin substringToIndex:1];
}
/**
整数转小数点后几位并且防止崩溃处理
*/
+ (NSString *)toDealWithDecimalPoint:(NSString *)price afterPoint:(NSInteger)position {
    NSString *numValue = [NSString stringWithFormat:@"%@",price];
    if (IsNilOrNull(numValue)) {
        numValue = @"0";
    }
    if ([numValue containsString:@"."]) {//包含小数点
        NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
        NSDecimalNumber *ouncesDecimal;
        NSDecimalNumber *roundedOunces;
        ouncesDecimal =  [[NSDecimalNumber alloc] initWithString:numValue];
        roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
        NSString *finalNum = [NSString stringWithFormat:@"%@",roundedOunces];
        if ([finalNum rangeOfString:@"."].length == 0) {
            finalNum = [finalNum stringByAppendingString:@"."];
            for (int i=0; i<position;i++) {
               finalNum = [finalNum stringByAppendingString:@"0"];
            }
        } else {
            NSRange range = [finalNum rangeOfString:@"."];
            if (finalNum.length - range.location - 1 == position) {
             
            } else {
                NSInteger afterLength = position - (finalNum.length - range.location - 1);
                if (afterLength > 0) {
                    for (int i=0 ;i<afterLength; i++) {
                        finalNum = [finalNum stringByAppendingString:@"0"];
                    }
                }
            }
        }
        return finalNum;
    } else {//不包含小数点
        return numValue;
    }
}
/**
获取当前是第几个派单
*/
+(NSString *)getStringBgSection:(NSInteger)section{
    if (section == 0) {
        return @"①";
    }
    if (section == 1) {
        return @"②";
    }
    if (section == 2) {
        return @"③";
    }
    if (section == 3) {
        return @"④";
    }
    return @"⑤";
}
/**
替换固定字文字颜色和字体大小
*/
+ (NSMutableAttributedString *)changePartRichText:(NSString *)text changeStr:(NSString *)changeStr changeColor:(UIColor *)changeColor changeFont:(UIFont *)changeFont {
   NSMutableAttributedString *richAttr = [NSString setupAttributeString:text changeStr:changeStr changeColor:changeColor changeFont:changeFont];
   return richAttr;
}
/**
富文本设置部分字体颜色
*/
+ (NSMutableAttributedString *)setupAttributeString:(NSString *)text changeStr:(NSString *)changeStr changeColor:(UIColor *)changeColor changeFont:(UIFont *)changeFont{
    NSRange hightlightTextRange = [text rangeOfString:changeStr];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:text];
    if (hightlightTextRange.length > 0) {//要被重新设置的文字 颜色和大小
        [attributeStr addAttribute:NSForegroundColorAttributeName value:changeColor range:hightlightTextRange];
        [attributeStr addAttribute:NSFontAttributeName value:changeFont range:hightlightTextRange];
        return attributeStr;
    } else {
        return [changeStr copy];
    }
}
/*
 通过计价方式获取对应的单位
 */
+ (NSString *)getUnitStringByPriceMethod:(NSInteger)priceMethod{
    //计价方式1.元/吨 2.元/车 3.元/方
    if (priceMethod == 1) {
        return @"元/吨";
    }
    if (priceMethod == 2) {
        return @"元/车";
    }
    if (priceMethod == 3) {
        return @"元/方";
    }
    return @"元/吨";
}
/**
 通过收款方式获取收款字符
 */
+ (NSString *)getPeymentMethodBySettlementObject:(NSInteger)settlementObject{
    //1.全额支付给司机2.全额支付给车队长3.部分支付给车队长*/
    if (settlementObject == 1) {
        return @"全额支付给司机";
    }
    if (settlementObject == 2) {
        return @"全额支付给车队长";
    }
    if (settlementObject == 3) {
        return @"部分支付给车队长";
    }
    return @"全额支付给司机";
}
//判断字符串为0
- (BOOL)judgeLoadNumberIsZero{
    if (self.length == 0) {
        return YES;
    }
    if ([self isEqualToString:@"0"]) {
        return YES;
    }
    if ([self isEqualToString:@"0.0"]) {
        return YES;
    }
    if ([self isEqualToString:@"0.00"]) {
        return YES;
    }
    if ([self isEqualToString:@"0.000"]) {
        return YES;
    }
    if ([self isEqualToString:@"0.0000"]) {
        return YES;
    }
    if ([self isEqualToString:@"0.00000"]) {
        return YES;
    }
    return NO;
}
/**校验货源名称是否是汉字/( ) - 这些字符组成*/
+(BOOL)checkGoodsName:(NSString *)name{
    NSString *pattern = @"[0-9a-zA-Z\\u4e00-\\u9fa5[-][()][（）]]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:name];
    return isMatch;
}

/**获取能源类型*/
+(NSArray *)getEnergyCodeSc:(NSString *)energyCodeSc{
    NSMutableArray *energyArr = [NSMutableArray new];
    if ([energyCodeSc isEqualToString:@"E"]) {
        energyArr[0] = @"lngToUser";
        energyArr[1] = @"LNG";
    } else {
        energyArr[0] = @"dieselOilToUser";
        energyArr[1] = @"柴油";
    }
    return energyArr;
}

/**获取油卡类型*/
+(NSString *)getOilBrandByOilName:(NSString *)oilName{
    NSString *oilCode = @"dieselOilToUser";
    if ([oilName isEqualToString:PROMPT_TEXT_DIESELOIL]) {//柴油
        oilCode = @"dieselOilToUser";
    } else if ([oilName isEqualToString:PROMPT_TEXT_LNG]){
        oilCode = @"lngToUser";
    }
    return oilCode;
}
//把字符串转为 cgfloat 保留
+(CGFloat)transformTextToFloat:(NSString *)num {
//    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:num];
    CGFloat numValue = floorf([num floatValue] * 100) / 100 ;
    return numValue;
}

//获取身份证中的出生日期
+ (NSString *)getBirthdayByCardIdNo:(NSString*)cardidNo{
    return [cardidNo substringWithRange:NSMakeRange(6, 8)];
}
/**
判断字符串中有几个汉字
*/
+(NSInteger)hasChineseCount:(NSString *)content {
    NSInteger count = 0;
    for (int i=0; i<[content length];i++) {
        int a = [content characterAtIndex:i];
        if (a > 0x4E00 && a < 0x9FFF) {
            count ++;
        }
    }
    return count;
}


@end
