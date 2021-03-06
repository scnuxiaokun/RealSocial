//
//  FPLoginService.h
//  FortunePlat
//
//  Created by kuncai on 15/11/25.
//  Copyright © 2015年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSLoginInfoModel.h"
@interface RSLoginService : NSObject
@property (nonatomic, strong) RACSubject *loginSignal;
@property (nonatomic, strong) RACSubject *logoutSignal;

@property (nonatomic, strong) RACSignal *loginStateSignal;

@property (nonatomic) RSLoginInfoModel *loginInfo;
@property (nonatomic, strong) NSString *logoutUid;

+(RSLoginService *)shareInstance;
-(void)saveLoginInfo;
-(BOOL)isLogined;
-(BOOL)logout;
-(BOOL)hasRegisterFace;
//-(RACSignal *)FPQQLoginWithUid:(NSString *)uid andA2Key:(NSData *)a2Key andAccount:(NSString *)account;
-(RACSignal *)WXLoginWithAppid:(NSString *)appid andCode:(NSString *)code;
@end
