//
//  MBProgressHUD+GIF.h
//  Driver
//
//  Created by clack on 2019/6/21.
//  Copyright © 2019 huodada. All rights reserved.
//

#import "MBProgressHUD.h"
#import "UIImage+GIF.h"

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (GIF)
+ (void)showGifToView:(UIView *)view;
+ (void)hideGifForView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
