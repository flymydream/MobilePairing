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


#endif /* MacroDefinition_h */
