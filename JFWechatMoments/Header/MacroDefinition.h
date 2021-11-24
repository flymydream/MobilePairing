//
//  MacroDefinition.h
//  JFWechatMoments
//
//  Created by hero on 2021/11/19.
//  Copyright © 2021 fanzhiying. All rights reserved.
//

#ifndef MacroDefinition_h
#define MacroDefinition_h


#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

#define KKeyWindow [UIApplication sharedApplication].keyWindow

#define IsBangsScreen ([[UIApplication sharedApplication] statusBarFrame].size.height>20?YES:NO)
#define kStatuBarHeight  ([[UIApplication sharedApplication] statusBarFrame].size.height)

//强弱引用
#define kWeakSelf(type)__weak typeof(type)weak##type = type
#define kStrongSelf(type)__strong typeof(type)type = weak##type

#define kUserDefaults [NSUserDefaults standardUserDefaults]
// 本地存储对象
#define JFSetValueforKey(value, key) [[NSUserDefaults standardUserDefaults] setValue:value forKey:key]
// 获取本地存储对象
#define JFValueWithKey(key) [[NSUserDefaults standardUserDefaults] valueForKey:key]
//移除本地存储
#define JFRemoveWithKey(key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:key]

// 注册通知
#define NOTIFY_ADD(_noParamsFunc, _notifyName)  [[NSNotificationCenter defaultCenter] \
addObserver:self \
selector:@selector(_noParamsFunc) \
name:_notifyName \
object:nil];

// 移除通知
#define NOTIFY_REMOVE(_notifyName) [[NSNotificationCenter defaultCenter] removeObserver:self name:_notifyName object:nil];

// 发送通知
#define NOTIFY_POST(_notifyName)   [[NSNotificationCenter defaultCenter] postNotificationName:_notifyName object:nil];
//发送通知，带参数
#define NOTIFY_POST_PARAMENT(_notiyName,dict) [[NSNotificationCenter defaultCenter]postNotificationName:_notiyName object:nil userInfo:dict];



#endif /* MacroDefinition_h */
