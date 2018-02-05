//
//  FPLoginService.m
//  FortunePlat
//
//  Created by kuncai on 15/11/25.
//  Copyright © 2015年 Tencent. All rights reserved.
//

#import "RSLoginService.h"
#import "RSNetWorkService.h"
#import "RSKeyChainConstants.h"
#import "FPKeychainUtils.h"
#import "Spcgi.pbobjc.h"

@implementation RSLoginService
+(RSLoginService *)shareInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[RSLoginService alloc] init];
    });
    return sharedInstance;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        _loginSignal = [RACSubject subject];
        _logoutSignal = [RACSubject subject];
        
        _loginStateSignal = [RACSignal merge:@[_loginSignal, _logoutSignal]];
        
        id data = [[NSUserDefaults standardUserDefaults] objectForKey:kFPLoginServiceKeyChainValidKey];
        if (!data) {
            [FPKeychainUtils delete:kFPLoginServiceKeyChainKey];
            [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:kFPLoginServiceKeyChainValidKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
            self.loginInfo = [[RSLoginInfoModel alloc] init];
        } else {
            id tmpData = [FPKeychainUtils load:kFPLoginServiceKeyChainKey];
            if (tmpData) {
                self.loginInfo = (RSLoginInfoModel *)tmpData;
            } else {
                self.loginInfo = [[RSLoginInfoModel alloc] init];
            }
        }
        _logoutUid = @"";
    }
    return self;
}

-(void)saveLoginInfo {
    [FPKeychainUtils save:kFPLoginServiceKeyChainKey data:self.loginInfo];
}

-(BOOL)isLogined {
    if (!self.loginInfo.sessionKey) {
        return NO;
    }
    if ([self.loginInfo.sessionKey length] <= 0) {
        return NO;
    }
    return YES;
}

-(NSData *)mokeResponse {
    return nil;
//    LoginInfo *loginInfo = [LoginInfo new];
//    loginInfo.sessionKey = @"kuncai_test_sessionKey";
//    loginInfo.wxuid = @"kuncai_test_wxuid@wx.tencent.com";
//    return [loginInfo data];
}

-(RACSignal *)WXLoginWithAppid:(NSString *)appid andCode:(NSString *)code {
    RACSubject *signal = [RACSubject subject];
    RSLoginReq *req = [RSLoginReq new];
    req.code = code;
    RSRequest *request = [RSRequest new];
    request.cgiName = @"/skyplan-bin/base/login";
    request.data = [req data];
    request.mokeResponseData = [self mokeResponse];
    [[RSNetWorkService sendRequest:request] subscribeNext:^(RSResponse *response) {
        RSLoginResp *resp = [RSLoginResp parseFromData:response.data error:nil];
        [self.loginInfo updateWithLoginInfo:resp];
        [self saveLoginInfo];
        [self.loginSignal sendNext:@(YES)];
        [signal sendCompleted];
    } error:^(NSError * _Nullable error) {
        [signal sendError:error];
    } completed:^{
        [signal sendCompleted];
    }];
//    FPTWXLoginCmdReq *req = [[FPTWXLoginCmdReq alloc] init];
//    req.jce_isneedinfo = YES;
//    req.jce_code = code;
//    FPRequest *fpRequest = [FPRequestFactory requestWithJce:req cmd:FPELogicSvrCmd_ECmdWXLogin];
//    fpRequest.autoShowErrorTips = NO;
//    @weakify(self);
//    [[FPNetWorkHelper sendRequest:fpRequest] subscribeNext:^(FPResponse *response) {
//        @FPStrongify(self);
//        if ([response jceErrorCode] != 0) {
//            [signal sendError:[response jceError]];
//            return;
//        }
//        FPTWXLoginCmdRes *jceResp = [FPTWXLoginCmdRes fromData:[response jceData]];
//        if (!jceResp) {
//            [signal sendError:nil];
//            return;
//        }
//        if (!jceResp.jce_sessionkey) {
//            [signal sendError:nil];
//            return;
//        }
//        [self.loginInfo updateLoginInfoWithWXLoginInfo:jceResp];
//        [self saveLoginInfo];
//        [signal sendCompleted];
//        [_loginSignal sendNext:self.loginInfo];
//    } error:^(NSError *error) {
    
//        [signal sendError:error];
//    } completed:^{
//
//    }];
    return signal;
}

-(BOOL)logout {
    if([self.loginInfo.uid length] > 0) {
        self.logoutUid = self.loginInfo.uid;
    }
    [self.loginInfo clear];
    [FPKeychainUtils save:kFPLoginServiceKeyChainKey data:self.loginInfo];
    [_logoutSignal sendNext:@(YES)];
    return YES;
}
@end
