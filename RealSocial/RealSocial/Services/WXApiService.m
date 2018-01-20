
//
//  WXApiService.m
//  RealSocial
//
//  Created by kuncai on 2018/1/17.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "WXApiService.h"

@implementation WXApiService
+(instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static WXApiService *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WXApiService alloc] init];
        instance.signal = [RACSubject subject];
    });
    return instance;
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
@end
