//
//  JFDataManager.m
//  JFWechatMoments
//
//  Created by hero on 2021/11/21.
//  Copyright © 2021 fanzhiying. All rights reserved.
//

#import "JFDataManager.h"

@implementation JFDataManager

//获得应用的沙盒路径
+(NSString *)documentPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true) firstObject];
}

+ (NSString *)documentAppendPath:(NSString *)fileName {
    return [[[self class] documentPath] stringByAppendingString:fileName];
    
}
//获得当前存放下载图片的文件目录
+(NSString *)documentSaveImageFile {
    return [[self class] documentAppendPath:@"/JFWebImageFile"];
}

+ (NSString *)imageNameForBase64Handle:(NSString *)path {
    //将路径通过UTF-8编码
    NSData *data = [path dataUsingEncoding:NSUTF8StringEncoding];
    //将字符串进行base64处理
    NSString *imageNameBase = [data base64EncodedStringWithOptions:0];
    return imageNameBase;
}

+ (NSString *)documentImageFileAppendBase64File:(NSString *)fileName{
    
    return [[self class] documentImagefileAppendFile:[[self class] imageNameForBase64Handle:fileName]];
}


+ (NSString *)documentImagefileAppendFile:(NSString *)fileName {
    return [[[self class] documentSaveImageFile] stringByAppendingPathComponent:fileName];
}


@end
