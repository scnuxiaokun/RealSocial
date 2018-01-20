//
//  RSNetWorkService.m
//  RealSocial
//
//  Created by kuncai on 2018/1/20.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSNetWorkService.h"
#import <YYDispatchQueuePool/YYDispatchQueuePool.h>

@implementation RSNetWorkService
+(RACSignal *)sendDebugRequest:(RSRequest *)request {
    RACSubject *signal = [RACSubject subject];
    dispatch_async(YYDispatchQueueGetForQOS(NSQualityOfServiceBackground), ^{
        [NSThread sleepForTimeInterval:0.1];
        [signal sendNext:@(YES)];
        [signal sendCompleted];
    });
    return signal;
}
@end
