//
//  AFNetworkRequestTool.h
//  Shipper
//
//  Created by caesar on 2021/2/3.
//  Copyright © 2021 caesar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AFNetworkRequestTool : NSObject
/*
*GET
*
*/
+ (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(id responseObject))success
                 failure:(void (^)(NSError *error))failure;
/*
*POST
*
*/
+ (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure;
/*
*JSON
*
*/
+ (void)JsonMethodPostWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure;

/*
*监测网络
*
*/
+ (void)isReachAble:(void (^)(bool isreach))success
            failure:(void (^)(bool notreach))failure;
/*
*取消网络请求
*
*/
+ (void)cancelAllTask;
/*
 *网络状态
 *
 */
+ (BOOL)isNetworkReachable;

/*
 *网络类型
 *
 */
+ (NSInteger)netWorkReachableStatus;

/*
 *停止监测网络
 *
 */
+ (void)netWorkStopMonitoring;

/*
 *开始监测网络
 *
 */
+ (void)netWorkStartMonitoring;
@end

NS_ASSUME_NONNULL_END
