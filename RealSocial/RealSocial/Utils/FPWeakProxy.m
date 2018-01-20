//
//  FPWeakProxy.m
//  FortunePlat
//
//  Created by aldwinlv on 16/8/19.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import "FPWeakProxy.h"

@implementation FPWeakProxy

+ (instancetype)weakProxyForObject:(id)targetObject
{
    FPWeakProxy *weakProxy = [FPWeakProxy alloc];
    weakProxy.target = targetObject;
    return weakProxy;
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return _target;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    void *nullPointer = NULL;
    [invocation setReturnValue:&nullPointer];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

@end
