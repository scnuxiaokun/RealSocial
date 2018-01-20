//
//  WXApiService.h
//  RealSocial
//
//  Created by kuncai on 2018/1/17.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

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
