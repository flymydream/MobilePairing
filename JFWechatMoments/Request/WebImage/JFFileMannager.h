//
//  JFFileMannager.h
//  JFWechatMoments
//
//  Created by hero on 2021/11/21.
//  Copyright © 2021 fanzhiying. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JFFileMannager : NSObject

/**
 *  单例方法
 *
 *  @return JFFileMannager单例对象
 */
+ (instancetype)shareInstance;

/**
 *在沙盒默认的文件夹中是否存储了该文件
 *
 *@param url 图片的url
 *
 *@return true表示存在 false 表示不存在
 */
- (BOOL)fileIsExist:(NSString *)url;
/**
 *创建下载缓存的文件夹
 *
 * @return true表示创建成功，false表示创建失败
 */
- (BOOL)creatDownloadFile;




@end

NS_ASSUME_NONNULL_END
