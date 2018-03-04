//
//  RSRequestFactoryService.h
//  RealSocial
//
//  Created by kuncai on 2018/2/9.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSRequest.h"
#import <GPBMessage.h>
#import "Spspacecgi.pbobjc.h"
@interface RSRequestFactory : NSObject
//+(RSRequest *)requestWithReq:(GPBMessage *)req moke:(GPBMessage *)mokeResponse;//弃用
+(RSRequest *)requestWithReq:(GPBMessage *)req resp:(Class)respClass moke:(GPBMessage *)mokeResponse;
+(RSIdPair *)randomPairIdWithKey:(NSString *)key;
@end
