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
@implementation RSNetWorkService
+(RACSignal *)sendRequest:(RSRequest *)request {
    if (request.mokeResponseData) {
        return [self sendDebugRequest:request];
    }
    return nil;
}
+(RACSignal *)sendDebugRequest:(RSRequest *)request {
    RACSubject *signal = [RACSubject subject];
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
