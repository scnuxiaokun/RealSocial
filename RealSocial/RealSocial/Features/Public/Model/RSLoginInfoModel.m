//
//  RSLoginInfoModel.m
//  RealSocial
//
//  Created by kuncai on 2018/1/17.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSLoginInfoModel.h"

@implementation RSLoginInfoModel
-(NSString *)uid {
//    if ([self.qquid length] > 0) {
//        return self.qquid;
//    }
    if ([self.wxuid length] > 0) {
        return self.wxuid;
    }
    return @"";
}

-(void)updateWithLoginInfo:(RSLoginResp *)loginInfo {
    self.wxuid = loginInfo.userName;
    self.sessionKey = loginInfo.sessionKey;
    self.qiniuToken = loginInfo.qiniuToken;
}

-(void)clear {
    self.wxuid = @"";
    self.sessionKey = nil;
}
@end
