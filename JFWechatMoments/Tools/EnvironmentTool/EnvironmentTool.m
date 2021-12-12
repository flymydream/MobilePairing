//
//  EnvironmentTool.m
//  Shipper
//
//  Created by caesar on 2021/2/3.
//  Copyright © 2021 caesar. All rights reserved.
//

#import "EnvironmentTool.h"

@implementation EnvironmentTool
SingletonM

- (EnvironmentType)environment{
    
    NSString * environmentInDefaults = [[NSUserDefaults standardUserDefaults] objectForKey:@"environment"];
    //第一次未设置的情况下直接返回开发模式作为默认，并写入
    if (!environmentInDefaults) {
        [[NSUserDefaults standardUserDefaults] setValue:@"2" forKey:@"environment"];
        //测试环境
        return EnvironmentTest;
    }
    
    switch (environmentInDefaults.intValue) {
            
        case 1:
            
            return EnvironmentDevelopment;
            break;
        case 2:
            
            return EnvironmentTest;
            break;
            
        case 3:

            return EnvironmentPrepare;
            break;
            
        case 4:

            return EnvironmentProduction;
            break;

        default:
            return EnvironmentProduction;
            break;
    }
}
- (void)setEnvironment:(EnvironmentType)environment{
    
    switch (environment) {
            
        case EnvironmentDevelopment:
            [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"environment"];
            
            break;
        case EnvironmentTest:
            [[NSUserDefaults standardUserDefaults] setValue:@"2" forKey:@"environment"];
            
            break;
            
        case EnvironmentPrepare:
            [[NSUserDefaults standardUserDefaults] setValue:@"3" forKey:@"environment"];
            
            break;
            
        case EnvironmentProduction:
            [[NSUserDefaults standardUserDefaults] setValue:@"4" forKey:@"environment"];
            
            break;
            
        default:
            break;
    }
}

- (NSString *)currentAPI{
    
    switch ([self environment]) {
     
        case EnvironmentDevelopment:
            return API_BASE_URL_Development;
            break;
        case EnvironmentTest:
            return API_BSAE_URL_TEST;
            break;
        case EnvironmentPrepare:
            return API_BASE_URL_Prepare;
            break;
            
        case EnvironmentProduction:
            return API_BASE_URL_Production;
            break;
            
        default:
            return API_BASE_URL_Production;
            break;
    }
}
//用于H5解析二维码
- (NSString *)codeStringAPI{
    
    switch ([self environment]) {
     
        case EnvironmentDevelopment:
            return API_BASE_H5URL_Development;
            break;
        case EnvironmentTest:
            return API_BSAE_H5URL_TEST;
            break;
        case EnvironmentPrepare:
            return API_BASE_H5URL_Prepare;
            break;
            
        case EnvironmentProduction:
            return API_BASE_H5URL_Production;
            break;
            
        default:
            return API_BASE_H5URL_Production;
            break;
    }
}

@end
