//
//  HDDFreightRulesTool.m
//  Shipper
//
//  Created by huodada on 2021/5/25.
//  Copyright © 2021 caesar. All rights reserved.
//

#import "HDDFreightRulesTool.h"

@implementation HDDFreightRulesTool
//获取司机运费规则字符串
+ (NSString *)getDriverFreightRules:(NSInteger)rules {
    //运费计算规则1.装货数量2卸货数量3.装卸货数量最小
     NSString *resultStr = nil;
     if(rules == 1){
        resultStr = [NSString stringWithFormat:@" %@: %@ ",GOODS_DRIVER_FREIGHT_CALCULATION,GOODS_LOAD_NUM];
     } else if(rules == 2){
        resultStr = [NSString stringWithFormat:@" %@: %@ ",GOODS_DRIVER_FREIGHT_CALCULATION,GOODS_UNLOAD_NUM];
     } else if(rules == 3){
          resultStr = [NSString stringWithFormat:@" %@: %@ ",GOODS_DRIVER_FREIGHT_CALCULATION,GOODS_LOAD_AND_UNLOAD_MINIMUM];
     }
     return resultStr;
}
//司机运费抹零规则
+ (NSString *)getDriverFreightSetZeroRules:(NSInteger)rules freightNum:(NSString *)freightNum {
     NSString *resultStr = nil;
    if(rules == 1){ //不抹零
        resultStr = [NSString stringWithFormat:@" %@: %@ ",GOODS_DRIVER_FREIGHT_SETZERO,GOODS_NO_SETZERO];
    } else if(rules == 2){//角分抹零
        resultStr = [NSString stringWithFormat:@" %@: %@ ",GOODS_DRIVER_FREIGHT_SETZERO,GOODS_ANGULAR_MINUTE_SETZERO];
    } else if(rules == 3){//5元以下抹零
        resultStr = [NSString stringWithFormat:@" %@: %@ ",GOODS_DRIVER_FREIGHT_SETZERO,GOODS_LESSTHAN_FIVE_SETZERO];
    } else if(rules == 4){//10元取整抹零
        resultStr = [NSString stringWithFormat:@" %@: %@ ",GOODS_DRIVER_FREIGHT_SETZERO,GOODS_TEN_ROUND_SETZERO];
    } else if(rules == 5){//5元取整抹零
        resultStr = [NSString stringWithFormat:@" %@: %@ ",GOODS_DRIVER_FREIGHT_SETZERO,GOODS_FIVE_ROUND_SETZERO];
    } else if(rules == 6){//自定义个位抹零
        resultStr = [NSString stringWithFormat:@" %@: %@ (%@) ",GOODS_DRIVER_FREIGHT_SETZERO,GOODS_CUSTOM_INDIVIDUAL_SETZERO,freightNum];
    }
    return resultStr;
}

//应付司机运费抹零规则
+ (NSString *)getDriverFreightShouldPayRules:(NSInteger)rules freightNum:(NSString *)freightNum{
     NSString *resultStr = nil;
    if(rules == 1){
        resultStr = [NSString stringWithFormat:@" %@: %@ ",GOODS_PAYABLE_DRIVER_FREIGHT_SETZERO,GOODS_NO_SETZERO];
    } else if(rules == 2){
        resultStr = [NSString stringWithFormat:@" %@: %@ ",GOODS_PAYABLE_DRIVER_FREIGHT_SETZERO,GOODS_ANGULAR_MINUTE_SETZERO];
    } else if(rules == 3){
        resultStr = [NSString stringWithFormat:@" %@: %@ ",GOODS_PAYABLE_DRIVER_FREIGHT_SETZERO,GOODS_LESSTHAN_FIVE_SETZERO];
    } else if(rules == 4){
         resultStr = [NSString stringWithFormat:@" %@: %@ ",GOODS_PAYABLE_DRIVER_FREIGHT_SETZERO,GOODS_TEN_ROUND_SETZERO];
    } else if(rules == 5){
        resultStr = [NSString stringWithFormat:@" %@: %@ ",GOODS_PAYABLE_DRIVER_FREIGHT_SETZERO,GOODS_FIVE_ROUND_SETZERO];
    } else if(rules == 6){
         resultStr = [NSString stringWithFormat:@" %@: %@ (%@) ",GOODS_PAYABLE_DRIVER_FREIGHT_SETZERO,GOODS_CUSTOM_INDIVIDUAL_SETZERO,freightNum];
    }
    return resultStr;
}

