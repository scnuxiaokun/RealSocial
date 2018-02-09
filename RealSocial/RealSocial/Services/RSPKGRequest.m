//
//  RSPKGRequest.m
//  RealSocial
//
//  Created by kuncai on 2018/2/8.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSPKGRequest.h"
#import "Spcgicomm.pbobjc.h"
@implementation RSPKGRequest

-(void)setData:(NSData *)data {
    RSPKG *pkg = [RSPKG new];
    pkg.data_p = data;
    pkg.str = [@"kuncaitest" dataUsingEncoding:NSUTF8StringEncoding];
}
@end
