//
//  Tweet.h
//  JFWechatMoments
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property(nonatomic, copy) NSString *content;
@property(nonatomic, copy) NSArray *images;
@property(nonatomic, strong) User *sender;
@property(nonatomic, copy) NSArray *comments;
/**
 content的展开状态
 YES为全文状态，NO为收起状态
 */
@property(nonatomic, assign) BOOL isOpening;
/**
 是否需要显示全文按钮
 */
@property(nonatomic, assign) BOOL shouldShowMoreButton;

@end
