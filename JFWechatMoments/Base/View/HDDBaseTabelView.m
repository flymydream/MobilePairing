//
//  HDDBaseTabelView.m
//  Driver
//
//  Created by caesar on 2020/1/17.
//  Copyright © 2020 caesar. All rights reserved.
//

#import "HDDBaseTabelView.h"


@interface HDDBaseTabelView ()<CYLTableViewPlaceHolderDelegate>

@end

@implementation HDDBaseTabelView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    
//    self.backgroundColor = KCustomAdjustColor(BackColor, DarkBlackColor);
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    if ([self respondsToSelector:@selector(setCellLayoutMarginsFollowReadableWidth:)]) {
        self.cellLayoutMarginsFollowReadableWidth = NO;
    }
    [self setTableFooterView:[UIView new]];
}

- (void)registerNibIdentifier:(NSString *)identifier{
    _identifier = identifier;
    [self registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellReuseIdentifier:identifier];
}

- (void)registerClassIdentifier:(NSString *)identifier{
    _identifier = identifier;
    [self registerClass:NSClassFromString(identifier) forCellReuseIdentifier:identifier];
}

- (UIView *)makePlaceHolderView{
    
    UIView * emptyView = [UIView new];
    emptyView.userInteractionEnabled = NO;
    UIImageView * emptyImage = [UIImageView new];
    emptyImage.image = [UIImage imageNamed:@"nodata"];
    [emptyView addSubview:emptyImage];
    
    [emptyImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(emptyView.mas_centerX);
        make.centerY.equalTo(emptyView.mas_centerY).offset(-30);
    }];
    
    UILabel *textLabel = [[UILabel alloc]init];
    textLabel.textColor = HexRGB(0x666666);
    textLabel.font = FontSize(13);
    textLabel.text = self.remindStr.length > 0 ? self.remindStr : @"空空如也";
    [emptyView addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(emptyImage.mas_bottom).offset(0);
        make.centerX.equalTo(emptyView.mas_centerX);
        make.height.mas_equalTo(@22);
    }];
    
    return emptyView;
}
-(BOOL)enableScrollWhenPlaceHolderViewShowing{
    return YES;
}


@end
