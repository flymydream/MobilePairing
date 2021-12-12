//
//  HDDBaseNavigationController.m
//  Driver
//
//  Created by caesar on 2020/1/16.
//  Copyright © 2020 caesar. All rights reserved.
//

#import "HDDBaseNavigationController.h"


@interface HDDBaseNavigationController ()<UIGestureRecognizerDelegate>

@property (nonatomic, assign) BOOL isEnableEdegePan;

@end

@implementation HDDBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self configInfo];
}

- (void)setupUI{
    
    self.navigationBar.translucent = NO;
    self.navigationBar.tintColor = WhiteColor;
    self.navigationBar.barTintColor = APPColor;
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[NSString setHelveticaBoldFont:18],NSForegroundColorAttributeName:WhiteColor}];
    
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
}

- (void)configInfo{
    //设置手势代理
    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
    //自定义手势
    //调用系统的target-action方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:gesture.delegate action:NSSelectorFromString(@"handleNavigationTransition:")];
    [gesture.view addGestureRecognizer:pan];
    
    gesture.delaysTouchesBegan = YES;
    pan.delegate = self;
}
//禁用边缘侧滑手势
- (void)enableScreenEdgePanGestureRecognizer:(BOOL)isEnable{
    _isEnableEdegePan = isEnable;
}
- (void)setEditing:(BOOL)editing{
    _editing = editing;
}
#pragma mark - UIGestureRecognizerDelegate
//- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer{
//
//    return self.childViewControllers.count > 1;
//}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
           if (self.childViewControllers.count == 1 ) {
               return NO;
           }
           if (self.interactivePopGestureRecognizer &&
               [[self.interactivePopGestureRecognizer.view gestureRecognizers] containsObject:gestureRecognizer]) {
               CGPoint tPoint = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:gestureRecognizer.view];
               if (tPoint.x >= 0) {
                   CGFloat y = fabs(tPoint.y);
                   CGFloat x = fabs(tPoint.x);
                   CGFloat af = 30.0f/180.0f * M_PI;
                   CGFloat tf = tanf(af);
                   if ((y/x) <= tf) {
                       return YES;
                   }
                   return NO;
                   
               }else{
                   return NO;
               }
           }
       }
       return YES;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    if (self.childViewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIImage *selectedImage = [UIImage imageNamed:@"nav_back"];
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:selectedImage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    }
     //必须写这个方法
    [super pushViewController:viewController animated:animated];
}

- (void)back{
    if (self.presentingViewController) {
        
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }else{
         [self popViewControllerAnimated:YES];
    }
    
}
//当设置了 childViewControllerForStatusBarStyle 后，不会进入这里
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


@end
