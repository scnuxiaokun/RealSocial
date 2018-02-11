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
@interface RSLoginInfoModel : RSModel
@property (nonatomic, retain) NSString *uid;
//@property (nonatomic, retain) NSString *qquid;
@property (nonatomic, retain) NSString *wxuid;
@property (nonatomic, retain) NSData *sessionKey;
@property (nonatomic, strong) NSString *qiniuToken;
-(void)updateWithLoginInfo:(RSLoginResp *)loginInfo;
-(void)clear;
@end
