//
//  HDDBaseCell.m
//  Driver
//
//  Created by caesar on 2020/1/17.
//  Copyright © 2020 caesar. All rights reserved.
//

#import "HDDBaseCell.h"

@implementation HDDBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = UnitBGColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setModel:(id)model{
    _model = model;
}

@end
