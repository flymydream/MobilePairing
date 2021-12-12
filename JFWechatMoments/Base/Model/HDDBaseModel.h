//
//  HDDBaseModel.h
//  Driver
//
//  Created by caesar on 2020/1/17.
//  Copyright © 2020 caesar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDDBaseModel : NSObject

@property (nonatomic, copy) NSString *ID;

- (NSString *)getCellName;
@end

NS_ASSUME_NONNULL_END