//获取运价单位 不带括号
+ (NSString *)getGoodsPriceUnitNoBrackets:(NSInteger)unit {
    //计价方式1.元/吨 2.元/车 3.元/方
       NSString *resultStr = nil;
      if (unit == 1) {
          resultStr = GOODS_UNIT_TON_METHOD;
      } else if (unit == 2) {
          resultStr = GOODS_UNIT_CAR_METHOD;
      } else if (unit == 3) {
          resultStr = GOODS_UNIT_SQUARE_METHOD;
      }
     return resultStr;
}



//获取运价单位
+ (NSString *)getGoodsPriceUnit:(NSInteger)unit {
    //计价方式1.元/吨 2.元/车 3.元/方
       NSString *resultStr = nil;
      if (unit == 1) {
          resultStr = [NSString stringWithFormat:@"(%@)",GOODS_UNIT_TON_METHOD];
      } else if (unit == 2) {
          resultStr = [NSString stringWithFormat:@"(%@)",GOODS_UNIT_CAR_METHOD];
      } else if (unit == 3) {
          resultStr = [NSString stringWithFormat:@"(%@)",GOODS_UNIT_SQUARE_METHOD];
      }
     return resultStr;
}
//获取最大扣除 单位重量单位
+ (NSString *)getUnit:(NSInteger)unit {
    //1.吨 2.车 3.方
    NSString *resultStr = nil;
   if (unit == 1) {
       resultStr = [NSString stringWithFormat:@"%@",GOODS_UNIT_ONE_TON_METHOD];
   } else if (unit == 2) {
       resultStr = [NSString stringWithFormat:@"%@",GOODS_UNIT_ONE_CAR_METHOD];
   } else if (unit == 3) {
       resultStr = [NSString stringWithFormat:@"%@",GOODS_UNIT_ONE_SQUARE_METHOD];
   }
   return resultStr;
}

//获取发货数量
+ (NSString *)getDriverGoodsUnit:(NSInteger)unit {
    //计价方式1.吨 2.车 3.方
    NSString *resultStr = GOODS_UNIT_TON;
    if (unit == 2) {
          resultStr = [NSString stringWithFormat:@"%@",GOODS_UNIT_CAR];
    } else if (unit == 3) {
          resultStr = [NSString stringWithFormat:@"%@",GOODS_UNIT_SQUARE];
    } else {
          resultStr = [NSString stringWithFormat:@"%@",GOODS_UNIT_TON];
    }
     return resultStr;
}



//获取统计时间类型
+ (NSString *)getStatisShowTimeType:(NSString *)timeType {
      NSString *timeTypeStr = nil;
      if ([timeType isEqualToString:@"dispatch_time"]) {
         timeTypeStr = @"创建时间";
      } else if ([timeType isEqualToString:@"load_time"]) {
        timeTypeStr = @"装货时间";
      } else if ([timeType isEqualToString:@"unload_time"]) {
        timeTypeStr = @"卸货时间";
      } else if ([timeType isEqualToString:@"transport_payment_time"]) {
        timeTypeStr = @"支付时间";
      } else {
        timeTypeStr = @"创建时间";
      }
     return timeTypeStr;
}
//获取统计时间 参数类型
+ (NSString *)getStatisParamTimeType:(NSString *)timeType {
    NSString *timeTypeStr = @"dispatch_time";
    if ([timeType isEqualToString:@"创建时间"]) {
      timeTypeStr = @"dispatch_time";
    } else if ([timeType isEqualToString:@"装货时间"]) {
       timeTypeStr = @"load_time";
    } else if ([timeType isEqualToString:@"卸货时间"]) {
       timeTypeStr = @"unload_time";
    } else if ([timeType isEqualToString:@"支付时间"]) {
       timeTypeStr = @"transport_payment_time";
    } else {
        timeTypeStr = @"dispatch_time";
    }
    return timeTypeStr;
}

