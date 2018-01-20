//
//  FPSecretKeyUtils.m
//  FortunePlat
//
//  Created by kuncai on 15/12/3.
//  Copyright © 2015年 Tencent. All rights reserved.
//

#import "FPSecretKeyUtils.h"
#import "FPKeychainUtils.h"
#import "CocoaSecurity.h"

static NSString * const FPDBSecretKeyName = @"FPDBSecretKeyName";
//static NSString * const FPDBsecretKeySecretKeyCode = @"FPDBsecretKeySecretKeyCode";

@implementation FPSecretKeyUtils
+(NSString *)secretKeySecretKey {
    NSString *idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    CocoaSecurityResult *md5 = [CocoaSecurity md5:[NSString stringWithFormat:@"%@_%@",idfv,FPDBSecretKeyName]];
    return md5.hex;
}

+(NSString *)secretKey {
    NSString *dbSecretKeyValue = [FPKeychainUtils load:FPDBSecretKeyName];
    if(!dbSecretKeyValue) {
        //重新生成
        NSString *uuid = [[NSUUID UUID] UUIDString];
        CocoaSecurityResult *aes256 = [CocoaSecurity aesEncrypt:uuid key:[self secretKeySecretKey]];
        [FPKeychainUtils save:FPDBSecretKeyName data:aes256.base64];
        return uuid;
    }
    CocoaSecurityResult *aes256 = [CocoaSecurity aesDecryptWithBase64:dbSecretKeyValue key:[FPSecretKeyUtils secretKeySecretKey]];
    return aes256.utf8String;
}
@end
