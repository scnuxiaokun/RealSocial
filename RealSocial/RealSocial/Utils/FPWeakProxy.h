//
//  FPWeakProxy.h
//  FortunePlat
//
//  Created by aldwinlv on 16/8/19.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FPWeakProxy : NSProxy
+ (instancetype)weakProxyForObject:(id)targetObject;
@property (weak, nonatomic) id target;

@end
