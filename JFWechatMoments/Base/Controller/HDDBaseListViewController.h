//
//  HDDBaseListViewController.h
//  Driver
//
//  Created by caesar on 2020/1/22.
//  Copyright © 2020 caesar. All rights reserved.
//

#import "HDDBaseSubViewController.h"
#import <MJRefreshComponent.h>
NS_ASSUME_NONNULL_BEGIN

@interface HDDBaseListViewController : HDDBaseViewController<UITableViewDelegate,UITableViewDataSource,BaseCellDelegate>
@property (nonatomic, strong) HDDBaseTabelView *mainTableView;
@property (strong, nonatomic) NSMutableArray * datasource;//数据源
@property (strong, nonatomic) NSMutableDictionary * rowheightsource;//数据源

@property (assign, nonatomic) int pageNum;//服务器拉取数据时分页页码

- (void)getNewData;
- (void)getMoreData;
- (void)loadData:(int)page with:(MJRefreshComponent *)component;


@end

NS_ASSUME_NONNULL_END
