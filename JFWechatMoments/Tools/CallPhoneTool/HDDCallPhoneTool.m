//
//  HDDCallPhoneTool.m
//  Driver
//
//  Created by caesar on 2020/1/22.
//  Copyright © 2020 caesar. All rights reserved.
//

#import "HDDCallPhoneTool.h"

@implementation HDDCallPhoneTool

+ (void)openCallPhoneNumber:(NSString *)urlString{
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",urlString]] options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES}completionHandler:^(BOOL success) {
        }];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",urlString]]];
    }
}
//400-993-7878
#pragma mark ============匹配客户电话===========
+ (void)distinguishPhoneNumLabel:(UILabel *)label labelStr:(NSString *)labelStr{

    //获取字符串中的电话号码
    NSString *regulaStr = nil;
    if ([labelStr containsString:@"4009937878"]) {
        regulaStr = @"4009937878";
    }else{
        regulaStr = @"400-993-7878";
    }
    NSRange stringRange = NSMakeRange(0, labelStr.length);
    //正则匹配
    NSError *error;

    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:labelStr];

    NSRegularExpression *regexps = [NSRegularExpression regularExpressionWithPattern:regulaStr options:0 error:&error];
    if (!error && regexps != nil) {
        [regexps enumerateMatchesInString:labelStr options:0 range:stringRange usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            
            NSRange phoneRange = result.range;
            //定义一个NSAttributedstring接受电话号码字符串
    //         NSAttributedString *phoneNumber = [str attributedSubstringFromRange:phoneRange];
            //添加下划线
    //        NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    //        [str addAttributes:attribtDic range:phoneRange];
            //设置文本中的电话号码显示为黄色
            [str addAttribute:NSForegroundColorAttributeName value:APPColor range:phoneRange];
            
            label.attributedText = str;
            label.userInteractionEnabled = YES;
            
            //添加手势，可以点击号码拨打电话
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
            [label addGestureRecognizer:tap];
        }];
     }
}
#pragma mark ============拨打客服电话===========
+ (void)tapGesture:(UITapGestureRecognizer *)sender{
    [self openCallPhoneNumber:kCustomerTelephone];
}

@end
