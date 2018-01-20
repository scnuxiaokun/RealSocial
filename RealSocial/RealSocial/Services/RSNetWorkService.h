//
//  RSNetWorkService.h
//  RealSocial
//
//  Created by kuncai on 2018/1/20.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSRequest.h"
#import "RSResponse.h"
@interface RSNetWorkService : NSObject
+(RACSignal *)sendRequest:(RSRequest *)request;
@end
