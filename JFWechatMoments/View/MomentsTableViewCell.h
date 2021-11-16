//
//  MomentsTableViewCell.h
//  JFWechatMoments
//

#import <UIKit/UIKit.h>

@interface MomentsTableViewCell : UITableViewCell

/**
 更多按钮点击回调
 */
@property(nonatomic, copy) void (^clickedMoreButtonBlock)(NSIndexPath *indexPath);

/**
 设置cell数据

 @param indexPath 当前NSIndexPath
 @param tweets 数据源
 */
- (void)configCell:(NSIndexPath *)indexPath tweets:(NSArray *)tweets;

@end
