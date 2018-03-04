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
#import "RSPKGResponse.h"
#import <AFNetworking.h>
#import "Spcgicomm.pbobjc.h"

@implementation RSNetWorkService
+(RACSignal *)sendRequest:(RSRequest *)request {
    if (request.mokeResponseData) {
        return [self sendDebugRequest:request];
    }
    RACReplaySubject *signal = [RACReplaySubject subject];
//    NSString *URLString = [@"http://www.skyplan.online" stringByAppendingPathComponent:request.cgiName
//                           ];
    NSString *URLString = [@"http://120.79.150.34/skyplan-bin" stringByAppendingPathComponent:request.cgiName
                           ];
//    NSString *URLString = @"http://120.79.150.34:20000/skyplan-bin/base/login";
//    NSDictionary *parameters = @{@"WxAcct": @"WXACCT_BIZ_TEST"};
    
    // 获得请求管理者
//    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
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
    [urlRequest setValue:@"application/proto" forHTTPHeaderField:@"Content-Type"];
    
//    application/proto
//    AccessTokenReq *req = [AccessTokenReq new];
//    req.wxAcct = enWxAcct_WxacctBizTest;
//    NSData *data = [req data];
//    [urlRequest setHTTPBody:[req data]];
    [urlRequest setHTTPBody:request.data];
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/proto",@"text/html", nil];

    NSURLSessionTask *task = [session dataTaskWithRequest:urlRequest completionHandler:^(NSURLResponse * _Nonnull urlResponse, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"###########[%@][begin errorlog]#############",request.cgiName);
            NSLog(@"%@", error);
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"%@", responseString);
            NSLog(@"###########[%@][end errorlog]#############",request.cgiName);
            [signal sendError:error];
            return;
        }
//            NSLog(@"%@", responseObject);
        RSResponse *response;
        if ([request isKindOfClass:[RSPKGRequest class]]) {
            response = [[RSPKGResponse alloc] init];
        } else {
            response = [[RSResponse alloc] init];
        }
        response.data = responseObject;
//        RSResponseResp *resp = [RSResponseResp parseFromData:response.data error:nil];
        if (request.respClass) {
            NSError *error;
           NSObject *resp = [request.respClass parseFromData:response.data error:&error];
            if (error) {
                [signal sendError:error];
                return;
            }
            RSBaseResp *baseResp = [resp valueForKey:@"baseResp"];
            if (baseResp) {
                if (baseResp.errCode != 0) {
                    [signal sendError:[NSError errorWithString:baseResp.errMsg code:baseResp.errCode]];
                    return;
                }
            }
            NSLog(@"%@:%@", request.respClass, resp);
            [signal sendNext:resp];
            return;
        }
        [signal sendNext:response];
        [signal sendCompleted];
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
