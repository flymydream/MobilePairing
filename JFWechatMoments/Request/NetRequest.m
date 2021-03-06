//
//  NetRequest.m
//  JFWechatMoments
//

#import "NetRequest.h"

@implementation NetRequest

+ (void)requestGetWithUrl:(NSString *)urlString success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock {

    NSString *completeUrl = [NSString stringWithFormat:@"%@%@", HostUrl, urlString];
    [[AFHTTPSessionManager manager] GET:completeUrl parameters:nil progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        failureBlock(error);
    }];
}

@end