/**获取油费类型1.无油费2.有油费*/
+ (NSString *)getOilConfigType:(NSInteger)type {
      NSString *resultStr = GOODS_NOOILCHARGE;
      if (type == 2) {
          resultStr = GOODS_HAVEOILCHARGE;
      } else {
          resultStr = GOODS_NOOILCHARGE;
      }
      return resultStr;
}

/**获取油费支付类型1.预付时付油费2.支付时付油费*/
+ (NSString *)getOilPaymentMomentType:(NSInteger)type {
      NSString *resultStr = GOODS_PAYOIL_PAYMENT;
      if (type == 1) {
          resultStr = GOODS_PAYOIL_INADVANCE;
      } else if (type == 2) {
          resultStr = GOODS_PAYOIL_PAYMENT;
      } else {
          resultStr = GOODS_PAYOIL_PAYMENT;
      }
      return resultStr;
}

/**获取油费支付方式1.电子钱包2.线下*/
+ (NSString *)getOilPaymentType:(NSInteger)type {
      NSString *resultStr = GOODS_PAY_ELECTRONIC_WALLET;
      if (type == 2) {
          resultStr = GOODS_PAY_OUTLINE;
      } else {
           resultStr = GOODS_PAY_ELECTRONIC_WALLET;
      }
      return resultStr;
}

/**获取油费计算方式1固定金额2运费比例*/
+ (NSString *)getOilCalculationMethodType:(NSInteger)type {
      NSString *resultStr = GOODS_FIXEDAMOUNT;
      if (type == 2) {
          resultStr = GOODS_FREIGHTRATIO;
      } else {
           resultStr = GOODS_FIXEDAMOUNT;
      }
      return resultStr;
}



//获取收款方式
+ (NSString *)getPaymentType:(NSInteger)type {
    //计价方式1.全额支付给司机 2.全额支付给车队长 3.部分支付给车队长
       NSString *resultStr = GOODS_PAYFULL_DRIVER;
      if (type == 2) {
          resultStr = GOODS_PAYFULL_CARCAPTAIN;
      } else if (type == 3) {
          resultStr = GOODS_PAYPART_CARCAPTAIN;
      } else {
          resultStr = GOODS_PAYFULL_DRIVER;
      }
     return resultStr;
}

//获取预付设置
+ (NSString *)getPrepayType:(NSInteger)type {
    //计价方式1.无预付 2.有预付
       NSString *resultStr = GOODS_NO_PAY_ADVANCE;
      if (type == 1) {
          resultStr = GOODS_HAVE_PAY_ADVANCE;
      } else {
          resultStr = GOODS_NO_PAY_ADVANCE;
      }
     return resultStr;
}


//获取支付方式
+ (NSString *)getPayType:(NSInteger)type {
    //1手机钱包 2银行卡
       NSString *resultStr = GOODS_PAY_ELECTRONIC_WALLET;
      if (type == 1) {
          resultStr = GOODS_PAY_ELECTRONIC_WALLET;
      } else if (type == 2) {
          resultStr = GOODS_PAY_BANKACCOUNT;
      }
     return resultStr;
}


//获取车队长扣款方式 车队长费用扣款方式:0空;1外扣;2内扣;
+ (NSString *)getChiefDriverDeductType:(NSInteger)type {
    //0空;1外扣;2内扣;
       NSString *resultStr = @"";
      if (type == 1) {
          resultStr = GOODS_EXTERNAL_BUCKLE;
      } else if (type == 2) {
          resultStr = GOODS_INTERNAL_BUCKLE;
      }
     return resultStr;
}


+(NSString *)resetCurrentNum:(NSString *)currentNum {
    if ([currentNum hasPrefix:@"0"] && ![currentNum containsString:@"."] && currentNum.length > 1) {
        currentNum = [NSString stringWithFormat:@"%d",[currentNum intValue]];
    }
    return currentNum;
}

@end
