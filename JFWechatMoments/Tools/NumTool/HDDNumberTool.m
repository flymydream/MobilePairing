//
//  HDDNumberTool.m
//  Shipper
//
//  Created by huodada on 2021/6/29.
//  Copyright © 2021 caesar. All rights reserved.
//

#import "HDDNumberTool.h"

@implementation HDDNumberTool

/**当数据大于等于万 大于等于亿处理单位 - 只返回单位*/
+ (NSString *)getBigNumber:(NSString *)number unit:(NSString *)unit{
    NSString *resultUnit = unit;
    if (!IsNilOrNull(number)) {
        if([number floatValue] > 0 && [number floatValue] < 10000){
            resultUnit = unit;
        } else if ([number floatValue] >= 10000 && [number floatValue] < 100000000) {
            //单位为万
            resultUnit =  [NSString stringWithFormat:@"万%@",unit];
        } else if([number floatValue] >= 100000000) {
            //单位为亿
            resultUnit =  [NSString stringWithFormat:@"亿%@",unit];
        }
    } else {
        return resultUnit;
    }
   return resultUnit;
}
/**当数据大于等于万 大于等于亿处理数据 只返回处理过后的数字 不带单位*/
+ (NSString *)getBigNumber:(NSString *)number{
    NSString *resultStr = @"0";
    if (!IsNilOrNull(number)) {
        if ([number floatValue] < 10000 && [number floatValue] > 0) {
              if ([number containsString:@"."]) {
                 resultStr =  [NSString toDealWithDecimalPoint:number afterPoint:2];
              } else {
                 resultStr =  number;
              }
        } else if ([number floatValue] >= 10000 && [number floatValue] < 100000000) {
              //单位为万
              NSString *payableNum = [NSString stringWithFormat:@"%f",[number floatValue] / 10000];
              resultStr =  [NSString toDealWithDecimalPoint:payableNum afterPoint:2];
        } else if([number floatValue] >= 100000000) {
            //单位为亿
            NSString *payableNum = [NSString stringWithFormat:@"%f",[number floatValue] / 100000000];
            resultStr =  [NSString toDealWithDecimalPoint:payableNum afterPoint:2];
        }
    } else {
        return @"0";
    }
    return resultStr;
}

/**当数据大于等于万 大于等于亿处理数据 返回数据带单位*/
+ (NSString *)getOrderBigNumber:(NSString *)number {
    NSString *resultStr = @"0";
    if (!IsNilOrNull(number)) {
        if ([number floatValue] < 10000 && [number floatValue] > 0) {
             //不处理单位
              if ([number containsString:@"."]) {
                 resultStr =  [NSString toDealWithDecimalPoint:number afterPoint:2];
              } else {
                 resultStr =  number;
              }
        } else if ([number floatValue] >= 10000 && [number floatValue] < 100000000) {
              //单位为万
              NSString *payableNum = [NSString stringWithFormat:@"%f",[number floatValue] / 10000];
              resultStr =  NSStringFormat(@"%@万",[NSString toDealWithDecimalPoint:payableNum afterPoint:2]);
        } else if([number floatValue] >= 100000000) {
            //单位为亿
            NSString *payableNum = [NSString stringWithFormat:@"%f",[number floatValue] / 100000000];
            resultStr =  NSStringFormat(@"%@亿",[NSString toDealWithDecimalPoint:payableNum afterPoint:2]);
        }
    } else {
        return @"0";
    }
    return resultStr;
}

/**处理数据展示 如果不包含小数点直接展示 包含小数点(小数点后大于2位则保留2位)*/
+ (NSString *)getNumDecimalPointByStr:(NSString *)numStr{
    if (!IsNilOrNull(numStr)) {
        if (![numStr containsString:@"."]) {
              return numStr;
          } else {
              NSArray *numArr = [numStr componentsSeparatedByString:@"."];
              NSString *content = [numArr lastObject];
              if (content.length <= 2) {//如果小数点后有2位则保留2位 否则不处理
                   return numStr;
              } else {
                   return [NSString toDealWithDecimalPoint:numStr afterPoint:2];
              }
          }
    }
    return @"0";
}




@end
