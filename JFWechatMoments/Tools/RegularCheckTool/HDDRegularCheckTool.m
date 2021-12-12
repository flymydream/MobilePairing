//
//  HDDRegularCheckTool.m
//  Driver
//
//  Created by caesar on 2020/1/17.
//  Copyright © 2020 caesar. All rights reserved.
//

#import "HDDRegularCheckTool.h"

@implementation HDDRegularCheckTool
/**
 *  校验车牌号码是否合法
 */
+ (BOOL)validateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"[\u4E00-\u9FA5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{5}";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:carNo];
}

/**
 * 校验用户名:只能为英文字母或者汉子,数字
 */
+ (BOOL)validateUserName:(NSString *)userName {
    NSString *regex = @"[0-9a-zA-Z\u4e00-\u9fa5][0-9a-zA-Z\u4e00-\u9fa5]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:userName];
}

/**
 * 电话号码校验
 */
//+ (BOOL)validateMobile:(NSString *)mobileNum
//{
//    NSString * MOBILE = @"^1[34578][0-9]{9}$";
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    if ([regextestmobile evaluateWithObject:mobileNum]) {
//        return YES;
//    } else {
//        return NO;
//    }
//}

/**
 * 字符串是否为纯数字校验
 */
+ (BOOL)isAllNum:(NSString *)string
{
    unichar c;
    for (int i=0; i<string.length; i++) {
        c=[string characterAtIndex:i];
        if (!isdigit(c)) {
            return NO;
        }
    }
    return YES;
}

/**
 * 字符串是否为空
 */

+ (BOOL)isBlankString:(NSString *)string{
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

/**
 * 判断字典key 和 判断 值是否为空
 */
+ (BOOL)isBlank:(NSDictionary *)dic key:(NSString *)key {
    if (!dic || !key || ![dic objectForKey:key] || [[dic objectForKey:key] isEqual: [NSNull null]]
        || [[dic objectForKey:key] isEqual: @""]) {
        return YES;
    }
    return NO;
}
//显示输入框小数点和小数点后两位
+ (void)limitTextFieldTextDecimalPointAfterTheTwo:(UITextField *)textField{
    NSString *includeStr = @"1234567890";
    NSString *dotString = @".";
    if ([textField.text isEqualToString:dotString]) {
       textField.text = @"0.";
    }
    if (textField.text.length > 0) {
        NSString *lastStr = [textField.text substringFromIndex:textField.text.length-1];
        NSString *fontStr = [textField.text substringToIndex:textField.text.length-1];
        NSString *allowStr = [NSString stringWithFormat:@"%@%@",includeStr,dotString];
        if ([allowStr containsString:lastStr]) {
            
            if ([fontStr rangeOfString:dotString].location != NSNotFound) {
                //前面字符串有.
                //最后一个字符串是不是.
                if ([lastStr isEqualToString:dotString]) {
                    textField.text = fontStr;
                }else{
                    if (![includeStr containsString:lastStr]) {
                        textField.text = fontStr;
                    }
                }
            }else{
                if ([fontStr isEqualToString:lastStr] && [lastStr isEqualToString:@"0"]) {
                    textField.text = fontStr;
                }else{
                    if ([fontStr isEqualToString:@"0"] && ![lastStr isEqualToString:@"."]) {
                        textField.text = lastStr;
                    }
                }
                
            }
            if (textField.text.length > [textField.text rangeOfString:dotString].location + 3) {
                textField.text = [textField.text substringToIndex:[textField.text rangeOfString:dotString].location+3];
            }
        }else{
            textField.text = fontStr;
        }
    }
}
+(BOOL)dealWithPointWithTextField:(UITextField *)textField current:(NSString *)current limitNum:(NSInteger)limitNum{
    if ([textField.text containsString:@"."]) {
       if ([current isEqualToString:@"."]) {
           return NO;
       } else {
           NSArray *strArr = [textField.text componentsSeparatedByString:@"."];
           if ([[strArr lastObject] length] >= limitNum && ![current isEqualToString:@""]) {
               return NO;
           } else {
               return YES;
           }
       }
    } else {
       return YES;
    }
}
//限制textField输入0-maxValue的数 并且保留after位
+ (BOOL)limitTextFieldDecimalPoint:(UITextField *)textField range:(NSRange)range tring:(NSString *)string pfrefix:(NSString *)pfrefix maxValue:(int)maxValue after:(int)after{
    
    NSLog(@"输入的数字----%@",string);
    BOOL isHaveDian = YES;
    if ([textField.text rangeOfString:@"."].location == NSNotFound) {
        isHaveDian = NO;
    }
    if (string.length == 0) {
        return YES;
    }
    //运价必须大于0且小于等于100000，保留两位小数
//    预付线上运费必须大于等于0且小于等于100000，保留两位小数
    //最大扣除必须大于等于0且小于等于200
    //单位重量大于等于0，保留两位小数
    NSString *showMessage = [NSString stringWithFormat:@"%@必须大于等于0且小于等于%@,保留两位小数",pfrefix,[NSString stringWithFormat:@"%d",maxValue]];
    if ([pfrefix isEqualToString:@"运价"]) {
        showMessage = [NSString stringWithFormat:@"%@必须大于0且小于等于%@,保留两位小数",pfrefix,[NSString stringWithFormat:@"%d",maxValue]];
    } else if ([pfrefix isEqualToString:@"最大扣除"]){
        showMessage = [NSString stringWithFormat:@"%@必须大于等于0且小于等于%@",pfrefix,[NSString stringWithFormat:@"%d",maxValue]];
    } else if ([pfrefix isEqualToString:@"单位重量"]){
        showMessage = @"单位重量大于等于0,保留两位小数";
    } else if([pfrefix isEqualToString:@"发货数量"] || [pfrefix isEqualToString:@"每车运输数量"]){
        showMessage = [NSString stringWithFormat:@"%@必须大于0小于等于%@",pfrefix,[NSString stringWithFormat:@"%d",maxValue]];
    }
    unichar single = [string characterAtIndex:0];//当前输入的字符
    if ((single >= '0' && single <= '9') || single == '.') {
        if (range.location == 0) {//光标在字符串开头
            if (single == '.') {
                [HDDCustomToastView showMessageTitle:showMessage andDelay:1.5];
                return NO;
            }
            else {
                NSMutableString *temp = [textField.text mutableCopy];
                [temp insertString:string atIndex:range.location];
                if (temp.floatValue > maxValue) {
                    [HDDCustomToastView showMessageTitle:showMessage andDelay:1.5];
                    return NO;
                }
                return YES;
            }
        } else {
           if (single == '.') {
               if (isHaveDian) {
                   return NO;
               } else {
                   NSMutableString *temp = [textField.text mutableCopy];
                   [temp insertString:string atIndex:range.location];
                   
                   if (temp.floatValue < maxValue) {
                       return YES;
                   }
                   else {
                       [HDDCustomToastView showMessageTitle:showMessage andDelay:1.5];
                       return NO;
                   }
               }
           } else {
               if (isHaveDian) {
                   NSRange dotRange = [textField.text rangeOfString:@"."];
                   if (range.location > dotRange.location) {
                       if (textField.text.length - dotRange.location <= after) {
                           return YES;
                       }
                       else {
                           return NO;
                       }
                   }
                   else {
                       NSMutableString *temp = [textField.text mutableCopy];
                       [temp insertString:string atIndex:range.location];
                       if (temp.floatValue > maxValue) {
                            [HDDCustomToastView showMessageTitle:showMessage andDelay:1.5];
                           return NO;
                       }
                       return YES;
                   }
               }
               else {
                   NSMutableString *temp = [textField.text mutableCopy];
                   [temp insertString:string atIndex:range.location];
                   
                   if (temp.floatValue > maxValue) {
                        [HDDCustomToastView showMessageTitle:showMessage andDelay:1.5];
                       return NO;
                   }
                   return YES;
               }
           }
        }
    } else {
          [HDDCustomToastView showMessageTitle:showMessage andDelay:1.5];
         return NO;
    }
}
/**检验是否正确的银行卡号*/
+ (BOOL)validateBankCardNo:(NSString*)cardNo{
        if (cardNo.length < 15) {
           return NO;
        }
        int oddsum = 0;//奇数求和
        int evensum = 0;//偶数求和
        int allsum = 0;
        int cardNoLength = (int)[cardNo length];
        int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
        cardNo = [cardNo substringToIndex:cardNoLength - 1];
        for (int i = cardNoLength -1 ; i>=1;i--) {
                    NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
                    int tmpVal = [tmpString intValue];
                    if (cardNoLength % 2 ==1 ) {
                        if((i % 2) == 0){
                        tmpVal *= 2;
                        if(tmpVal>=10)
                        tmpVal -= 9;
                        evensum += tmpVal;
                    } else{
                      oddsum += tmpVal;
                    }
                } else{

                    if((i % 2) == 1){

                    tmpVal *= 2;

                    if(tmpVal>=10)

                    tmpVal -= 9;

                    evensum += tmpVal;

                    }else{

                    oddsum += tmpVal;

                    }

                    }

        }
        allsum = oddsum + evensum;
        allsum += lastNum;
        if((allsum % 10) == 0)
        return YES;
        else
        return NO;

}
/**银行卡校验*/
+(BOOL)checkBankCardNumber:(NSString *)cardNumber {
     if (cardNumber.length < 15) {
            return NO;
    }
      NSString * lastNum = [[cardNumber substringFromIndex:(cardNumber.length-1)] copy];//取出最后一位
      NSString * forwardNum = [[cardNumber substringToIndex:(cardNumber.length -1)]copy];//前15或18位
      
      NSMutableArray * forwardArr = [[NSMutableArray alloc] initWithCapacity:0];
      for (int i=0; i<forwardNum.length; i++) {
          NSString * subStr = [forwardNum substringWithRange:NSMakeRange(i,1)];
          [forwardArr addObject:subStr];
      }
      NSMutableArray * forwardDescArr = [[NSMutableArray alloc] initWithCapacity:0];
      for (NSInteger i = forwardArr.count-1; i> -1; i--) {//前15位或者前18位倒序存进数组
          [forwardDescArr addObject:forwardArr[i]];
      }
      NSMutableArray * arrOddNum = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 < 9
      NSMutableArray * arrOddNum2 = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 > 9
      NSMutableArray * arrEvenNum = [[NSMutableArray alloc] initWithCapacity:0];//偶数位数组
      for (int i=0; i< forwardDescArr.count; i++) {
          NSInteger num = [forwardDescArr[i] intValue];
          if (i%2) {//偶数位
              [arrEvenNum addObject:[NSNumber numberWithInteger:num]];
          }else{//奇数位
              if (num *2 < 9) {
                  [arrOddNum addObject:[NSNumber numberWithInteger:num *2]];
              }else{
                  NSInteger decadeNum = (num *2) / 10;
                  NSInteger unitNum = (num *2) % 10;
                  [arrOddNum2 addObject:[NSNumber numberWithInteger:unitNum]];
                  [arrOddNum2 addObject:[NSNumber numberWithInteger:decadeNum]];
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

/**身份证校验规则*/
+(BOOL)validateUserIdentityCard:(NSString *)userID{
    //长度不为18的都排除掉
    if (userID.length!=18) {
       return NO;
    }
    //校验格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL flag = [identityCardPredicate evaluateWithObject:userID];
    if (!flag) {
         return flag; //格式错误
    } else {
    //格式正确在判断是否合法
    //将前17位加权因子保存在数组里
    NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++){
        NSInteger subStrIndex = [[userID substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString * idCardLast= [userID substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2){
        if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]){
            return YES;
        } else {
           return NO;
        }
    } else {
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if([idCardLast isEqualToString:[idCardYArray objectAtIndex:idCardMod]]){
            return YES;
        } else {
            return NO;
        }

        }
    }
}


@end
