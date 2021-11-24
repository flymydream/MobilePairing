//
//  JFPhotoBrowser.m
//  JFWechatMoments
//
//  Created by hero on 2021/11/24.
//  Copyright © 2021 fanzhiying. All rights reserved.
//

#import "JFPhotoBrowser.h"
#import "PhotoImageView.h"

#define BOTTOMSCROLLVIEWTAG 1000

@interface JFPhotoBrowser ()<UIScrollViewDelegate>
/**
 *  底层左右滑动的scrollview
 */
@property (nonatomic,strong) UIScrollView *bottomScrollView;
/**
 *  黑色背景view
 */
@property (nonatomic,strong) UIView *bottomBlackView;
/**
 *  原始frame数组
 */
@property (nonatomic,strong) NSMutableArray *originRectsArray;


@end

@implementation JFPhotoBrowser

+ (instancetype)photoBrowser {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createViews];
    }
    return self;
}

- (void)createViews {
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    //底层黑色背景视图
    [self addSubview:self.bottomBlackView];
    self.bottomBlackView.sd_layout.leftEqualToView(self).rightEqualToView(self).widthIs(kScreenWidth).heightIs(kScreenHeight);
    //底部滑动scrollview
    [self addSubview:self.bottomScrollView];
    self.bottomScrollView.sd_layout.leftEqualToView(self).rightEqualToView(self).widthIs(kScreenWidth).heightIs(kScreenHeight);
    
}

- (void)showPhotos {
    //1.添加到window上
    [KKeyWindow addSubview:self];
    //2.获取原始frame
    [self originRectsFrame];
    //设置滚动距离
    [self.bottomScrollView setContentSize:CGSizeMake(kScreenWidth * self.photosArray.count, 0)];
    [self.bottomScrollView setContentOffset:CGPointMake(kScreenWidth * self.currentIndex, 0)];
    //创建子视图
    [self setupChildViews];
}


#pragma mark-获取原始frame
- (void)originRectsFrame {
    for (PhotoImageView *photoImageView in self.photosArray) {
        UIImageView *sourceImageView = photoImageView.sourceImageView;
        CGRect sourceRect = [KKeyWindow convertRect:sourceImageView.frame toView:sourceImageView.superview];
        [self.originRectsArray addObject:[NSValue valueWithCGRect:sourceRect]];
    }
}

#pragma mark-创建子视图

- (void)setupChildViews{
    for (int i=0;i<self.photosArray.count;i++) {
        UIScrollView *smallScrollView = [self createChildScrollviewWithTag:i];
        PhotoImageView *photoImageView = [self addGestureForImageView:i];
        photoImageView.userInteractionEnabled = YES;
        [smallScrollView addSubview:photoImageView];
        [photoImageView jf_setImageWithUrl:photoImageView.imageUrl placeholderImage:[UIImage imageNamed:@"ic_bg_header"]];
    
        photoImageView.frame = [self.originRectsArray[i] CGRectValue];
        [UIView animateWithDuration:0.3 animations:^{
            [self setupPhotoImageViewFrame:photoImageView];
        }];
    }
}

#pragma mark- 给图片添加点击事件

- (PhotoImageView *)addGestureForImageView:(NSInteger)tag {
    PhotoImageView *photoImageView = self.photosArray[tag];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTapClick:)];
    UITapGestureRecognizer *doubleGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoDoubleClick:)];
    doubleGesture.numberOfTapsRequired = 2;
    [photoImageView addGestureRecognizer:tapGesture];
    [photoImageView addGestureRecognizer:doubleGesture];
    return photoImageView;
}

#pragma mark-单击图片

