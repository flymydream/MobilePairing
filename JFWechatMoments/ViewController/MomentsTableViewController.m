//
//  MomentsTableViewController.m
//  JFWechatMoments
//

#import "MomentsTableViewController.h"
#import "Tweet.h"
#import "User.h"
#import "MomentsTableViewCell.h"

static NSString *reuseIdentifier = @"reuseIdentifier";

@interface MomentsTableViewController () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property(weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property(weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property(weak, nonatomic) IBOutlet UILabel *nickLabel;
/**
 tableview当前显示的数据
 */
@property (nonatomic, strong) NSMutableArray *tweetsArray;
/**
 请求到的所有有效数据
 */
@property (nonatomic, strong) NSMutableArray *allTweetsArray;
@property (nonatomic, copy) SuccessBlock tweetsSuccessBlock;
/**
 头部视图
 */
@property (weak, nonatomic) IBOutlet UIView *headerView;


@end

@implementation MomentsTableViewController
/**
 tableview当前显示的数据懒加载
 */
- (NSMutableArray *)tweetsArray{
    if (!_tweetsArray) {
        _tweetsArray = [[NSMutableArray alloc] init];
    }
    return _tweetsArray;
}
/**
 有效数据懒加载
 */
- (NSMutableArray *)allTweetsArray{
    if (!_allTweetsArray) {
        _allTweetsArray = [[NSMutableArray alloc] init];
    }
    return _allTweetsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self requestData];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (IsBangsScreen) {
        self.tableView.frame = CGRectMake(0, -kStatuBarHeight, kScreenWidth, kStatuBarHeight + kScreenHeight);
        self.headerView.frame = CGRectMake(0, -kStatuBarHeight, kScreenWidth, kStatuBarHeight + 260);
    }
}

- (void)requestData {
    [self requestUserInfo];
    [self requestTweets];
}

- (void)setupTableView {
    self.tableView.estimatedRowHeight = 0;
    [self.tableView registerClass:[MomentsTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    
    //通过delegate在数据请求失败, 点击Retry时进行重试
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;

    self.tableView.tableFooterView = [UIView new];
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refresh];
    }];
    //上拉加载更多
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMore];
    }];
    self.tableView.mj_footer.hidden = YES;
    //注册通知
    NOTIFY_ADD(refreshNotification:, Nofication_RefreshTableView);
}
#pragma mark-刷新列表

- (void)refreshNotification:(NSNotification *)notifi {
    [self.tableView reloadData];
}

#pragma mark - Request

- (void)requestUserInfo {
    [NetRequest requestGetWithUrl:UserInfoUrl success:^(id response) {
        User *user = [User mj_objectWithKeyValues:response];
//        [self.bgImageView jf_setImageWithURL:user.profileImage placeholderImage:[UIImage imageNamed:@"ic_bg_header"]];
//        [self.avatarImageView jf_setImageWithURL:user.avatar placeholderImage:[UIImage imageWithColor:[UIColor colorWithRed:234 / 255.0 green:234 / 255.0 blue:234 / 255.0 alpha:1.0]]];
        
        [self.bgImageView jf_setImageWithUrl:user.profileImage placeholderImage:[UIImage imageNamed:@"ic_bg_header"]];
        [self.avatarImageView jf_setImageWithUrl:user.avatar placeholderImage:[UIImage imageWithColor:[UIColor colorWithRed:234 / 255.0 green:234 / 255.0 blue:234 / 255.0 alpha:1.0]]];
        self.avatarImageView.layer.borderColor = [UIColor colorWithRed:231 / 255.0 green:231 / 255.0 blue:231 / 255.0 alpha:1.0].CGColor;
        self.avatarImageView.layer.borderWidth = 1;
        self.nickLabel.text = user.nick;
    } failure:^(NSError *error) {
        NSLog(@"请求失败%@", error);
    }];
}

- (void)requestTweets {
    [NetRequest requestGetWithUrl:UserTweetsUrl success:^(id response) {
        NSArray *allTweet = [Tweet mj_objectArrayWithKeyValuesArray:response];
        [self checkResponse:allTweet];
        [self refresh];
    } failure:^(NSError *error) {
        NSLog(@"请求失败%@", error);
    }];

    kWeakSelf(self);
    _tweetsSuccessBlock = ^(id response) {
      kStrongSelf(self);
      self.tableView.mj_footer.hidden = NO;
      if (self.tweetsArray.count < self.allTweetsArray.count) {
         [self.tableView.mj_header endRefreshing];
         [self.tableView.mj_footer endRefreshing];
      } else {
         [self.tableView.mj_footer endRefreshingWithNoMoreData];
      }
      [self.tableView reloadData];
    };
}

- (void)refresh {
    [self.tweetsArray removeAllObjects];
    if (self.allTweetsArray.count <= 5) {
        [self.tweetsArray addObjectsFromArray:self.allTweetsArray];
    } else {
        [self.tweetsArray addObjectsFromArray:[self.allTweetsArray subarrayWithRange:NSMakeRange(0, 5)]];
    }
    _tweetsSuccessBlock(self.tweetsArray);
}

- (void)loadMore {
    NSInteger diffCount = self.allTweetsArray.count - self.tweetsArray.count;
    if (diffCount <= 5) {
        [self.tweetsArray addObjectsFromArray:[self.allTweetsArray subarrayWithRange:NSMakeRange(self.tweetsArray.count, diffCount)]];
    } else {
        [self.tweetsArray addObjectsFromArray:[self.allTweetsArray subarrayWithRange:NSMakeRange(self.tweetsArray.count, 5)]];
    }
    _tweetsSuccessBlock(self.tweetsArray);
}

- (NSInteger)checkResponse:(NSArray *)allTweet {
    for (Tweet *tweet in allTweet) {
        CGRect textRect = [tweet.content boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 70, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil];
        // 文字高度大于设定高度时显示“全文”按钮
        if (textRect.size.height > 54) {
            tweet.shouldShowMoreButton = YES;
        } else {
            tweet.shouldShowMoreButton = NO;
        }
        [self.allTweetsArray addObject:tweet];
    }
    return self.allTweetsArray.count;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweetsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MomentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    [cell prepareForReuse];
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    if(indexPath.row < [self.tweetsArray count]){
        Tweet *tweetModel = self.tweetsArray[indexPath.row];
        cell.tweetModel = tweetModel;
        [cell setClickedMoreButtonBlock:^{
            tweetModel.isOpening = !tweetModel.isOpening;
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self cellHeightForIndexPath:indexPath cellContentViewWidth:[UIScreen mainScreen].bounds.size.width];
}

#pragma mark - DZNEmptyDataSetSource

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return 20;
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSDictionary *attributes = @{
            NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f],
            NSForegroundColorAttributeName: [UIColor blueColor]
    };
    return [[NSAttributedString alloc] initWithString:@"Retry" attributes:attributes];
}

#pragma mark - DZNEmptyDataSetDelegate

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    [self requestUserInfo];
    [self requestTweets];
}

#pragma mark-收到内存警告

- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   [[JFDownloadManager shareDownloadManage].imageCache removeAllObjects];
   [[JFDownloadManager shareDownloadManage].queue cancelAllOperations];
}

- (void)dealloc {
    NOTIFY_REMOVE(Nofication_RefreshTableView);
}

@end
