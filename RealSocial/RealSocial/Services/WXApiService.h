//
//  WXApiService.h
//  RealSocial
//
//  Created by kuncai on 2018/1/17.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//
#define WEIXIN_GET_ACCESS_TOKEN_API        @"https://api.weixin.qq.com/sns/oauth2/access_token"
#define WEIXIN_GET_USER_INFO_API           @"https://api.weixin.qq.com/sns/userinfo"
#define WEIXIN_REFRESH_ACCESS_TOKEN_API    @"https://api.weixin.qq.com/sns/oauth2/refresh_token"
#define WEIXIN_LOGIN_APP_ID   @"wxd6cd56916c76e3c8"

#import <Foundation/Foundation.h>
#import "WXApi.h"
/*
 登录流程的状态标记
 */
typedef NS_OPTIONS(NSUInteger, QLWeiXinLoginServiceState) {
    QLWeiXinLoginServiceStateNone = 0,
    QLWeiXinLoginServiceStateGetCode,
    QLWeiXinLoginServiceStateHandleOpenURL,
    QLWeiXinLoginServiceStateGetAccessToken,
    QLWeiXinLoginServiceStateGetUserInfo,
    QLWeiXinLoginServiceStateRefreshAccessToken,
    QLWeiXinLoginServiceStateTokenIsValid
};
@interface WXApiService : NSObject<WXApiDelegate>
@property (nonatomic, assign) QLWeiXinLoginServiceState serviceState;
@property (nonatomic, retain) NSString *openID;
@property (nonatomic, retain) NSString *accessToken;
+ (instancetype)shareInstance;
+(BOOL) handleOpenURL:(NSURL *) url;
-(RACSignal *)login:(UIViewController *)controller;
@property (nonatomic, strong) RACSubject *signal;
@end
