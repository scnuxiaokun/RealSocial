//
//  RSError.m
//  RealSocial
//
//  Created by 蒋陈浩 on 2018/3/11.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSError.h"

@implementation RSError
+ (instancetype)sharedError{
    static RSError *error = nil;
    if (error == nil) {
        error = [[RSError alloc] init];
    }
    return error;
}
@end
