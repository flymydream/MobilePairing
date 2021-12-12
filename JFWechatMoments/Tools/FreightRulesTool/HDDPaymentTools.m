//
//  HDDPaymentTools.m
//  Shipper
//
//  Created by huodada on 2021/6/1.
//  Copyright © 2021 caesar. All rights reserved.
//

#import "HDDPaymentTools.h"

@implementation HDDPaymentTools

//获取 支付类型,预付(0)，支付(1)
+ (NSString *)getPaymentType:(NSString *)type {
   NSString *resultStr = nil;
   if([type intValue] == 0){
      resultStr = PAYMENT_IN_ADVANCE;
   } else if([type intValue] == 1){
        resultStr = PAYMENT_IN;
   }
   return resultStr;
}


//获取支付方式    支付方式,支付司机(10)，合并支付(20)
+ (NSString *)getPaymentTypes:(NSInteger)type {
    NSString *resultStr = nil;
    if(type == 10){
       resultStr = PAYMENT_DRIVER;
    } else if(type == 20){
         resultStr = PAYMENT_CONSOLIDATED;
    }
    return resultStr;
    
}

+ (NSString *)getPaymentStatus:(NSInteger)status payLable:(UILabel *)payLable {
      NSString *resultStr = nil;
       if(status == 15){
          resultStr = PAYMENT_STATUS_ING;//#007FFF蓝色
           payLable.textColor = HexRGB(0X007FFF);
       } else if(status == 20){
            resultStr = PAYMENT_STATUS_PARTSUCCESS; //#F07116b橙色
            payLable.textColor = HexRGB(0XF07116b);
       } else if(status == 30){
            resultStr = PAYMENT_STATUS_PAYSUCCESS;//#27B57D 绿色
            payLable.textColor = HexRGB(0X27B57D);
       } else if(status == 40){
            resultStr = PAYMENT_STATUS_PAYERROR;//#E90000 失败
            payLable.textColor = HexRGB(0XE90000);
       } else if(status == 50){
            resultStr = PAYMENT_STATUS_PAYCANCLE; //666666
            payLable.textColor = SubtitleTextColor;
       }
       return resultStr;
    
}



@end
