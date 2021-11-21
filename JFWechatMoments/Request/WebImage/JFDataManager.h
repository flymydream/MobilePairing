//
//  JFDataManager.h
//  JFWechatMoments
//
//  Created by hero on 2021/11/21.
//  Copyright © 2021 fanzhiying. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JFDataManager : NSObject
/**
 *  获得应用的沙盒路径
 *
 *  @return 沙盒路径
 */
+(NSString *)documentPath;


/**
 *  在沙盒目录下拼接路径
 *
 *  @param fileName 拼接的文件名
 *
 *  @return 拼接好的沙盒目录
 */
+ (NSString *)documentAppendPath:(NSString *)fileName;

/**
 *在当前存放下载图片的文件目录下拼接文件，文件名会进行base64转换
 *
 *@param fileName 需要拼接的文件名
 *
 *@return 拼接完毕后的沙盒目录
 */
+ (NSString *)documentImageFileAppendBase64File:(NSString *)fileName;

/**
 *在当前存放下载图片的文件目录下拼接文件
 *
 *@param fileName 需要拼接的文件名
 *
 *@return 拼接完毕后的沙盒目录
 */
+ (NSString *)documentImagefileAppendFile:(NSString *)fileName;

/**
 *  获得当前存放下载图片的文件目录
 *
 *  @return 存放图片的沙盒目录
 */
+ (NSString *)documentSaveImageFile;


/**
 *  将路径或者url转成base64处理的字符串
 *
 *  @param path 需要处理的字符串
 *
 *  @return 处理完毕的字符串
 */
+ (NSString *)imageNameForBase64Handle:(NSString *)path;




@end

NS_ASSUME_NONNULL_END
