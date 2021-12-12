//
//  PopupView.m
//  LewPopupViewController
//
//  Created by deng on 15/3/5.
//  Copyright (c) 2015年 pljhonglu. All rights reserved.
//

#import "HDDMultmediaView.h"
#import "TZImageManager.h"

@interface HDDMultmediaView()

@property (nonatomic, strong) UIButton *addBtn;//添加按钮
@property (nonatomic, assign) BOOL isDelete;
@property (nonatomic, strong) NSMutableArray * selectedAssets;
@property (nonatomic, strong) NSMutableArray *tempUrlArr;
@property (nonatomic, strong) UIImageView *placeImageView;

@end

@implementation HDDMultmediaView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _selectedPhoto = [NSMutableArray array];
        _resultArr = [NSMutableArray array];
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _addBtn = [[UIButton alloc]init];
    [_addBtn setImage:ImageNamed(@"selected_pic") forState:UIControlStateNormal];
    [_addBtn setImage:ImageNamed(@"selected_pic") forState:UIControlStateHighlighted];
    [_addBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addBtn];
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.centerY.equalTo(self.mas_centerY);
    }];
}
-(void)setDisableEdit:(BOOL)disableEdit {
    _disableEdit = disableEdit;
    if (_disableEdit) {
        _addBtn.hidden = YES;
    }
}
#pragma mark ===========点击添加图片===========
- (void)addAction:(UIButton *)sender {
    self.isDelete = NO;
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    [self pushImagePickerController];
}

