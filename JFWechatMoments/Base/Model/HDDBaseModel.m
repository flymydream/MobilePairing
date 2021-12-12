//
//  HDDBaseModel.m
//  Driver
//
//  Created by caesar on 2020/1/17.
//  Copyright © 2020 caesar. All rights reserved.
//

#import "HDDBaseModel.h"

@implementation HDDBaseModel



+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID":@"id"};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID" : @"id"};
}

- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key{}

- (NSString *)getCellName{
    return nil;
}
@end
