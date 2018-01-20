//
//  FPKeychainUtils.h
//  FortunePlat
//
//  Created by kuncai on 15/12/3.
//  Copyright © 2015年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>
@interface FPKeychainUtils : NSObject
+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)delete:(NSString *)service;


//跟账号有关的
+ (void)save:(NSString *)service uid:(NSString *)uid data:(id)data;
+ (id)load:(NSString *)service uid:(NSString *)uid;
+ (void)delete:(NSString *)service uid:(NSString *)uid;

@end
