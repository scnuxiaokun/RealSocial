//
//  Common.h
//  FortunePlat
//
//  Created by aldwinlv on 15/11/18.
//  Copyright © 2015年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Common : NSObject
+ (NSString *)getMainVersion;
+ (NSString *)getBundleID;
+ (NSString *)getBuild;
+ (NSString *)getFullVersion;
+ (NSString *)marketVersion;
+ (NSString *)getDeviceName;
+ (BOOL) DeviceSystemIsIOS9;
+ (BOOL) DeviceSystemIsIOS8;

@end
