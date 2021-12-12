//
//  HDDFreightRulesTool.h
//  Shipper
//
//  Created by huodada on 2021/5/25.
//  Copyright © 2021 caesar. All rights reserved.
//

#import "HDDBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HDDFreightRulesTool : HDDBaseModel

//获取司机运费规则字符串
+ (NSString *)getDriverFreightRules:(NSInteger )rules;

//司机运费抹零规则
+ (NSString *)getDriverFreightSetZeroRules:(NSInteger)rules freightNum:(NSString *)freightNum;

//应付司机运费抹零规则
+ (NSString *)getDriverFreightShouldPayRules:(NSInteger)rules freightNum:(NSString *)freightNum;

//获取运价单位 不带括号
+ (NSString *)getGoodsPriceUnitNoBrackets:(NSInteger)unit;
//获取运价单位
+ (NSString *)getGoodsPriceUnit:(NSInteger)unit;
//获取发货数量
+ (NSString *)getDriverGoodsUnit:(NSInteger)unit;

//获取最大扣除 单位重量单位
+ (NSString *)getUnit:(NSInteger)unit;

//获取统计时间汉字类型
+ (NSString *)getStatisShowTimeType:(NSString *)timeType;

//获取统计时间 参数类型
+ (NSString *)getStatisParamTimeType:(NSString *)timeType;


/**获取油费类型1.无油费2.有油费*/
+ (NSString *)getOilConfigType:(NSInteger)type;

/**获取油费支付类型1.预付时付油费2.支付时付油费*/
+ (NSString *)getOilPaymentMomentType:(NSInteger)type;

/**获取油费支付方式1.电子钱包2.线下*/
+ (NSString *)getOilPaymentType:(NSInteger)type;

/**获取油费计算方式1固定金额2运费比例*/
+ (NSString *)getOilCalculationMethodType:(NSInteger)type;

//获取收款方式
+ (NSString *)getPaymentType:(NSInteger)type;
//获取预付设置
+ (NSString *)getPrepayType:(NSInteger)type;

//获取支付方式
+ (NSString *)getPayType:(NSInteger)type;

+(NSString *)resetCurrentNum:(NSString *)currentNum;
//获取车队长扣款方式 车队长费用扣款方式:0空;1外扣;2内扣;
+ (NSString *)getChiefDriverDeductType:(NSInteger)type;



@end

NS_ASSUME_NONNULL_END