- (void)photoTapClick:(UITapGestureRecognizer *)photoTap {
    PhotoImageView *photoImageView = (PhotoImageView *)photoTap.view;
    UIScrollView *scrollView = (UIScrollView *)photoImageView.superview;
    scrollView.zoomScale = 1.0;
    //如果是长图片先将其移动到CGPointMake(0, 0)在缩放回去
//    if (CGRectGetHeight(photoImageView.frame) > kScreenHeight) {
//        scrollView.contentOffset = CGPointMake(0, 0);
//    }
    //取出原始frame 放回去
    CGRect originFrame = [self.originRectsArray[photoImageView.tag] CGRectValue];
    [UIView animateWithDuration:0.3 animations:^{
        photoImageView.frame = originFrame;
        self.bottomBlackView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

#pragma mark-双击图片

- (void)photoDoubleClick:(UITapGestureRecognizer *)photoDoubleTap {
    [UIView animateWithDuration:0.3 animations:^{
        UIScrollView *scrollView = (UIScrollView *)photoDoubleTap.view.superview;
        scrollView.zoomScale = 3.0;
    }];
    
}

#pragma mark-UIScrollViewDelegate

//要缩放的是哪个子控件
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    if (scrollView.tag == BOTTOMSCROLLVIEWTAG) return nil;
    PhotoImageView *photoImageView = self.photosArray[scrollView.tag];
    return  photoImageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    if (scrollView.tag == BOTTOMSCROLLVIEWTAG) return;
    PhotoImageView *photoImageView = (PhotoImageView *)self.photosArray[scrollView.tag];
    CGFloat photoImageViewY = (kScreenHeight - photoImageView.frame.size.height) / 2;
    CGRect photoImageViewF = photoImageView.frame;
    if (photoImageViewY > 0) {
        photoImageViewF.origin.y = photoImageViewY;
    } else {
        photoImageViewF.origin.y = 0;
    }
    photoImageView.frame = photoImageViewF;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    if (scale == 1.0) {
        CGSize tempSize = scrollView.contentSize;
        tempSize.width = kScreenWidth;
        scrollView.contentSize = tempSize;
        CGRect tempRect = view.frame;
        tempRect.size.width = kScreenWidth;
        view.frame = tempRect;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int currentIndex = scrollView.contentOffset.x/kScreenWidth;
    if (self.currentIndex!= currentIndex && scrollView.tag == BOTTOMSCROLLVIEWTAG) {
        self.currentIndex = currentIndex;
        for (UIView *view in scrollView.subviews) {
            if ([view isKindOfClass:[UIScrollView class]]) {
                UIScrollView *scrollView = (UIScrollView *)view;
                scrollView.zoomScale = 1.0;
            }
        }
    }
}

- (void)setupPhotoImageViewFrame:(PhotoImageView *)photoImageView{
    UIScrollView *smallScrollView = (UIScrollView *)photoImageView.superview;
    self.bottomBlackView.alpha = 1.0;
    CGFloat ratio = (double)photoImageView.image.size.height/(double)photoImageView.image.size.width;
    CGFloat imageWidth = kScreenWidth;
    CGFloat imageHeight = kScreenWidth * ratio;
    if (imageHeight < kScreenHeight) {
        photoImageView.bounds = CGRectMake(0, 0, imageWidth, imageHeight);
        photoImageView.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    } else {//设置长图的frame
        photoImageView.frame = CGRectMake(0, 0, imageWidth, imageHeight);
        smallScrollView.contentSize = CGSizeMake(kScreenWidth, imageHeight);
    }
    
}
#pragma mark-创建小的scrollview
- (UIScrollView *)createChildScrollviewWithTag:(NSInteger)tag {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.delegate = self;
    scrollView.tag = tag;
    scrollView.frame = CGRectMake(kScreenWidth * tag, 0, kScreenWidth, kScreenHeight);
    scrollView.maximumZoomScale = 3.0;
    scrollView.minimumZoomScale = 1.0;
    [self.bottomScrollView addSubview:scrollView];
    return scrollView;
}

#pragma mark-初始化

- (UIScrollView *)bottomScrollView {
    if (!_bottomScrollView) {
        _bottomScrollView = [[UIScrollView alloc] init];
        _bottomScrollView.backgroundColor = [UIColor clearColor];
        _bottomScrollView.delegate = self;
        _bottomScrollView.tag = BOTTOMSCROLLVIEWTAG;
        _bottomScrollView.pagingEnabled = YES;
        _bottomScrollView.bounces = YES;
        _bottomScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _bottomScrollView;
}

-(UIView *)bottomBlackView {
    if (!_bottomBlackView) {
        _bottomBlackView = [[UIView alloc] init];
        _bottomBlackView.backgroundColor = [UIColor blackColor];
    }
    return _bottomBlackView;;
}

- (NSMutableArray *)originRectsArray {
    if (!_originRectsArray) {
        _originRectsArray = [[NSMutableArray alloc] init];
    }
    return _originRectsArray;
}


@end
