//
//  WXApiService.h
//  RealSocial
//
//  Created by kuncai on 2018/1/17.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

@interface WXApiService : NSObject<WXApiDelegate>
+ (instancetype)shareInstance;
@property (nonatomic, strong) RACSubject *signal;
@end
