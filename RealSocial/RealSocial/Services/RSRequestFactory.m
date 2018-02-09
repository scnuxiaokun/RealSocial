//
//  RSRequestFactoryService.m
//  RealSocial
//
//  Created by kuncai on 2018/2/9.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSRequestFactory.h"
#import "Spcgicomm.pbobjc.h"
#import "Spbasecgi.pbobjc.h"
#import "Spstorycgi.pbobjc.h"
#import "RSPKGRequest.h"

@implementation RSRequestFactory
+(RSRequest *)requestWithReq:(GPBMessage *)req moke:(GPBMessage *)mokeResponse {
    RSRequest *request;
    if ([req isKindOfClass:[RSLoginReq class]]) {
        request = [[RSRequest alloc] init];
    } else {
        request = [[RSPKGRequest alloc] init];
    }
    request.cgiName = [self cgiNameWithReq:req];
    request.data = [req data];
    request.mokeResponseData = [mokeResponse data];
    return request;
}

+(NSString *)cgiNameWithReq:(GPBMessage *)req {
    NSString *classString = NSStringFromClass([req class]);
    NSDictionary *dic = @{
                          @"GetAllContactReq" : @"contact/getall",
                          @"LoginReq" : @"base/login",
                          @"CreateStoryReq" : @"story/create",
                          @"GetAllStoryReq" : @"story/getall",
                          };
    NSString *key = [classString substringWithRange:NSMakeRange(2, [classString length] - 2)];
    return [dic objectForKey:key];
}
@end
