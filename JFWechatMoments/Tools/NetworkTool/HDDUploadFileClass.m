//
//  HDDUploadFileClass.m
//  Driver
//
//  Created by caesar on 2020/1/20.
//  Copyright © 2020 caesar. All rights reserved.
//

#import "HDDUploadFileClass.h"

#define YYEncode(str) [str dataUsingEncoding:NSUTF8StringEncoding]

@implementation HDDUploadFileClass
SingletonM
- (void)uploadGlobalFile:(NSData*)data module:(NSString*)module from:(NSString *)from  success:(void (^)(NSDictionary *dict))success
               failure:(void (^)(NSError *error))failure{
    if (data && data.length > 0) {
        
        NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        dic[@"from"] = from;
        dic[@"fileBaseStr"] = encodedImageStr;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!self->_hiddenLoadView) {
                [HDDLoadingView loadingWindowView];
            }
        });
        [AFNetworkRequestTool postWithURLString:module parameters:dic success:^(id  _Nonnull responseObject) {
            
            [HDDLoadingView hideLoadingWindowView];
            
            success(responseObject);
            
        } failure:^(NSError * _Nonnull error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [HDDLoadingView hideLoadingWindowView];
                [HDDCustomToastView showError:@"上传失败"];
            });
            failure(error);
        }];
    }
}
- (void)uploadFile:(NSData*)data module:(NSString*)module from:(NSString *)from  success:(void (^)(NSDictionary *dict))success
               failure:(void (^)(NSError *error))failure{
    if (data && data.length > 0) {
        
        NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
        
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        dic[@"from"] = from;
        dic[@"fileBaseStr"] = encodedImageStr;
        if (!_hiddenLoadView) {
            [HDDLoadingView loadingWindowView];
        }
        [AFNetworkRequestTool postWithURLString:module parameters:dic success:^(id  _Nonnull responseObject) {
            
            [HDDLoadingView hideLoadingWindowView];
            success(responseObject);
        } failure:^(NSError * _Nonnull error) {
            [HDDLoadingView hideLoadingWindowView];
            failure(error);
            [HDDCustomToastView showError:@"上传失败"];
        }];
    }
}

#pragma mark ============上传文件的方法===========
- (void)uploadVideoFile:(NSString *)filePath type:(NSInteger)type module:(NSString*)module success:(void (^)(NSString * path))success
               failure:(void (^)(NSError *error))failure{
    if (filePath && filePath.length > 0) {
        
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        dic[@"filepath"] = filePath;
       [AFNetworkRequestTool getWithURLString:module parameters:dic success:^(id  _Nonnull responseObject) {
           
           [HDDLoadingView hideLoadingWindowView];
       } failure:^(NSError * _Nonnull error) {
          
           [HDDCustomToastView showError:@"上传失败"];
       }];
    }
}

- (void)postSessionBodyDataWithUrl:(NSString *)strUrl  httpBobyImage:(id)images onSuccess:(void (^)(NSString * path))success onFailure:(void (^)(NSError *error))failure{
 
   // 文件上传
    NSURL *url = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    // 设置请求体
    NSMutableData *body = [NSMutableData data];
    NSData *imageData = UIImageJPEGRepresentation(images, 0.3);
    if (imageData) {
        [body appendData:YYEncode(@"--YY\r\n")];
        NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", @"img", @"photo.jpg"];
        [body appendData:YYEncode(disposition)];
        NSString *type = [NSString stringWithFormat:@"Content-Type: %@\r\n", @"image/jpg"];
        [body appendData:YYEncode(type)];
        [body appendData:YYEncode(@"\r\n")];
        [body appendData:imageData];
        [body appendData:YYEncode(@"\r\n")];
    }

    /***************参数结束***************/
        // YY--\r\n
        [body appendData:YYEncode(@"--YY--\r\n")];
        request.HTTPBody = body;
//         设置请求头
//         请求体的长度
        [request setValue:[NSString stringWithFormat:@"%zd", body.length] forHTTPHeaderField:@"Content-Length"];
        // 声明这个POST请求是个文件上传
        [request setValue:@"multipart/form-data; boundary=YY" forHTTPHeaderField:@"Content-Type"];
//        NSString * token = [HDDUserModel standardUser].token;
//        if (token) {
//        [request setValue:token forHTTPHeaderField:@"Authorization"];
//        }
        // 发送请求
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

            dispatch_sync(dispatch_get_main_queue(), ^{
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                NSLog(@"ssss===%@",dic);
//                    if ([dic[@"Status"] integerValue] == 10) {
//
//                    }else{
//                        success(@"");
//                    }
                    failure(error);
                });
        }];
        [postDataTask resume];
    
}

@end
