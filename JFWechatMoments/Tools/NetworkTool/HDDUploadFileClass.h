//
//  HDDUploadFileClass.h
//  Driver
//
//  Created by caesar on 2020/1/20.
//  Copyright © 2020 caesar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDDUploadFileClass : NSObject
SingletonH

//增加该属性是为了在上传认证相关图片时,隐藏loadView
@property (nonatomic, assign) BOOL hiddenLoadView;
/**
 异步上传数据
@param data : 二进制文件
@param  module :分类（属于哪个模块上传的文件）
@param  from :传递到哪里
 */
- (void)uploadGlobalFile:(NSData*)data module:(NSString*)module from:(NSString *)from  success:(void (^)(NSDictionary *dict))success
                 failure:(void (^)(NSError *error))failure;
/**
 上传数据
@param data : 二进制文件
@param  module :分类（属于哪个模块上传的文件）
@param  from :传递到哪里
 */

- (void)uploadFile:(NSData*)data module:(NSString*)module from:(NSString *)from success:(void (^)(NSDictionary * dict))success
               failure:(void (^)(NSError *error))failure;

/**
 上传文件
 
 @param  filePath 文件路径
 @param  type 上传类型 1.图片 2.视频 3.音频
 @param  module 分类（属于哪个模块上传的文件）
 */
- (void)uploadVideoFile:(NSString *)filePath type:(NSInteger)type module:(NSString*)module success:(void (^)(NSString * path))success
                    failure:(void (^)(NSError *error))failure;


//传递data数据到服务器
- (void)postSessionBodyDataWithUrl:(NSString *)strUrl  httpBobyImage:(id)images onSuccess:(void (^)(NSString * path))success onFailure:(void (^)(NSError *error))failure;


@end

NS_ASSUME_NONNULL_END
