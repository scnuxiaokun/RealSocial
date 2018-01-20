//
//  FPViewModelCacheProxy.m
//  FortunePlat
//
//  Created by kuncai on 15/12/11.
//  Copyright © 2015年 Tencent. All rights reserved.
//

#import "RCViewModelCacheProxy.h"
#import "YYCache.h"
#import <YYDispatchQueuePool/YYDispatchQueuePool.h>

@implementation RCViewModelCacheProxy {
    YYCache *_cacheInstance;
}

+(RCViewModelCacheProxy *)shareInstanceWithName:(NSString *)name withSecretKey:(NSString *)secretKey {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[RCViewModelCacheProxy alloc] initWithName:name withSecretKey:secretKey];
    });
    return sharedInstance;
}

- (instancetype)initWithName:(NSString *)name withSecretKey:(NSString *)secretKey {
    self = [super init];
    if (self) {
//        @weakify(self);
//        dispatch_async(YYDispatchQueueGetForQOS(NSQualityOfServiceUserInitiated), ^{
//            @FPStrongify(self);
            self->_cacheInstance = [[YYCache alloc] initWithName:[NSString stringWithFormat:@"RCViewModelCache_%@",name] withSecretKey:secretKey];
//        });
        
    }
    return self;
}
-(void)cacheData:(id)data withKey:(NSString *)key {
    
    [_cacheInstance.diskCache setObject:data forKey:key];
}
-(id)getCacheDataWithKey:(NSString *)key {
    return [_cacheInstance.diskCache objectForKey:key];
}

-(void)removeCacheData {
    [_cacheInstance.diskCache removeAllObjects];
}
@end
