//
//  MomentsPhotoView.m
//  JFWechatMoments
//

#import "MomentsPhotoView.h"
#import "JFPhotoBrowser.h"
#import "PhotoImageView.h"

@interface MomentsPhotoView ()

@property(nonatomic, strong) NSMutableArray *imageViewArray;

@end

@implementation MomentsPhotoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _imageViewArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 9; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor colorWithRed:234 / 255.0 green:234 / 255.0 blue:234 / 255.0 alpha:1.0];
        imageView.tag = i;
        [self addSubview:imageView];
        [_imageViewArray addObject:imageView];
    }
}


- (void)setImageArray:(NSArray *)imageArray {
    _imageArray = imageArray;

    for (NSInteger i = imageArray.count; i < _imageViewArray.count; i++) {
        UIImageView *imageView = _imageViewArray[i];
        imageView.hidden = YES;
    }

    if (_imageArray.count == 0) {
        self.fixedHeight = @(0);
        return;
    }
    CGFloat itemW = [self getItemWidth];
    CGFloat itemH = itemW;
    if (imageArray.count == 1) {
        itemH = 90;
    }
    NSInteger perRowItemCount = [self perRowItemCount];
    for (int i = 0; i < imageArray.count; i++) {
        NSInteger columnIndex = i % perRowItemCount;
        NSInteger rowIndex = i / perRowItemCount;
        UIImageView *imageView = _imageViewArray[i];
        imageView.userInteractionEnabled = YES;
        imageView.hidden = NO;
        imageView.frame = CGRectMake(columnIndex * (itemW + 5), rowIndex * (itemH + 5), itemW, itemH);
        NSDictionary *urlDic = imageArray[i];
//        [imageView jf_setImageWithURL:urlDic[@"url"] placeholderImage:[UIImage imageWithColor:[UIColor colorWithRed:234 / 255.0 green:234 / 255.0 blue:234 / 255.0 alpha:1.0]]];
        [imageView jf_setImageWithUrl:urlDic[@"url"] placeholderImage:[UIImage imageWithColor:[UIColor colorWithRed:234 / 255.0 green:234 / 255.0 blue:234 / 255.0 alpha:1.0]]];
        //添加单击事件
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTapClick:)];
        [imageView addGestureRecognizer:tapGesture];
    }
    CGFloat width = perRowItemCount * itemW + (perRowItemCount - 1) * 5;
    int rowCount = ceilf(imageArray.count * 1.0 / perRowItemCount);
    CGFloat height = rowCount * itemH + (rowCount - 1) * 5;
    self.fixedWidth = @(width);
    self.fixedHeight = @(height);
}

- (CGFloat)getItemWidth {
    if (_imageArray.count == 1) {
        return 120;
    } else {
        CGFloat width = [UIScreen mainScreen].bounds.size.width > 320 ? 80 : 70;
        return width;
    }
}

- (NSInteger)perRowItemCount {
    switch (_imageArray.count) {
        case 1:
            return 1;
        case 2:
            return 2;
        case 4:
            return 2;
        default:
            return 3;
    }
}

#pragma mark-单击图片

- (void)photoTapClick:(UITapGestureRecognizer *)photoTap {
    
    NSMutableArray *photosArray = [NSMutableArray array];
    for (int i=0; i<self.imageArray.count; i++) {
        UIImageView *imageView = self.imageViewArray[i];
        PhotoImageView *photoImageView = [[PhotoImageView alloc] init];
        //1.1设置原始imageView
        photoImageView.sourceImageView = imageView;
        NSDictionary *urlDic = self.imageArray[i];
        photoImageView.imageUrl = urlDic[@"url"];
        photoImageView.tag = i;
        [photosArray addObject:photoImageView];
        
    }
    JFPhotoBrowser *photoBrowser = [JFPhotoBrowser photoBrowser];
    photoBrowser.photosArray = photosArray;
    photoBrowser.currentIndex = (int)photoTap.view.tag;
    [photoBrowser showPhotos];
}

@end
