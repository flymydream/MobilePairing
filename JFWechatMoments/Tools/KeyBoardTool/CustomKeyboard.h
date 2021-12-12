//
//  CustomKeybord.h
//  autobole
//
//  Created by wyz on 2017/7/18.
//  Copyright © 2017年 autobole. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomKeyboard;
@protocol CustomKeyboardDelegate <NSObject>

-(void)customKeyboard:(CustomKeyboard*)keyboard didFinished:(NSString*)plateNO;
@end

@interface CustomKeyboard : UIView
@property (nonatomic, copy) NSString *vehicleNo;
@property (nonatomic, weak) id<CustomKeyboardDelegate>delegate;
@property (nonatomic, assign) BOOL showTrailer;//默认不展示

@property (nonatomic, assign) BOOL isChangeTrailer;//修改挂车
+(CustomKeyboard*)initWithDelegate:(id)delegate;
-(void)show;
-(void)hide;



@end
