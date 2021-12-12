//
//  HDDBaseListViewController.m
//  Driver
//
//  Created by caesar on 2020/1/22.
//  Copyright © 2020 caesar. All rights reserved.
//

#import "HDDBaseListViewController.h"

@interface HDDBaseListViewController ()

@end

@implementation HDDBaseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
}
- (void)initTableView{
    if (!_mainTableView) {
        _mainTableView = [[HDDBaseTabelView alloc]init];
        _mainTableView.backgroundColor = self.view.backgroundColor = F0EFF4BGColor;
        [self.view addSubview:_mainTableView];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.showsHorizontalScrollIndicator = NO;
    }
    kWeakSelf(self);
    HDDRefreshHeader * header =[HDDRefreshHeader headerWithRefreshingTarget:self refreshingAction:NSSelectorFromString(@"getNewData")];
    _mainTableView.mj_header = header;
    HDDRefreshFooter * footer = [HDDRefreshFooter footerWithRefreshingBlock:^{
        kStrongSelf(self);
        [self getMoreData];
    }];
    _mainTableView.mj_footer = footer;
}
- (void)loadData:(int)page with:(MJRefreshComponent *)component{
    [component endRefreshing];
}

- (void)getNewData{
    self.pageNum = 1;
    [self loadData:self.pageNum with:self.mainTableView.mj_header];
}

- (void)getMoreData{
    self.pageNum ++;
    [self loadData:self.pageNum with:self.mainTableView.mj_footer];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    _mainTableView.mj_footer.hidden = !self.datasource.count;
    return self.datasource.count;
//    return 10;
}
- (UITableViewCell *)tableView:(HDDBaseTabelView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HDDBaseModel * model = self.datasource[indexPath.row];
    //创建cell
    HDDBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:tableView.identifier? tableView.identifier:[model getCellName] forIndexPath:indexPath];
//    HDDBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:tableView.identifier forIndexPath:indexPath];
//    //赋值
    [cell setDelegate:self];
    [cell setModel:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *height = @(cell.frame.size.height);
    [self.rowheightsource setObject:height forKey:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSNumber *height = [self.rowheightsource objectForKey:indexPath];
    return height?height.floatValue:50;
}

- (NSMutableArray *)datasource{
    if (!_datasource) {
        _datasource = [NSMutableArray new];
    }
    return _datasource;
}

- (NSMutableDictionary *)rowheightsource{
    if (!_rowheightsource) {
        _rowheightsource = [NSMutableDictionary new];
    }
    return _rowheightsource;
}







@end
