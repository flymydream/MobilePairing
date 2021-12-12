//
//  HDDRefreshHeader.m
//  HelloParents
//
//  Created by caesar on 2017/7/25.
//  Copyright © 2017年 HelloParents. All rights reserved.
//

#import "HDDRefreshHeader.h"

@interface HDDRefreshHeader ()
@property (nonatomic, strong) NSMutableArray *headerPull;
@property (nonatomic, strong) NSMutableArray *headerRefresh;
@end

@implementation HDDRefreshHeader

- (void)prepare{
    [super prepare];
    
    self.lastUpdatedTimeLabel.hidden = true;
    self.automaticallyChangeAlpha = YES;
    self.stateLabel.font = [UIFont systemFontOfSize:12];
    [self setImages:@[self.headerRefresh.firstObject] forState:MJRefreshStateIdle];
    [self setImages:self.headerPull forState:MJRefreshStatePulling];
    [self setImages:self.headerRefresh forState:MJRefreshStateRefreshing];
    [self setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"刷新中" forState:MJRefreshStateRefreshing];
}
- (void)placeSubviews{
    [super placeSubviews];
    self.mj_h = 100;
    self.gifView.contentMode = UIViewContentModeScaleAspectFill;
    self.gifView.frame = CGRectMake(self.mj_w / 2 - 50,20, 100, 45);
    self.stateLabel.frame = CGRectMake(0,65, self.mj_w, 20);
}
- (NSMutableArray *)headerPull{
    if (!_headerPull) {
        _headerPull = [NSMutableArray array];
        for (int i=1; i <= 6; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"pulling-%d",i]];
            [_headerPull addObject:image];
        }
    }
    return _headerPull;
}
-(NSMutableArray *)headerRefresh{
    if (!_headerRefresh) {
        _headerRefresh = [NSMutableArray array];
        for (int i = 1; i <= 16; i++) {
           UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh-%d",i]];
           [_headerRefresh addObject:image];
        }
    }
    return _headerRefresh;
}

@end
