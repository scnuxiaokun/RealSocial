//
//  FPViewModelCacheProxy.h
//  FortunePlat
//
//  Created by kuncai on 15/12/11.
//  Copyright © 2015年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCViewModel.h"
@interface RCViewModelCacheProxy : NSObject <FPViewModelCacheProtocol>
+(RCViewModelCacheProxy *)shareInstanceWithName:(NSString *)name withSecretKey:(NSString *)secretKey;
- (instancetype)initWithName:(NSString *)name withSecretKey:(NSString *)secretKey;
-(void)cacheData:(id)data withKey:(NSString *)key;
-(id)getCacheDataWithKey:(NSString *)key;
-(void)removeCacheData;
@end
