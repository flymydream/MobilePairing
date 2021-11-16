//
//  NetRequest.h
//  JFWechatMoments
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(id response);

typedef void(^FailureBlock)(NSError *error);

@interface NetRequest : NSObject

/**
 Get请求方法

 @param urlString 请求服务器地址
 @param successBlock 请求成功回调
 @param failureBlock 请求失败回调
 */
+ (void)RequestGetWithUrl:(NSString *)urlString success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

@end
