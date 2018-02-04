//
//  RSHandleOpenUrlHelper.m
//  RealSocial
//
//  Created by kuncai on 2018/1/17.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSHandleOpenUrlHelper.h"
#import "WXApiService.h"

@implementation RSHandleOpenUrlHelper
+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
//    if ([[url scheme] isEqualToString:QQloginScheme]) {
//        return [[FPQQLoginHelper shareInstance] handleOpenURL:url];
//    }
    if ([[url scheme] isEqualToString:WEIXIN_LOGIN_APP_ID]) {
        return [WXApi handleOpenURL:url delegate:[WXApiService shareInstance]];
    }
    return NO;
}

@end
