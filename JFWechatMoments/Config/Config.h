//
//  Config.h
//  JFWechatMoments
//

#import <Foundation/Foundation.h>

@interface Config : NSObject

UIKIT_EXTERN NSString *const HostUrl;
// 获取用户信息
UIKIT_EXTERN NSString *const UserInfoUrl;
// 获取用户朋友圈
UIKIT_EXTERN NSString *const UserTweetsUrl;

//本地字典
UIKIT_EXTERN NSString *const LocalImageDict;

@end
