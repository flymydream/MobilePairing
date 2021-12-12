//
//  AFNetworkRequestTool.m
//  Shipper
//
//  Created by caesar on 2021/2/3.
//  Copyright © 2021 caesar. All rights reserved.
//

#import "AFNetworkRequestTool.h"
static NSTimeInterval af_timeout = 30.0f;

@implementation AFNetworkRequestTool

+ (AFHTTPSessionManager*)CreatManagerWithType{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    if (isJson) {
//        manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    }else{
//        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    }
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript", @"text/plain", nil];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = af_timeout;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    // 设置允许同时最大并发数量，过大容易出问题
    manager.operationQueue.maxConcurrentOperationCount = 1;
    //支持后台上传
//    manager.attemptsToRecreateUploadTasksForBackgroundSessions = YES;
    NSString *token = [HDDUserModel standardUser].token;
    if (token) {
        NSLog(@"当前登录的token=%@",token);
       [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
//        userAgent = [NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%0.2f)",@"MolyfunParents", [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey], [self iphoneType], [[UIDevice currentDevice] systemVersion], [[UIScreen mainScreen] scale]];
    }
    return manager;
}

//GET请求类
+ (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(id responseObject))success
                 failure:(void (^)(NSError *error))failure{
    [self cancelAllTask];
        [[self CreatManagerWithType] GET:[NSString stringWithFormat:@"%@%@",[EnvironmentTool sharedInstance].currentAPI,URLString] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                id obj;
                if (responseObject) {
                    obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                    NSLog(@"get请求的URL:%@ 参数=%@",[NSString stringWithFormat:@"%@%@",[EnvironmentTool sharedInstance].currentAPI,URLString],parameters);
    //                NSLog(@"responseObject ===%@",DataTOStr(obj));
                    //token失效
                    if ([obj[@"code"] integerValue] == 401) {
                        [self jumpToLoginOperation:[obj[@"code"] integerValue]];
                        return;
                    }
                    //校验库存接口 30020提示错误信息
                    if ([URLString containsString:API_HasStockByGoodsCode]) {//有库存
                        success(obj);
                    } else {
                        if([obj[@"code"] integerValue] != 200 && [obj[@"code"] integerValue] != 1000){
                            [HDDLoadingView hideLoadingWindowView];
                             NSString *message = obj[@"msg"];
                             if ([NSString isBlankString:message]) {
                                 message = obj[@"message"];
                             }
                             if (![NSString isBlankString:message] && ![message isEqualToString:@"司机不存在，请手动添加"]) {
                                 [HDDCustomToastView showMessageTitle:message andDelay:1.5];
                             }
                            failure([NSError mj_error]);
                            return ;
                        }
                        success(obj[@"data"]);
                    }
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
            //通讯协议状态码
            NSInteger statusCode = response.statusCode;
            if (statusCode == 401) {
                [self jumpToLoginOperation:statusCode];
            }else{
                if (error.code == -1009) {//数据权限
                    [HDDCustomToastView showError:@"数据权限已关闭，请前往设置"];
                }else if (error.code == -1001){ //请求超时
                    [HDDCustomToastView showError:@"网络请求超时"];
                }else if (error.code == -1004){ //无法连接服务器
                    [HDDCustomToastView showError:@"网络异常，请重试"];
                }else{
                    DebugLog(@"接口请求报错");
    //                [HDDCustomToastView showError:@"网络错误"];
                }
                failure(error);
            }
        }];
    
}
/*
*POST
*
*/
+ (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure{
    [self cancelAllTask];
    NSLog(@"POST----%@",[NSString stringWithFormat:@"%@%@",[EnvironmentTool sharedInstance].currentAPI,URLString]);
    [[self CreatManagerWithType] POST:[NSString stringWithFormat:@"%@%@",[EnvironmentTool sharedInstance].currentAPI,URLString] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
               if (success) {
                   id obj;
                   if (responseObject) {
                       obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                       NSLog(@"post请求的URL:%@ dict=%@",[NSString stringWithFormat:@"%@%@",[EnvironmentTool sharedInstance].currentAPI,URLString],parameters);
       //                NSLog(@"responseObject ===%@",DataTOStr(obj));
                       //token失效
                   if ([obj[@"code"] integerValue] == 401) {
                          [self jumpToLoginOperation:[obj[@"code"] integerValue]];
                          return;
                       }
                       //校验余量涉及到 上传卸货信息接口,断短期货源是否有库存,批量派单,修改运单
                       if ([URLString containsString:SHIPMENT_MPSHIPMENT_UPDATEUNLOADNETWEIGHT] || [URLString containsString:API_BatchAddShipment] || [URLString containsString:SHIPMENT_MPSHIPMENT_UPDATESHIPMENT]) {
                           success(obj);
                       } else {
                           if([obj[@"code"] integerValue] != 200 && [obj[@"code"] integerValue] != 1000){
                               [HDDLoadingView hideLoadingWindowView];
                               if (![URLString hasSuffix:API_GetDriverOilAccountByTel]) {//查油卡账户不需要提示
                                   NSString *message = obj[@"msg"];
                                   if ([NSString isBlankString:message]) {
                                         message = obj[@"message"];
                                   }
                                   if (![NSString isBlankString:message]) {
                                       [HDDCustomToastView showMessageTitle:message andDelay:1.5];
                                   }
                               }
                               failure([NSError mj_error]);
                               return ;
                           }
                           success(obj[@"data"]);
                       }
                   }
               }
           } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
               NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
               //通讯协议状态码
               NSInteger statusCode = response.statusCode;
               if (statusCode == 401) {
                   [self jumpToLoginOperation:statusCode];
               }else{
                   if (error.code == -1009) {//数据权限
                       [HDDCustomToastView showError:@"数据权限已关闭，请前往设置"];
                   }else if (error.code == -1001){ //请求超时
                       [HDDCustomToastView showError:@"网络请求超时"];
                   }else if (error.code == -1004){ //无法连接服务器
                       [HDDCustomToastView showError:@"网络异常，请重试"];
                   }else{
                       DebugLog(@"接口请求报错");
       //                [HDDCustomToastView showError:@"网络错误"];
                   }
                   failure(error);
               }
           }];
    
}
/*
*JSON
*
*/
+ (void)JsonMethodPostWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure{
    
}
#pragma mark ============跳转到登录页面的操作===========
+ (void)jumpToLoginOperation:(NSInteger)code{
//    //token失效
    if ([HDDUserModel standardUser].token.length > 0) {
//        [[HDDAccountModel standardAccount] restAccount];
        HDDUserModel *model = [HDDUserModel standardUser];
        [model setToken:@""];
        [model persist];
        [HDDLoginHandleClass GoLogin:1];
    }
}
#pragma mark ============取消所有请求===========
+ (void)cancelAllTask{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.operationQueue cancelAllOperations];
}
#pragma mark ============网络判定===========
+ (void)isReachAble:(void (^)(bool isreach))success
failure:(void (^)(bool notreach))failure{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:{
                failure(NO);
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                success(YES);
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                success(YES);
                break;
            }
            default:
                break;
        }
    }];
}

+ (void)netWorkStartMonitoring {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

+ (void)netWorkStopMonitoring {
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

+ (BOOL)isNetworkReachable {
    return [[AFNetworkReachabilityManager sharedManager] isReachable];
}

+ (NSInteger)netWorkReachableStatus {
    return [[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus];
}
@end
