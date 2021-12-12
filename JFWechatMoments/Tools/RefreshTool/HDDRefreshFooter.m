//
//  HDDRefreshFooter.m
//  HelloParents
//
//  Created by caesar on 2017/7/25.
//  Copyright © 2017年 HelloParents. All rights reserved.
//

#import "HDDRefreshFooter.h"

@implementation HDDRefreshFooter

+(instancetype)footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock{
    MJRefreshAutoStateFooter *footer = [super footerWithRefreshingBlock:refreshingBlock];
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"加载中..." forState:MJRefreshStatePulling];
    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    return (HDDRefreshFooter *)footer;
}
@end
