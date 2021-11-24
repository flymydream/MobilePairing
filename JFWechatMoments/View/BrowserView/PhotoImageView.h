//
//  PhotoImageView.h
//  JFWechatMoments
//
//  Created by hero on 2021/11/24.
//  Copyright © 2021 fanzhiying. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoImageView : UIImageView
/**
 *  原始imageView
 */
@property (nonatomic,strong) UIImageView *sourceImageView;
/**
 *  图片url
 */
@property (nonatomic,strong) NSString *imageUrl;

@end

NS_ASSUME_NONNULL_END
