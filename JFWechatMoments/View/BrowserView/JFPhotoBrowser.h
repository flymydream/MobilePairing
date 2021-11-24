//
//  JFPhotoBrowser.h
//  JFWechatMoments
//
//  Created by hero on 2021/11/24.
//  Copyright © 2021 fanzhiying. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JFPhotoBrowser : UIView
/**
 图片数组
 */
@property (nonatomic, copy) NSArray *photosArray;
/**
 当前index
*/
@property (nonatomic, assign) NSInteger currentIndex;
/**
 展示图片view
*/
- (void)showPhotos;
/**
 返回图片浏览器
*/
+ (instancetype)photoBrowser;


@end

NS_ASSUME_NONNULL_END
