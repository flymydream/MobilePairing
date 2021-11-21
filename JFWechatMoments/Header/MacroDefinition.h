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

#endif /* MacroDefinition_h */
