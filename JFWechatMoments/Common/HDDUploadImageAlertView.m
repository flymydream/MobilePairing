//
//  HDDUploadImageAlertView.m
//  Shipper
//
//  Created by caesar on 2021/3/31.
//  Copyright © 2021 caesar. All rights reserved.
//

#import "HDDUploadImageAlertView.h"
@interface HDDUploadImageAlertView ()
@property (nonatomic, strong) UIView *backView ;//背景图
@property (nonatomic, strong) UILabel *middleTitleLabel;//展示问题
@property (nonatomic, strong) UIImageView *showImg;
@end
@implementation HDDUploadImageAlertView

+(instancetype)defaultUploadAlertView{
    return [[HDDUploadImageAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
}
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [kKeyWindow addSubview:self];
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.backView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
    self.backView.hidden = NO;
    [self addSubview:self.backView];
    
    // 弹窗view
    UIView *alertView = [[UIView alloc]init];
    alertView.layer.cornerRadius = 11;
    alertView.layer.masksToBounds = YES;
    alertView.backgroundColor = UnitBGColor;
    [self.backView addSubview:alertView];
    [alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.centerY.mas_equalTo(self.backView).offset(0);
        make.height.mas_equalTo(400);
    }];
    // 提示项
    _middleTitleLabel = [[UILabel alloc]init];
    _middleTitleLabel.textColor = KCustomAdjustColor(HexRGB(0x333333), HexRGB(0xD1D1D1));
    _middleTitleLabel.font = [UIFont systemFontOfSize:20 weight:0.2];
    [alertView addSubview:_middleTitleLabel];
    [_middleTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(alertView);
        make.top.mas_equalTo(30);
    }];
    
    UIImageView *showImg = [[UIImageView alloc]init];
    [alertView addSubview:showImg];
    [showImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_middleTitleLabel.mas_bottom).offset(25);
        make.height.mas_equalTo(210);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    }];
    _showImg = showImg;
    UIView *lineOne = [[UIView alloc]init];
    lineOne.backgroundColor = KCustomAdjustColor(HexRGB(0xE0E0E0), HexRGB(0x3E3E3E));
    [alertView addSubview:lineOne];
    [lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(alertView);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(showImg.mas_bottom).offset(20);
    }];
    
    UIButton *takePhoto = [[UIButton alloc]init];
    takePhoto.tag = 0;
    [takePhoto setTitle:@"拍照" forState:UIControlStateNormal];
    [takePhoto setTitleColor:KCustomAdjustColor(HexRGB(0x333333), HexRGB(0xD1D1D1)) forState:UIControlStateNormal];
    [takePhoto setBackgroundColor:UnitBGColor];
    [takePhoto addTarget:self action:@selector(clickShowAlertBtn:) forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:takePhoto];
    [takePhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(alertView);
        make.top.mas_equalTo(lineOne.mas_bottom);
        make.height.mas_equalTo(45);
    }];
    
    UIView *lineTwo = [[UIView alloc]init];
    lineTwo.backgroundColor = KCustomAdjustColor(HexRGB(0xE0E0E0), HexRGB(0x3E3E3E));
    [alertView addSubview:lineTwo];
    [lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(alertView);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(takePhoto.mas_bottom);
    }];
    
    UIButton *album = [[UIButton alloc]init];
    album.tag = 1;
    [album setTitle:@"从相册选择" forState:UIControlStateNormal];
    [album setTitleColor:KCustomAdjustColor(HexRGB(0x333333), HexRGB(0xD1D1D1)) forState:UIControlStateNormal];
    [album setBackgroundColor:UnitBGColor];
    [album addTarget:self action:@selector(clickShowAlertBtn:) forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:album];
    [album mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(alertView);
        make.top.mas_equalTo(lineTwo.mas_bottom);
        make.height.mas_equalTo(45);
    }];
    
    UIButton *cancel = [[UIButton alloc]init];
    cancel.tag = 2;
    cancel.layer.cornerRadius = 11;
    cancel.layer.masksToBounds = YES;
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:KCustomAdjustColor(HexRGB(0x333333), HexRGB(0xD1D1D1)) forState:UIControlStateNormal];
    [cancel setBackgroundColor:UnitBGColor];
    [cancel addTarget:self action:@selector(clickShowAlertBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:cancel];
    [cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(alertView);
        make.top.mas_equalTo(alertView.mas_bottom).offset(10);
        make.height.mas_equalTo(45);
    }];
}
#pragma mark ============弹出拍照和相册选择的方法===========
- (void)clickShowAlertBtn:(UIButton *)sender {
    
    if (sender.tag == 0) {// 拍照
        [self.parentVc callCamareImageWithCompletionHandler:^(NSData * _Nonnull imageData, UIImage * _Nonnull image) {
            [HDDUploadFileClass sharedInstance].hiddenLoadView = YES;
            [[HDDUploadFileClass sharedInstance] uploadFile:imageData module:DRIVER_FILE_IOSBASEUPLOAD from:self.imageType success:^(NSDictionary * _Nonnull dict) {
                [HDDUploadFileClass sharedInstance].hiddenLoadView = YES;
                // 识别
                if (self.selectedImageBlock) {
                    self.selectedImageBlock(YES, dict);
                }
            } failure:^(NSError * _Nonnull error) {
                [HDDUploadFileClass sharedInstance].hiddenLoadView = NO;
                if (self.selectedImageBlock) {
                    self.selectedImageBlock(NO, @{});
                }
            }];
        } withFromType:self.imageType];
        [self removeFromSuperview];
    } else if (sender.tag == 1) {// 相册
        [HDDCallCameraTool callAlbumAndCameraWithMaxImagesCount:1 withAllowCrop:NO success:^(NSArray<UIImage *> * _Nonnull photos, NSArray * _Nonnull assets, BOOL isSelectOriginalPhoto) {
            [HDDUploadFileClass sharedInstance].hiddenLoadView = YES;
            NSData *imageData = UIImageJPEGRepresentation(photos.firstObject, 0.5);
            [[HDDUploadFileClass sharedInstance] uploadFile:imageData  module:DRIVER_FILE_IOSBASEUPLOAD from:self.imageType success:^(NSDictionary * _Nonnull dict) {
                [HDDUploadFileClass sharedInstance].hiddenLoadView = NO;
                // 识别后赋值
                if (self.selectedImageBlock) {
                    self.selectedImageBlock(YES, dict);
                }
            } failure:^(NSError * _Nonnull error) {
                [HDDUploadFileClass sharedInstance].hiddenLoadView = NO;
                if (self.selectedImageBlock) {
                    self.selectedImageBlock(NO, @{});
                }
            }];
        }];
        [self removeFromSuperview];
    } else {
        NOTIFY_POST(@"isHiddenLoadView");
        [self removeFromSuperview];
    }
}
- (void)setImageType:(NSString *)imageType{
    if (imageType.length == 0) {
        [HDDCustomToastView toastMessage:@"请选择上传类型"];
        return;
    }
    _imageType = imageType;
    if ([imageType isEqualToString:DRIVER_IDCARD_FRONT]) {
        //司机身份证人像面
        self.middleTitleLabel.text = @"身份证人像面上传示例";
        self.showImg.image = ImageNamed(@"icon_eg_idFront");
    }else if ([imageType isEqualToString:DRIVER_IDCARD_BACK]){
        //身份证国徽面
        self.middleTitleLabel.text = @"身份证国徽面上传示例";
        self.showImg.image = ImageNamed(@"icon_eg_idBack");
    }else if ([imageType isEqualToString:DRIVER_LICENSE_FRONT]){
        //驾驶证正本
        self.middleTitleLabel.text = @"驾驶证正本上传示例";
        self.showImg.image = ImageNamed(@"icon_eg_driverLicenseFront");
    }else if ([imageType isEqualToString:DRIVER_LICENSE_BACK]){
        //驾驶证副页
        self.middleTitleLabel.text = @"驾驶证副页上传示例";
        self.showImg.image = ImageNamed(@"icon_eg_driverLicenseBack");
    }else if ([imageType isEqualToString:VEHICLE_LICENSE_FRONT]){
        //行驶证正本
        self.middleTitleLabel.text = @"行驶证正本上传示例";
        self.showImg.image = ImageNamed(@"icon_eg_vehicleLicenseFront");
    }else if ([imageType isEqualToString:VEHICLE_LICENSE_BACK]){
        //行驶证副本
        self.middleTitleLabel.text = @"行驶证副页上传示例";
        self.showImg.image = ImageNamed(@"icon_eg_vehicleLicenseBack");
    }else if ([imageType isEqualToString:VEHICLE_TRANSPORTCERTIFICATE]){
        //道路运输证
        self.middleTitleLabel.text = @"道路运输证上传示例";
        self.showImg.image = ImageNamed(@"icon_eg_transportCer");
    }else if ([imageType isEqualToString:DRIVER_QUALIFICATION_CER]){
        //司机从业资格证
        self.middleTitleLabel.text = @"从业资格证上传示例";
        self.showImg.image = ImageNamed(@"icon_eg_qualificationCer");
    }else if ([imageType isEqualToString:VEHICLE_BUSINESS_LICENSE]){
        //营业执照
        self.middleTitleLabel.text = @"营业执照上传示例";
        self.showImg.image = ImageNamed(@"icon_eg_businessLicense");
    }else if([imageType isEqualToString:VEHICLE_TRANSPORT_BUSINESS_CER]){
        //道路运输经营许可证
        self.middleTitleLabel.text = @"道路运输经营许可证上传示例";
        self.showImg.image = ImageNamed(@"icon_eg_transpotBusinessLicense");
    } else if([imageType isEqualToString:VEHICLETRAILER_LICENSE_FRONT_IMAGE]){
        //挂车行驶证
        self.middleTitleLabel.text = @"挂车行驶证上传示例";
        self.showImg.image = ImageNamed(@"icon_eg_vehicleLicenseFront");
    }
}


@end
