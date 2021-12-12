//
//  HDDUpdateView.h
//  Driver
//
//  Created by caesar on 2020/9/25.
//  Copyright © 2020 caesar. All rights reserved.
//

#import "HDDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HDDUpdateView : HDDBaseView
//创建强制更新视图
+(instancetype)defaultUpdateView;
@property (nonatomic, strong) NSDictionary *dict;


@end

NS_ASSUME_NONNULL_END
