//
//  WebImageManage.h
//  JFWechatMoments
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 获取图片结果回调

 @param image 图片
 @param error 错误
 @param success 是否获取成功
 */
typedef void(^DownloadCompletedBlock)(UIImage *image, NSError *error, BOOL success);

@interface WebImageManage : NSObject

+ (WebImageManage *)shareWebImageManage;

/**
 获取网络图片

 @param urlString 图片地址
 @param completedBlock 获取完成回调
 */
- (void)getImageWithURL:(NSString *)urlString DownloadCompletedBlock:(DownloadCompletedBlock)completedBlock;

@end
