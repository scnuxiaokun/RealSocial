//
//  RSRequest.h
//  RealSocial
//
//  Created by kuncai on 2018/1/20.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "GPBMessage.h"
@interface RSRequest : NSObject
@property (nonatomic, strong) NSData *mokeResponseData;
@property (nonatomic, strong) NSData *data;
//@property (nonatomic, strong) GPBMessage *pbObj;
@property (nonatomic, strong) NSString *cgiName;
@end
