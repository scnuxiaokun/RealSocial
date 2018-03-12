//
//  RSLoginInfoModel.h
//  RealSocial
//
//  Created by kuncai on 2018/1/17.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSModel.h"
#import "Spbasecgi.pbobjc.h"
#import "Spcgicommdef.pbobjc.h"
@interface RSLoginInfoModel : RSModel
@property (nonatomic, retain) NSString *uid;
//@property (nonatomic, retain) NSString *qquid;
@property (nonatomic, retain) NSString *wxuid;
@property (nonatomic, retain) NSData *sessionKey;
@property (nonatomic, strong) NSString *qiniuToken;
@property (nonatomic, assign) unsigned long long uin;
@property (nonatomic, assign) RSenLoginOpCode opCode;
-(void)updateWithLoginInfo:(RSLoginResp *)loginInfo;
-(void)clear;
@end
