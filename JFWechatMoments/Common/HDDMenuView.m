//
//  HDDMenuView.m
//  Shipper
//
//  Created by caesar on 2021/3/4.
//  Copyright © 2021 caesar. All rights reserved.
//

#import "HDDMenuView.h"
#define kItemHeight 25.f       // item 高
@interface HDDMenuView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end
@implementation HDDMenuView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    [self rounded:4];
    [self shadow:HexRGBAlpha(0xA8A8A8, 0.7) opacity:0.8 radius:4 offset:CGSizeMake(0,0)];
    self.tableView.frame = self.bounds;
    [self addSubview:self.tableView];
}
- (void)setTitleSource:(NSMutableArray *)titleSource{
    _titleSource = titleSource;
    if (titleSource.count >= 3) {
        self.height = kItemHeight *titleSource.count;
    }else{
        self.height = 60;
    }
    self.tableView.height = self.height;
    if (titleSource.count > 0) {
        [self.tableView reloadData];
    }
}
#pragma mark -----------UI事件------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kItemHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.backgroundColor = UnitBGColor;
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.textColor = MainTextColor;
    contentLabel.font = FontSize(11);
    contentLabel.text = self.titleSource[indexPath.row];
    [cell addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.mas_left).offset(8);
        make.right.equalTo(cell.mas_right).offset(-8);
        make.top.bottom.equalTo(cell);
    }];
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = DividerlineBgColor;
    [cell addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.mas_left).offset(8);
        make.right.equalTo(cell.mas_right).offset(-8);
        make.bottom.equalTo(cell);
        make.height.mas_equalTo(@1);
    }];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.clickMenuSelctedText) {
      self.clickMenuSelctedText(self.titleSource[indexPath.row]);
    }
}
- (UITableView *)tableView
{
    if (!_tableView) {
        self.tableView = ({
            UITableView *tableView = [UITableView new];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.tableFooterView = [UIView new];
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            tableView.showsVerticalScrollIndicator = NO;
            tableView.showsHorizontalScrollIndicator = NO;
            tableView;
        });
    }
    return _tableView;
}

@end
