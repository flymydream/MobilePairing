//
//  JFFileMannager.m
//  JFWechatMoments
//
//  Created by hero on 2021/11/21.
//  Copyright © 2021 fanzhiying. All rights reserved.
//

#import "JFFileMannager.h"


@interface JFFileMannager()

@property (nonatomic, strong) NSFileManager *fileManager;

@end



@implementation JFFileMannager

-(NSFileManager *)fileManager {
    return [NSFileManager defaultManager];
}

+ (instancetype)shareInstance {
    static JFFileMannager *fileManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //初始化单例对象
        fileManager = [[JFFileMannager alloc] init];
    });
    return fileManager;
}

- (BOOL)fileIsExist:(NSString *)url {
    
    //拼接路径
//    NSString *path = [JFDataManager documentImageFileAppendBase64File:url];
//    return [self.fileManager fileExistsAtPath:path];
    
    NSArray *imageArr = [url componentsSeparatedByString:@"/"];
    NSString *imageName = [imageArr lastObject];
    NSString *pathStr = [[JFDataManager documentSaveImageFile] stringByAppendingFormat:@"/%@",imageName];
    return [self.fileManager fileExistsAtPath:pathStr];
}

- (BOOL)creatDownloadFile {
    //获得存储位置的路径字符串
    NSString *path = [JFDataManager documentSaveImageFile];
    //如果存在
    if ([self folderIsExist:path]) {
        return true;
    }
    //创建文件夹
    return [self.fileManager createDirectoryAtPath:path withIntermediateDirectories:true attributes:nil error:nil];
}
//文件夹是否在沙盒存在
- (BOOL)folderIsExist:(NSString *)folderPath {
    return [self.fileManager fileExistsAtPath:folderPath];
}




@end
