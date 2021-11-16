//
//  MomentsTableViewCell.m
//  JFWechatMoments
//

#import "MomentsTableViewCell.h"
#import "MomentsPhotoView.h"
#import "MomentsCommentView.h"
#import "UIView+SDAutoLayout.h"
#import "Tweet.h"
#import "UIImageView+Web.h"
#import "UIImage+Color.h"

@interface MomentsTableViewCell ()
//UI控件
@property(nonatomic, strong) UIImageView *avatarImageView;
@property(nonatomic, strong) UILabel *nickLabel;
@property(nonatomic, strong) UILabel *contentLabel;
@property(nonatomic, strong) MomentsPhotoView *photoView;
@property(nonatomic, strong) UILabel *timeLabel;
@property(nonatomic, strong) UIButton *moreButton;
@property(nonatomic, strong) UIButton *operateButton;
@property(nonatomic, strong) MomentsCommentView *commentView;
//数据
@property(nonatomic, strong) NSIndexPath *indexPath;
@property(nonatomic, strong) Tweet *tweetModel;

@end

@implementation MomentsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //添加控件
    _avatarImageView = [[UIImageView alloc] init];

    _nickLabel = [[UILabel alloc] init];
    _nickLabel.font = [UIFont systemFontOfSize:14];
    _nickLabel.textColor = [UIColor colorWithRed:77 / 255.0 green:93 / 255.0 blue:136 / 255.0 alpha:1.0];

    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:15];
    _contentLabel.numberOfLines = 0;
    _moreButton = [[UIButton alloc] init];
    [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
    [_moreButton setTitleColor:[UIColor colorWithRed:77 / 255.0 green:93 / 255.0 blue:136 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    [_moreButton addTarget:self action:@selector(clickedMoreButton) forControlEvents:UIControlEventTouchUpInside];
    _moreButton.titleLabel.font = [UIFont systemFontOfSize:14];

    _photoView = [[MomentsPhotoView alloc] init];

    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:13];
    _timeLabel.textColor = [UIColor colorWithRed:103 / 255.0 green:103 / 255.0 blue:103 / 255.0 alpha:1.0];

    _operateButton = [[UIButton alloc] init];
    [_operateButton setImage:[UIImage imageNamed:@"btn_operate"] forState:UIControlStateNormal];

    _commentView = [[MomentsCommentView alloc] init];

    NSArray *subViews = @[_avatarImageView, _nickLabel, _contentLabel, _moreButton, _photoView, _timeLabel, _operateButton, _commentView];
    [self.contentView sd_addSubviews:subViews];
    //控件布局
    _avatarImageView.sd_layout.leftSpaceToView(self.contentView, 10).topSpaceToView(self.contentView, 15).widthIs(40).heightIs(40);
    _nickLabel.sd_layout.leftSpaceToView(_avatarImageView, 10).topEqualToView(_avatarImageView).rightSpaceToView(self.contentView, 10).heightIs(18);
    _contentLabel.sd_layout.leftEqualToView(_nickLabel).topSpaceToView(_nickLabel, 10).rightSpaceToView(self.contentView, 10).autoHeightRatio(0);
    _moreButton.sd_layout.leftEqualToView(_contentLabel).topSpaceToView(_contentLabel, 5).widthIs(30);
    _photoView.sd_layout.leftEqualToView(_contentLabel);
    _timeLabel.sd_layout.leftEqualToView(_contentLabel).topSpaceToView(_photoView, 10).heightIs(15).widthIs(150);
    _operateButton.sd_layout.rightEqualToView(_contentLabel).centerYEqualToView(_timeLabel).heightIs(25).widthIs(25);
    _commentView.sd_layout.leftEqualToView(_contentLabel).rightEqualToView(_contentLabel).topSpaceToView(_timeLabel, 10);
}

- (void)configCell:(NSIndexPath *)indexPath tweets:(NSArray *)tweets {
    _indexPath = indexPath;
    _tweetModel = tweets[indexPath.row];

    _commentView.comments = _tweetModel.comments;
    _nickLabel.text = _tweetModel.sender.nick;
    _contentLabel.text = _tweetModel.content;
    _timeLabel.text = @"3分钟前";
    _photoView.imageArray = _tweetModel.images;
    [_avatarImageView jf_setImageWithURL:_tweetModel.sender.avatar placeholderImage:[UIImage imageWithColor:[UIColor colorWithRed:234 / 255.0 green:234 / 255.0 blue:234 / 255.0 alpha:1.0]]];

    if (_tweetModel.shouldShowMoreButton) {
        _moreButton.sd_layout.heightIs(20);
        _moreButton.hidden = NO;
        if (_tweetModel.isOpening) {
            _contentLabel.sd_layout.maxHeightIs(MAXFLOAT);
            [_moreButton setTitle:@"收起" forState:UIControlStateNormal];
        } else {
            _contentLabel.sd_layout.maxHeightIs(54);
            [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
        }
    } else {
        _moreButton.sd_layout.heightIs(0);
        _moreButton.hidden = YES;
    }

    CGFloat photoTop = _tweetModel.images.count > 0 ? 10 : 0;
    UIView *topView = (_tweetModel.content == nil || _tweetModel.content.length == 0) ? _nickLabel : _moreButton;
    _photoView.sd_layout.topSpaceToView(topView, photoTop);

    UIView *bottomView = _tweetModel.comments.count > 0 ? _commentView : _timeLabel;

    [self setupAutoHeightWithBottomView:bottomView bottomMargin:15];
}

- (void)clickedMoreButton {
    _tweetModel.isOpening = !_tweetModel.isOpening;
    if (self.clickedMoreButtonBlock) {
        self.clickedMoreButtonBlock(_indexPath);
    }
}

@end