#pragma mark ============创建图片或者视频===========
- (void)refreshViewWithSelectedPhotos:(NSMutableArray*)photos{
    for (UIView * deleteView in self.subviews) {
        if (deleteView != _addBtn) {
            [deleteView removeFromSuperview];
        }
    }
    if (photos.count > 0) {
        self.addBtn.hidden = YES;
    }
    
    for (int i = 0; i < photos.count; i++) {
        
        CGFloat btnW = (self.width - 2 * 13) / self.columnsNum;
        CGFloat btnH = 72;
        CGFloat btnX = (i % self.columnsNum) * (btnW + 13);
        CGFloat btnY = (i / self.columnsNum) * (btnH + 10);
        
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
        imageView.tag = i + 1;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        UIImage *selectedImage;
        if ([photos containsObject:ImageNamed(@"selected_pic")]) {
            NSInteger index = [self.selectedPhoto indexOfObject:ImageNamed(@"selected_pic")];
            if (i == index) {
                imageView.image = photos[i];
                selectedImage = photos[i];
            }else{
                NSString *urlStr = photos[i][@"tempUrl"];
                if ([urlStr hasPrefix:@"https"]) {
                    
                    [imageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
                }else{
                    NSString *urlImage  = NSStringFormat(@"%@hdd-file-web%@",[EnvironmentTool sharedInstance].currentAPI,urlStr);
                    [imageView sd_setImageWithURL:[NSURL URLWithString:urlImage]];
                }
            }
        }else{
            NSString *urlStr = photos[i][@"tempUrl"];
            if ([urlStr hasPrefix:@"https"]) {
                
                [imageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
            }else{
                NSString *urlImage  = NSStringFormat(@"%@hdd-file-web%@",[EnvironmentTool sharedInstance].currentAPI,urlStr);
                [imageView sd_setImageWithURL:[NSURL URLWithString:urlImage]];
            }
        }
        [self addSubview:imageView];
        //点击图片查看大图
        [imageView setTapActionWithBlock:^(UIGestureRecognizer * _Nonnull gesture) {
            
            if (selectedImage && [selectedImage isEqual:ImageNamed(@"selected_pic")]) {
                [self pushImagePickerController];
            }else{
                [self seeBigPhoto:gesture];
            }
        }];
        
        //创建删除按钮
        if (!_disableEdit && ![selectedImage isEqual:ImageNamed(@"selected_pic")]) {
            
            UIButton * deleteBtn = [[UIButton alloc]init];
            [deleteBtn setImage:ImageNamed(@"icon_delete") forState:UIControlStateNormal];
            deleteBtn.tag = i + 1;
            [self addSubview:deleteBtn];
            [deleteBtn addTarget:self action:@selector(delectedAction:) forControlEvents:UIControlEventTouchUpInside];
            [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(imageView.mas_top).offset(2);
                make.right.equalTo(imageView.mas_right).offset(-4);
                make.size.mas_equalTo(CGSizeMake(20,20));
            }];
        }
    }
    //少于5张的时候 隐藏添加按钮
    if ([photos count] < 6) {
        UIImageView *lastImageView = [self viewWithTag:photos.count];
        if (_disableEdit && [lastImageView.image isEqual:ImageNamed(@"selected_pic")]) {
            lastImageView.hidden = YES;
        }
    }
    
    UIView * lastView = [self viewWithTag:_selectedPhoto.count];
    CGFloat contentHeight = CGRectGetMinY(lastView.frame) + CGRectGetHeight(lastView.frame);
    self.height = contentHeight;
    [self layoutIfNeeded];
    //刷新完一次就回调给ViewController
    if ([self.delegate respondsToSelector:@selector(multmediaViewSelectedCallBack:)]) {
        [self.delegate multmediaViewSelectedCallBack:_selectedPhoto];
    }
}
#pragma mark -- 删除按钮的回调方法
- (void)delectedAction:(UIButton *)sender{
    if(_selectedPhoto.count){
         [_selectedPhoto removeObjectAtIndex:sender.tag - 1];
         [_resultArr removeObjectAtIndex:sender.tag - 1];
    }
    //不存在上传图片
    if (![self.selectedPhoto containsObject:ImageNamed(@"selected_pic")] && self.selectedPhoto.count  < self.maxCount) {
        [self.selectedPhoto addObject:ImageNamed(@"selected_pic")];
    }
    [self refreshViewWithSelectedPhotos:self.selectedPhoto];
    UIView * lastView = [self viewWithTag:_selectedPhoto.count];
    CGFloat contentHeight = CGRectGetMinY(lastView.frame) + CGRectGetHeight(lastView.frame);
    self.height = contentHeight;
    if (self.delegate && [self.delegate respondsToSelector:@selector(multmediaViewDeleteFlag:withBtnTag:)]) {
        [self.delegate multmediaViewDeleteFlag:@"" withBtnTag:sender.tag - 1];
    }
}
#pragma mark ============图片的点击方法===========
- (void)seeBigPhoto:(UIGestureRecognizer*)recognizer{

    UIImageView *placeImageView = (UIImageView *)recognizer.view;
    NSDictionary *dict = self.selectedPhoto[placeImageView.tag-1];
    NSString *urlImage  = NSStringFormat(@"%@hdd-file-web%@",[EnvironmentTool sharedInstance].currentAPI,dict[@"tempUrl"]);
    [HDDMediaViewer showImage:urlImage withSourceView:placeImageView];
}
#pragma mark ============点击选择图片方法===========
- (void)pushImagePickerController {
    kWeakSelf(self);
    
    NSInteger maxCount =self.selectedPhoto.count == 0 ? self.maxCount : self.maxCount - (self.selectedPhoto.count - 1);
    [HDDCallCameraTool callAlbumAndCameraWithMaxImagesCount:maxCount withAllowCrop:NO success:^(NSArray<UIImage *> * _Nonnull photos, NSArray * _Nonnull assets, BOOL isSelectOriginalPhoto) {
        kStrongSelf(self);
//        //判断图片的大小是否大于3M
//        NSMutableArray *uploadPhotos = [NSMutableArray array];
//        NSInteger index = 1;
//        for (UIImage *image in photos) {
//            NSData *imgData = UIImageJPEGRepresentation(image,1); //1 it represents the quality of the image.
////            NSLog(@"Size of Image(M):%.2f",(unsigned long)[imgData length]/1000.0/1000.0);
//            CGFloat photoLength = [imgData length]/1000.0/1000.0;
//            if (photoLength <= 3.0) {
//                [uploadPhotos addObject:image];
//            }else{
//                [HDDCustomToastView toastMessage:NSStringFormat(@"您选的第%ld张图片过大",(long)index)];
//            }
//            index++;
//        }
        //上传图片
        [self uploadPhotos:photos.mutableCopy];
    }];
}
//上传图片
- (void)uploadPhotos:(NSMutableArray*)photoArray{
    dispatch_group_t group = dispatch_group_create();
    //创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0; i < photoArray.count; i++) {
        dispatch_group_async(group, queue, ^{
            [self uploadPhotoMethod:photoArray[i] withGroup:group];
        });
    }
    //获取到所有上传结果
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if ([self.selectedPhoto containsObject:ImageNamed(@"selected_pic")]) {
            [self.selectedPhoto removeObject:ImageNamed(@"selected_pic")];
        }
        if (self.selectedPhoto.count  < self.maxCount) {
            [self.selectedPhoto addObject:ImageNamed(@"selected_pic")];
        }
        [self refreshViewWithSelectedPhotos:self.selectedPhoto];
    });
}
//上传图片到文件服务
- (void)uploadPhotoMethod:(UIImage *)image withGroup:(dispatch_group_t)group{
    //在开始的时候标记开始
    dispatch_group_enter(group);
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    [[HDDUploadFileClass sharedInstance] uploadGlobalFile:imageData  module:DRIVER_FILE_IOSBASEUPLOAD from:UNLOAD_OTHER_VOUCHERS success:^(NSDictionary * _Nonnull dict) {
        if (dict[@"key"]) {
            [self.selectedPhoto addObject:dict];
            [self.resultArr addObject:dict];
        }
        //结束的时候标记结束
        dispatch_group_leave(group);
    } failure:^(NSError * _Nonnull error) {
        //结束的时候标记结束
        dispatch_group_leave(group);
    }];
}


@end


