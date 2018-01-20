//
//  RSLoginInfoModel.h
//  RealSocial
//
//  Created by kuncai on 2018/1/17.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSModel.h"
@interface RSLoginInfoModel : RSModel
@property (nonatomic, retain) NSString *uid;
//@property (nonatomic, retain) NSString *qquid;
@property (nonatomic, retain) NSString *wxuid;
@property (nonatomic, retain) NSString *sessionKey;
@end
