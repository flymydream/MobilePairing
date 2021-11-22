//
//  JFDownloadManager.h
//  JFWechatMoments
//
//  Created by hero on 2021/11/21.
//  Copyright © 2021 fanzhiying. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface JFDownloadManager : NSObject

/**
设置单利
 */
+ (JFDownloadManager *)shareDownloadManage;

/**
 设置网络图片（1.内存查找 2.沙盒查找 3.下载操作缓存中查找）

 @param urlString 图片地址
 @param placeholderImage 默认图片
 */
- (void)jf_getImageWithUrl:(NSString *)urlString placeholderImage:(UIImage *)placeholderImage completeCallback:(nullable void (^)(UIImage *picImage))completeCallback;




@end

NS_ASSUME_NONNULL_END
