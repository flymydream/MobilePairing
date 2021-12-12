//
//  EnvironmentTool.h
//  Shipper
//
//  Created by caesar on 2021/2/3.
//  Copyright © 2021 caesar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*1.开发环境
 2.预发布环境
 3.正式环境*/
typedef NS_ENUM(NSInteger, EnvironmentType)
{
    EnvironmentDevelopment = 1,
    EnvironmentTest,
    EnvironmentPrepare,
    EnvironmentProduction,
};
@interface EnvironmentTool : NSObject
SingletonH
@property (assign, nonatomic) EnvironmentType environment;
@property (strong, nonatomic) NSString * currentAPI;
//用于H5解析二维码
@property (nonatomic, strong) NSString * codeStringAPI;

@end

NS_ASSUME_NONNULL_END
