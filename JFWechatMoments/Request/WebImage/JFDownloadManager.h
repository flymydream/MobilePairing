//
//  JFDownloadManager.h
//  JFWechatMoments
//
//  Created by hero on 2021/11/21.
//  Copyright © 2021 fanzhiying. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 *  下载成功后的回调
 *
 *  @param path  下载成功在本地的路径
 */
typedef void(^DownloadManagerFinishBlock)(NSString * path);
/**
 *  下载过程中的回调
 *
 *  @param didFinish      本次下载的文件大小
 *  @param didFinishTotal 已下载文件的大小
 *  @param total          一共需要下载文件的大小
 */
typedef void(^DownloadManagerProgressBlock)(CGFloat didFinish,CGFloat didFinishTotal,CGFloat total);

@interface JFDownloadManager : NSObject

//开始下载图片，如果存在文件，自动续点下载
- (void)startDownloadImagePath:(NSString *)imagepath;
- (void)startDownloadImageUrl:(NSURL *)imageURL;

/**
 下载成功后的回调
 */
-(void)downloadManagerFinishBlockHandler:(DownloadManagerFinishBlock)downloadManagerFinishBlockHandler;
/**
 下载过程中的回调
 */
-(void)downManagerProgressBlockHandler:(DownloadManagerProgressBlock)downloadManagerProgressBlockHandler;

@end

NS_ASSUME_NONNULL_END
