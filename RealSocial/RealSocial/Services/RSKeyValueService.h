//
//  RSKeyValueService.h
//  RealSocial
//
//  Created by kuncai on 2018/3/13.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSString *kKeyValueSyncBuff = @"kKeyValueSyncBuff";

@interface RSKeyValueService : NSObject
+(BOOL)saveData:(NSData *)data key:(NSString *)key;
+(BOOL)saveGlobalData:(NSData *)data key:(NSString *)key;
+(NSData *)dataWithKey:(NSString *)key;
+(NSData *)globalDataWithKey:(NSString *)key;
@end
