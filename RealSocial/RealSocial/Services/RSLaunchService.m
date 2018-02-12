//
//  RSLaunchService.m
//  RealSocial
//
//  Created by kuncai on 2018/1/20.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSLaunchService.h"
#import "RSNetWorkService.h"
#import "RSLoginService.h"
#import <WXApi.h>
#import "WXApiService.h"
#import <AlicloudMobileAnalitics/ALBBMAN.h>

@implementation RSLaunchService
+(RSLaunchService *)shareInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[RSLaunchService alloc] init];
    });
    return sharedInstance;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        [[RSLoginService shareInstance].loginSignal subscribeNext:^(id  _Nullable x) {
            self.loginCompleteBlock();
        }];
        [[RSLoginService shareInstance].logoutSignal subscribeNext:^(id  _Nullable x) {
            self.logoutCompleteBlock();
        }];
    }
    return self;
}
-(void)start {
    self.startBlock();
    [WXApi registerApp:WEIXIN_LOGIN_APP_ID];
    [self initALBBMAN];
    
    RSRequest *request = [RSRequest new];
    request.mokeResponseData = [self mokeResponse];
    [[RSNetWorkService sendRequest:request] subscribeNext:^(id  _Nullable x) {
        
    } error:^(NSError * _Nullable error) {
        self.startErrorBlock();
    } completed:^{
        self.startCompleteBlock();
    }];
}

-(void)initALBBMAN {
    [[ALBBMANAnalytics getInstance] initWithAppKey:@"24797003" secretKey:@"4762b1eb5e601e96b8e838306125f6ab"];
    //    [[ALBBMANAnalytics getInstance] turnOnDebug];
    [[[RSLoginService shareInstance].loginSignal deliverOnMainThread] subscribeNext:^(id  _Nullable x) {
        RSLoginInfoModel *loginInfo = [RSLoginService shareInstance].loginInfo;
        [[ALBBMANAnalytics getInstance] updateUserAccount:loginInfo.uid userid:loginInfo.uid];
    }];
    RSLoginInfoModel *loginInfo = [RSLoginService shareInstance].loginInfo;
    [[ALBBMANAnalytics getInstance] updateUserAccount:loginInfo.uid userid:loginInfo.uid];
}

-(NSData *)mokeResponse {
    return [NSData data];
}
@end
