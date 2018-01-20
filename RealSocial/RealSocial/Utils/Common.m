//
//  Common.m
//  FortunePlat
//
//  Created by aldwinlv on 15/11/18.
//  Copyright © 2015年 Tencent. All rights reserved.
//

#import "Common.h"
#import "sys/sysctl.h"

@implementation Common

+ (NSDictionary *)infoDictionary
{
    static NSDictionary *dictionary;
    if (dictionary == nil) {
        dictionary = [[NSBundle mainBundle] infoDictionary];
    }
    return dictionary;
}

+ (NSString *)getMainVersion
{
    static NSString *mainVersion = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^(void) {
        mainVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        if (mainVersion.length == 0) {
            mainVersion = @"0";
        }
    });
    
    return mainVersion;
}

//+ (NSString *)getBuildVersion
//{
//    static NSString *buildVersion = nil;
//    static dispatch_once_t onceToken;
//
//    dispatch_once(&onceToken, ^(void) {
//        buildVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"Type Version"];
//        if (buildVersion.length == 0) {
//            buildVersion = @"0";
//        }
//    });
//
//    return buildVersion;
//}

+ (NSString *)getFullVersion
{
    static NSString *fullVersion = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^(void) {
        //        NSString *mainVersion = [self getMainVersion];
        //        NSString *buildVersion = [self getBuildVersion];
        //        fullVersion = [NSString stringWithFormat:@"%@.%@", mainVersion, buildVersion];
        fullVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleFullVersionString"];
        if (fullVersion.length == 0) {
            fullVersion = @"0";
        }
    });
    FPLogWarning(@"fullVersion:%@",fullVersion);
    return fullVersion;
}

+ (NSString *)getBuild {
    NSString *fullVersion = [self getFullVersion];
    NSArray *tmp = [fullVersion componentsSeparatedByString:@"."];
    return [tmp lastObject];
}


+ (NSString *)getBundleID
{
    static NSString *bundleID = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^(void) {
        bundleID = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    });
    
    FPLogError(@"bundle id is %@", bundleID);
    return bundleID;
}

+ (NSString *)marketVersion
{
    static NSString* marketVersion;
    if (marketVersion == nil) {
//        marketVersion = [[self infoDictionary] objectForKey:@"Market version"];
      marketVersion = MARKET;
    }
    return marketVersion;
}

+ (NSString *)getDeviceName
{
   	static NSString *platform;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        char *machine = (char*)malloc(size);
        sysctlbyname("hw.machine", machine, &size, NULL, 0);
        if (machine == NULL) {
            platform = @"i386";
        } else {
            platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
        }
        free(machine);
    });
    return platform;
}

+ (BOOL) DeviceSystemIsIOS9
{
    static BOOL __ios9__ = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([[[UIDevice currentDevice] systemVersion] floatValue] > 8.9999 ) {
            __ios9__ = YES;
        }
    });
    return __ios9__;
}


+ (BOOL) DeviceSystemIsIOS8
{
    static BOOL __ios8__ = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([[[UIDevice currentDevice] systemVersion] floatValue] > 7.9999 ) {
            __ios8__ = YES;
        }
    });
    return __ios8__;
}

@end
