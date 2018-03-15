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
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSString *URLString = [@"http://120.79.150.34/skyplan-bin" stringByAppendingPathComponent:request.cgiName];
        NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:URLString]];
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setValue:@"application/proto" forHTTPHeaderField:@"Content-Type"];
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
                [subscriber sendError:error];
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
                if ([response.data length] <= 0) {
                    [subscriber sendError:[NSError errorWithString:@"reponse data is empty"]];
                    return;
                }
                NSError *error;
                NSObject *resp = [request.respClass parseFromData:response.data error:&error];
                if (error) {
                    [subscriber sendError:error];
                    return;
                }
                RSBaseResp *baseResp = [resp valueForKey:@"baseResp"];
                if (baseResp) {
                    if (baseResp.errCode != 0) {
                        [subscriber sendError:[NSError errorWithString:baseResp.errMsg code:baseResp.errCode]];
                        return;
                    }
                }
                //            NSLog(@"%@:%@", request.respClass, resp);
                [subscriber sendNext:resp];
                [subscriber sendCompleted];
                return;
            }
            [subscriber sendNext:response];
            [subscriber sendCompleted];
        }];
        [task resume];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}
+(RACSignal *)sendDebugRequest:(RSRequest *)request {
    RACReplaySubject *signal = [RACReplaySubject subject];
    dispatch_async(YYDispatchQueueGetForQOS(NSQualityOfServiceBackground), ^{
        [NSThread sleepForTimeInterval:0.5];
        RSResponse *response = [RSResponse new];
        response.data = request.mokeResponseData;
        [signal sendNext:response];
        [signal sendCompleted];
    });
    return signal;
}
@end
