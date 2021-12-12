//
//  HDDUpdateTool.m
//  Driver
//
//  Created by caesar on 2020/4/1.
//  Copyright © 2020 caesar. All rights reserved.
//

#import "HDDUpdateTool.h"

//{
// "appName":"TMSApp",    //app名称
//     "newVersion": "0.4.2",  //当前最新版本号
//     "forceUpdate": "0",  //是否强制更新：0：否；1：强制
//     "lastForceUpdateVer": "0",  //最近一次强制更新的版本号
//     "updateDesc": "1.加入添加合作车辆；\r\n2.优化性能",  //本次版本发布更新内容
//     "updateLink": "http://webapi.i-tms.cn/UpdateApp/TMSApp/i-Tms.apk",   //app下载地址（后台链接）
//"grayRelease":"0",    //忽略
//"grayReleaseTarget": "",  //忽略
// "grayReleaseLink": ""    //忽略
// }
@implementation HDDUpdateTool
static NSString * currentVersion;

+ (void)updateProject{
    
    currentVersion = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSMutableDictionary *paramDict = [NSMutableDictionary new];
    [paramDict setValue:currentVersion forKey:@"versionId"];
    [AFNetworkRequestTool getWithURLString:API_CheckIOSVersion parameters:paramDict success:^(id  _Nonnull responseObject) {
         if (![NSString isBlankString:responseObject[@"newVersion"]]) {
             BOOL result = [currentVersion caseInsensitiveCompare:responseObject[@"newVersion"]] == NSOrderedAscending;
             if (result && [responseObject[@"forceUpdate"] integerValue] > 0) {
                 //发送强制更新的通知
                 NOTIFY_POST_PARAMENT(UPDATE_NOTIfI_NAME, responseObject);
             }
          }
        
     } failure:^(NSError * _Nonnull error) {
        
     }];
}

//普通升级话弹出
+ (void)showUpdateAlert:(NSInteger)state{
//    0：无更新 1：普通 2：强制
    if (state == 1) {
        //普通更新 itms-apps://itunes.apple.com/cn/app/id1219952259?mt=8
        [XWAlert showAlertWithTitle:@"发现新版本" message:@"现在去应用商店更新吧" confirmTitle:@"现在就去" cancelTitle:@"取消" preferredStyle:UIAlertControllerStyleAlert confirmHandle:^{
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/id1584269521?mt=8"]];
            @throw [NSException exceptionWithName:NSGenericException
                                           reason:@"crash-self-ensure"
                                         userInfo:nil];
        } cancleHandle:^{}];
        
    }else if (state == 2){
        //强制更新
        [self forcedToUpgradeMethod];
    }
}

//强制升级的方法
+ (void)forcedToUpgradeMethod{
    //强制  itms-apps://itunes.apple.com/cn/app/id1219952259?mt=8
    [XWAlert showAlertWithTitle:@"发现新版本" message:@"现在去应用商店更新吧" confirmTitle:@"现在就去" cancelTitle:nil preferredStyle:UIAlertControllerStyleAlert confirmHandle:^{
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/id1584269521?mt=8"]];
        @throw [NSException exceptionWithName:NSGenericException
                                       reason:@"crash-self-ensure"
                                     userInfo:nil];
    } cancleHandle:^{}];
}


@end
