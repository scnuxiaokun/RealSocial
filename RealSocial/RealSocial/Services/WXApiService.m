
//
//  WXApiService.m
//  RealSocial
//
//  Created by kuncai on 2018/1/17.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "WXApiService.h"
#import "RSLoginService.h"

#define WEIXIN_GET_ACCESS_TOKEN_API        @"https://api.weixin.qq.com/sns/oauth2/access_token"
#define WEIXIN_GET_USER_INFO_API           @"https://api.weixin.qq.com/sns/userinfo"
#define WEIXIN_REFRESH_ACCESS_TOKEN_API    @"https://api.weixin.qq.com/sns/oauth2/refresh_token"
#define WEIXIN_LOGIN_APP_ID   WXloginScheme

static NSString *kAuthScope = @"snsapi_userinfo";
static NSString *kAuthState = @"xxx";

@implementation WXApiService{
    RACSubject *_loginSignal;
}
+(instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static WXApiService *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WXApiService alloc] init];
    });
    return instance;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        self.signal = [RACSubject subject];
        @weakify(self);
        [self.signal subscribeNext:^(BaseResp *resp) {
            if ([resp isKindOfClass:[SendAuthResp class]]) {
                SendAuthResp *response = (SendAuthResp *)resp;
                if (response.errCode == WXSuccess || YES) {
                    [self->_loginSignal sendNext:@(YES)];
                    [[[RSLoginService shareInstance] WXLoginWithAppid:WEIXIN_LOGIN_APP_ID andCode:response.code] subscribeError:^(NSError *error) {
                        @RSStrongify(self);
                        [self->_loginSignal sendError:error];
                    } completed:^{
                        @RSStrongify(self);
                        [self->_loginSignal sendCompleted];
                    }];
                    return;
                }
                [self reSet];
                [self->_loginSignal sendError:[NSError errorWithString:@"微信登录失败"]];
            }
            
        }];
    }
    return self;
}

/*! @brief 发送一个sendReq后，收到微信的回应
 *
 * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * @param resp具体的回应内容，是自动释放的
 */
-(void) onResp:(BaseResp*)resp {
    [self.signal sendNext:resp];
    //    [[FPWXLoginHelper shareInstance] onResp:resp];
}

-(RACSignal *)login:(UIViewController *)controller {
    @synchronized(self) {
        _loginSignal  = [RACSubject subject];
        if (QLWeiXinLoginServiceStateGetAccessToken == _serviceState ||
            QLWeiXinLoginServiceStateGetUserInfo == _serviceState ||
            QLWeiXinLoginServiceStateRefreshAccessToken == _serviceState) {
            return _loginSignal;
        }
        _serviceState = QLWeiXinLoginServiceStateGetCode;
        SendAuthReq* req = [[SendAuthReq alloc] init];
        req.scope = kAuthScope; // @"post_timeline,sns"
        req.state = kAuthState;
        //    req.openID = kAuthOpenID;
        
        [WXApi sendAuthReq:req
            viewController:controller
                  delegate:[WXApiService shareInstance]];
        return _loginSignal;
    }
}
-(void)reSet {
    self.serviceState = QLWeiXinLoginServiceStateNone;
}
- (void)logOut
{
    @synchronized(self) {
        [self reSet];
    }
}
@end
