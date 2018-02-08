//
//  RSPKGResponse.m
//  RealSocial
//
//  Created by kuncai on 2018/2/8.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSPKGResponse.h"
#import "Spcgicomm.pbobjc.h"
@implementation RSPKGResponse

-(void)setData:(NSData *)data {
    RSPKG *pkg = [RSPKG parseFromData:data error:nil];
    [super setData:[pkg data_p]];
}
@end
