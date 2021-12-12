//
//  PopupView.h
//  LewPopupViewController
//
//  Created by deng on 15/3/5.
//  Copyright (c) 2015年 pljhonglu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZImagePickerController.h"


@protocol HDDMultmediaViewDelegate <NSObject>

@optional

- (void)multmediaViewSelectedCallBack:(NSArray*)selectedMedia;
//选择图片和视频上传的方法
- (void)multmediaView:(NSString *)flag withSelectedCallBack:(NSArray *)selectedMedia;
//点击删除的操作
- (void)multmediaViewDeleteFlag:(NSString *)flag withBtnTag:(NSInteger)tag;
//跳转到游戏的界面
- (void)presentToGameViewString:(NSString *)urlString;
//用户点击的取消操作
- (void)mediaViewCancelOperation;
//点击音频的方法
- (void)didCoursewareMethodWithModel:(id)model withTypeIndex:(NSInteger)index;

@end


@interface HDDMultmediaView : UIView<TZImagePickerControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, assign) BOOL disableEdit;
@property (nonatomic, strong) NSMutableArray * selectedPhoto;
@property (nonatomic, strong) NSMutableArray *resultArr;//结果数据
@property (nonatomic, assign) NSInteger maxCount;//最大数量
@property (nonatomic, assign) NSInteger columnsNum;//列数
@property (nonatomic, strong) NSString *type;//目录进入的

@property (nonatomic, weak)id <HDDMultmediaViewDelegate> delegate;
- (void)refreshViewWithSelectedPhotos:(NSMutableArray*)photos;
@end
