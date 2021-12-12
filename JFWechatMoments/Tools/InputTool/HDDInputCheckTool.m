//
//  HDDInputCheckTool.m
//  Shipper
//
//  Created by caesar on 2021/6/8.
//  Copyright © 2021 caesar. All rights reserved.
//

#import "HDDInputCheckTool.h"

@implementation HDDInputCheckTool
//显示输入框小数点和小数点后两位
+ (void)limitTextFieldTextDecimalPointAfterTheTwo:(UITextField *)textField{
    
    NSString *includeStr = @"1234567890";
    NSString *dotString = @".";
    if ([textField.text isEqualToString:dotString]) {
       textField.text = @"0.";
    }
    if (textField.text.length > 0) {
        NSString *lastStr = [textField.text substringFromIndex:textField.text.length-1];
        NSString *fontStr = [textField.text substringToIndex:textField.text.length-1];
        NSString *allowStr = [NSString stringWithFormat:@"%@%@",includeStr,dotString];
        if ([allowStr containsString:lastStr]) {
            
            if ([fontStr rangeOfString:dotString].location != NSNotFound) {
                //前面字符串有.
                //最后一个字符串是不是.
                if ([lastStr isEqualToString:dotString]) {
                    textField.text = fontStr;
                }else{
                    if (![includeStr containsString:lastStr]) {
                        textField.text = fontStr;
                    }
                }
            }else{
                if ([fontStr isEqualToString:lastStr] && [lastStr isEqualToString:@"0"]) {
                    textField.text = fontStr;
                }else{
                    if ([fontStr isEqualToString:@"0"] && ![lastStr isEqualToString:@"."]) {
                        textField.text = lastStr;
                    }
                }
                
            }
            if (textField.text.length > [textField.text rangeOfString:dotString].location + 3) {
                textField.text = [textField.text substringToIndex:[textField.text rangeOfString:dotString].location+3];
            }
        }else{
            textField.text = fontStr;
        }
    }
}
//是否是纯汉字
+ (BOOL)isChinese:(NSString *)content {
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:content];
}




@end
