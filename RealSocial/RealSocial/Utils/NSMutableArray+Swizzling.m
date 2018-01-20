//
//  NSMutableArray+Swizzling.m
//  FortunePlat
//
//  Created by aldwinlv on 2017/3/17.
//  Copyright © 2017年 Tencent. All rights reserved.
//

#import "NSMutableArray+Swizzling.h"
#import <objc/runtime.h>
#import "JRSwizzle.h"

@implementation NSMutableArray(Swizzling)

+ (void)load
{
    [self jr_swizzleMethod:@selector(removeObject:) withMethod:@selector(safeRemoveObject:) error:nil];
    [self jr_swizzleMethod:@selector(addObject:) withMethod:@selector(safeAddObject:) error:nil];
    [self jr_swizzleMethod:@selector(removeObjectAtIndex:) withMethod:@selector(safeRemoveObjectAtIndex:) error:nil];
    [self jr_swizzleMethod:@selector(insertObject:atIndex:) withMethod:@selector(safeInsertObject:atIndex:) error:nil];
    [self jr_swizzleMethod:@selector(initWithObjects:count:) withMethod:@selector(safeInitWithObjects:count:) error:nil];
    [self jr_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(safeObjectAtIndex:) error:nil];
}

- (instancetype)safeInitWithObjects:(const id  _Nonnull     __unsafe_unretained *)objects count:(NSUInteger)cnt
{
    BOOL hasNilObject = NO;
    for (NSUInteger i = 0; i < cnt; i++) {
        if ([objects[i] isKindOfClass:[NSArray class]]) {
            FPLogError(@"%@", objects[i]);
        }
        if (objects[i] == nil) {
            hasNilObject = YES;
            FPLogError(@"%s object at index %lu is nil, it will be     filtered", __FUNCTION__, i);
        }
    }
    
    // 因为有值为nil的元素，那么我们可以过滤掉值为nil的元素
    if (hasNilObject) {
        id __unsafe_unretained newObjects[cnt];
        NSUInteger index = 0;
        for (NSUInteger i = 0; i < cnt; ++i) {
            if (objects[i] != nil) {
                newObjects[index++] = objects[i];
            }
        }
        return [self safeInitWithObjects:newObjects count:index];
    }
    return [self safeInitWithObjects:objects count:cnt];
}

- (void)safeAddObject:(id)obj {
    if (obj == nil) {
        FPLogError(@"%s can add nil object into NSMutableArray", __FUNCTION__);
    } else {
        [self safeAddObject:obj];
    }
}
- (void)safeRemoveObject:(id)obj {
    if (obj == nil) {
        FPLogError(@"%s call -removeObject:, but argument obj is nil", __FUNCTION__);
        return;
    }
    [self safeRemoveObject:obj];
}

- (void)safeInsertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject == nil) {
        FPLogError(@"%s can't insert nil into NSMutableArray", __FUNCTION__);
    } else if (index > self.count) {
        FPLogError(@"%s index is invalid", __FUNCTION__);
    } else {
        [self safeInsertObject:anObject atIndex:index];
    }
}

- (id)safeObjectAtIndex:(NSUInteger)index {
    if (self.count == 0) {
        FPLogError(@"%s can't get any object from an empty array", __FUNCTION__);
        return nil;
    }
    if (index > self.count) {
        FPLogError(@"%s index out of bounds in array", __FUNCTION__);
        return nil;
    }
    return [self safeObjectAtIndex:index];
}

- (void)safeRemoveObjectAtIndex:(NSUInteger)index {
    if (self.count <= 0) {
        FPLogError(@"%s can't get any object from an empty array", __FUNCTION__);
        return;
    }
    if (index >= self.count) {
        FPLogError(@"%s index out of bound", __FUNCTION__);
        return;
    }
    [self safeRemoveObjectAtIndex:index];
}

@end
