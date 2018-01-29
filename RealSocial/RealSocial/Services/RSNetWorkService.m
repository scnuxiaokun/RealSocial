//
//  RSNetWorkService.m
//  RealSocial
//
//  Created by kuncai on 2018/1/20.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSNetWorkService.h"
#import <YYDispatchQueuePool/YYDispatchQueuePool.h>
#import "RSResponse.h"
#import <AFNetworking.h>
//#import "Wxproxy.pbobjc.h"
#import "LoginInfo.pbobjc.h"
@implementation RSNetWorkService
+(RACSignal *)sendRequest:(RSRequest *)request {
//    if (request.mokeResponseData) {
//        return [self sendDebugRequest:request];
//    }
    RACReplaySubject *signal = [RACReplaySubject subject];
    
    NSString *URLString = @"http://120.79.150.34:20000/WxProxy/AccessToken";
    NSDictionary *parameters = @{@"WxAcct": @"WXACCT_BIZ_TEST"};
    
    // 获得请求管理者
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    // 设置请求格式
//    session.requestSerializer = [AFJSONRequestSerializer serializer];
//
////    [session.requestSerializer requestWithMethod:@"POST" URLString:URLString parameters:parameters error:nil];
//    [session POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"YES");
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(error.localizedDescription);
//    }];
    
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:URLString]];
    [urlRequest setHTTPMethod:@"POST"];
    AccessTokenReq *req = [AccessTokenReq new];
    req.wxAcct = enWxAcct_WxacctBizTest;
    [urlRequest setValue:@"application/proto" forHTTPHeaderField:@"Content-Type"];
    NSData *data = [req data];
    [urlRequest setHTTPBody:data];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSURLSessionTask *task = [session dataTaskWithRequest:urlRequest completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
            [signal sendError:error];
        } else {
            NSLog(@"%@", responseObject);
            [signal sendNext:@(YES)];
            [signal sendCompleted];
        }
    }];
    [task resume];
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [signal sendNext:@(YES)];
//        [signal sendCompleted];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [signal sendError:error];
//    }];

    return signal;
}
+(RACSignal *)sendDebugRequest:(RSRequest *)request {
    RACReplaySubject *signal = [RACReplaySubject subject];
    dispatch_async(YYDispatchQueueGetForQOS(NSQualityOfServiceBackground), ^{
        [NSThread sleepForTimeInterval:0.1];
        RSResponse *response = [RSResponse new];
        response.data = request.mokeResponseData;
        [signal sendNext:response];
        [signal sendCompleted];
    });
    return signal;
}
@end
