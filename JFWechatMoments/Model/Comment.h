//
//  Comment.h
//  JFWechatMoments
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Comment : NSObject

@property(nonatomic, copy) NSString *content;
@property(nonatomic, strong) User *sender;
/**
 评论内容富文本
 */
@property(nonatomic, strong) NSAttributedString *attributedContent;

@end
