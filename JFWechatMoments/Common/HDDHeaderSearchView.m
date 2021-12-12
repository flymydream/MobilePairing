//
//  HDDHeaderSearchView.m
//  Shipper
//
//  Created by caesar on 2021/3/31.
//  Copyright © 2021 caesar. All rights reserved.
//

#import "HDDHeaderSearchView.h"
@interface HDDHeaderSearchView ()<UISearchBarDelegate>
@property (nonatomic, strong) UISearchBar *searchBar;
@end
@implementation HDDHeaderSearchView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
+ (instancetype)defaultHeaderSearchView{
    return [[HDDHeaderSearchView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
}

- (void)setupUI{
    self.backgroundColor = UnitBGColor;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(kScreenWidth - 52 - 12, 7.5, 52, 35)];
    [btn setTitle:@"搜索" forState:UIControlStateNormal];
    [btn.titleLabel setFont:FontSize(14)];
    [btn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [btn setBackgroundColor:HexRGB(0x27B57D)];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(searchBarCancelButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    [self addSubview:self.searchBar];
}
- (void)setPlaceholderStr:(NSString *)placeholderStr{
    if (placeholderStr.length > 0) {
        self.searchBar.placeholder = placeholderStr;
    }
}

#pragma mark ============点击搜索按钮===========
- (void)searchBarCancelButtonClicked {
//    NSLog(@"点击搜索按钮");
    [_searchBar resignFirstResponder];
    if (self.inputSearchContentBlock) {
        self.inputSearchContentBlock(self.searchBar.text);
    }
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length == 0) {
        [searchBar resignFirstResponder];
        if (self.inputSearchContentBlock) {
            self.inputSearchContentBlock(self.searchBar.text);
        }
    }
}
//键盘上的搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    if (self.inputSearchContentBlock) {
        self.inputSearchContentBlock(self.searchBar.text);
    }
}
- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(9, 0, kScreenWidth - 52 - 12 - 9 - 6, 50)];
        _searchBar.showsCancelButton = NO;
        UITextField  *seachTextFild = [_searchBar valueForKey:@"searchField"];
        seachTextFild.font = [UIFont systemFontOfSize:14];
        _searchBar.placeholder = @"请输入搜索内容";
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        _searchBar.delegate = self;
        _searchBar.tintColor = APPColor;
    }
    return _searchBar;
}
@end
