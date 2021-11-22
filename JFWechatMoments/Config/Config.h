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

//通知-用于刷新tableview列表
UIKIT_EXTERN NSString *const Nofication_RefreshTableView;

@end
