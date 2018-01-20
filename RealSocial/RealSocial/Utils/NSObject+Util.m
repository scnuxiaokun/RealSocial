//
//  NSObject+Util.m
//  FortunePlat
//
//  Created by kuncai on 16/4/12.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import "NSObject+Util.h"
#import <objc/runtime.h>

@implementation NSObject (Util)
-(NSDictionary *)getPropertyList {
    Class clazz = [self class];
    u_int count;
    objc_property_t * propertyArray = class_copyPropertyList(clazz, &count);
    NSMutableArray *tmpName = [[NSMutableArray alloc] initWithCapacity:count];
    NSMutableArray *tmpAttr = [[NSMutableArray alloc] initWithCapacity:count];
    for (int i = 0; i < count; i++) {
        const char* cPropertyName = property_getName(propertyArray[i]);
        NSString *propertyName = [NSString stringWithCString:cPropertyName encoding:NSUTF8StringEncoding];
        [tmpName addObject:propertyName];
        const char* attribute = property_getAttributes(propertyArray[i]);
        NSString *attributeString = [NSString stringWithCString:attribute encoding:NSUTF8StringEncoding];
        [tmpAttr addObject:attributeString];
    }
    free(propertyArray);
    return @{@"names":tmpName, @"attrs":tmpAttr};
}
@end
