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
@interface RSRequestFactory : NSObject
+(RSRequest *)requestWithReq:(GPBMessage *)req moke:(GPBMessage *)mokeResponse;
@end
