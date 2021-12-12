//
//  HDDPaymentTools.h
//  Shipper
//
//  Created by huodada on 2021/6/1.
//  Copyright © 2021 caesar. All rights reserved.
//

#import "HDDBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HDDPaymentTools : HDDBaseModel

//获取支付类型
+ (NSString *)getPaymentType:(NSString *)type;

//获取支付方式
+ (NSString *)getPaymentTypes:(NSInteger)type;

//获取支付状态
+ (NSString *)getPaymentStatus:(NSInteger)status payLable:(UILabel *)payLable;





@end

NS_ASSUME_NONNULL_END
