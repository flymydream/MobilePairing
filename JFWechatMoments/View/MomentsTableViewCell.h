//
//  MomentsTableViewCell.h
//  JFWechatMoments
//

#import <UIKit/UIKit.h>
@class Tweet;

@interface MomentsTableViewCell : UITableViewCell

/**
 更多按钮点击回调
 */
@property(nonatomic, copy) void (^clickedMoreButtonBlock)(void);

/**
 设置cell数据

 @param indexPath 当前NSIndexPath
 @param tweets 数据源
 */
//- (void)configCell:(NSIndexPath *)indexPath tweets:(NSArray *)tweets;

/**数据模型*/
@property (nonatomic,strong) Tweet *tweetModel;



@end
