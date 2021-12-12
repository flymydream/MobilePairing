//
//  HDDNumberTool.h
//  Shipper
//
//  Created by huodada on 2021/6/29.
//  Copyright © 2021 caesar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDDNumberTool : NSObject

/**当数据大于等于万 大于等于亿处理单位 - 只返回单位*/
+ (NSString *)getBigNumber:(NSString *)number unit:(NSString *)unit;
/**当数据大于等于万 大于等于亿处理数据 只返回处理过后的数字 不带单位*/
+ (NSString *)getBigNumber:(NSString *)number;
/**当数据大于等于万 大于等于亿处理数据 返回数据带单位*/
+ (NSString *)getOrderBigNumber:(NSString *)number;


/**处理数据展示 如果不包含小数点直接展示 包含小数点(小数点后大于2位则保留2位)*/
+ (NSString *)getNumDecimalPointByStr:(NSString *)numStr;




@end

NS_ASSUME_NONNULL_END
