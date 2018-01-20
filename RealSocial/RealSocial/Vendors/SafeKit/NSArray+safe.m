//
//  NSArray+NoCrash.m
//  SybPlatform
//
//  Created by kuncai on 15-2-6.
//  Copyright (c) 2015年 Tencent. All rights reserved.
//
#import <objc/runtime.h>
#import "NSArray+safe.h"
#import "NSObject+swizzle.h"
#import "SafeKitLog.h"
#import "NSException+SafeKit.h"

@implementation NSArray (safe)

-(id)safeObjectAtIndex:(NSInteger)index {

    if (index >= [self count]) {
       
        [[SafeKitLog shareInstance]logWarning:[NSString stringWithFormat:@"index[%ld] >= count[%ld]",(long)index ,(long)[self count]]];
        return nil;
    }
    return [self safeObjectAtIndex:index];
//    if(index >= 0 && index < self.count)
//    {
//        id ret = nil;
//        @try {
//            ret = [self safeObjectAtIndex:index];
//        }
//        @catch (NSException *exception) {
//            SYB_LOG(@"safeObjectAtIndex exception=%@", exception);
//        }
//        @finally {
//            
//        }
//        return ret;
//    }
//    else{
//        //上报数据
//        assert(0);
//    }
//    return nil;
}

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleMethod:@selector(safeObjectAtIndex:) tarClazz:[[NSArray array] class] tarSel:@selector(objectAtIndex:)];
    });
}
@end
