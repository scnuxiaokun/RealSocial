//
//  RSKeyValueService.m
//  RealSocial
//
//  Created by kuncai on 2018/3/13.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSKeyValueService.h"
#import "RSKeyValueModel.h"
#import "RSKeyValueModel+WCTTableCoding.h"
#import "RSDBService.h"
#import "RSLoginService.h"

@implementation RSKeyValueService
+(BOOL)saveData:(NSData *)data key:(NSString *)key {
    return [self saveData:data realKey:[self realKey:key]];
}
+(BOOL)saveGlobalData:(NSData *)data key:(NSString *)key {
    return [self saveData:data realKey:[self realGlobalKey:key]];
}

+(BOOL)saveData:(NSData *)data realKey:(NSString *)realKey {
    RSKeyValueModel *model = [[RSKeyValueModel alloc] init];
    model.key = realKey;
    model.data = data;
    return [[RSDBService db] insertOrReplaceObject:model into:NSStringFromClass([RSKeyValueModel class])];
}

+(NSString *)realKey:(NSString *)key {
    NSString *uid = [RSLoginService shareInstance].loginInfo.uid;
    NSString *realKey = [NSString stringWithFormat:@"%@_%@", key, uid];
    return realKey;
}

+(NSString *)realGlobalKey:(NSString *)key {
    NSString *realKey = [NSString stringWithFormat:@"%@_global", key];
    return realKey;
}

+(NSData *)dataWithKey:(NSString *)key {
    NSString *realKey = [self realKey:key];
    NSArray *result = [[RSDBService db] getObjectsOfClass:[RSKeyValueModel class] fromTable:NSStringFromClass([RSKeyValueModel class]) where:RSKeyValueModel.key.is(realKey)];
    if ([result count] > 0) {
        RSKeyValueModel *model = [result firstObject];
        return model.data;
    }
    return nil;
}
+(NSData *)globalDataWithKey:(NSString *)key {
    NSString *realKey = [self realGlobalKey:key];
    NSArray *result = [[RSDBService db] getObjectsOfClass:[RSKeyValueModel class] fromTable:NSStringFromClass([RSKeyValueModel class]) where:RSKeyValueModel.key.is(realKey)];
    if ([result count] > 0) {
        RSKeyValueModel *model = [result firstObject];
        return model.data;
    }
    return nil;
}

//+(NSData *)dataWithKey:(NSString *key) {
//    NSString *realKey = [self realKey:key];
//    [[RSDBService db] get]
//    return nil;
//}
//+(NSData *)globalDataWithKey:(NSString *key) {
//    return nil;
//}
@end
