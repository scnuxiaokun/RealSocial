//
//  RSContactModel.mm
//  RealSocial
//
//  Created by kuncai on 2018/2/11.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSContactModel+WCTTableCoding.h"
#import "RSContactModel.h"
#import <WCDB/WCDB.h>
#import "RSDBService.h"

@implementation RSContactModel

WCDB_IMPLEMENTATION(RSContactModel)
WCDB_SYNTHESIZE(RSContactModel, nickName)
WCDB_SYNTHESIZE(RSContactModel, uid)
WCDB_SYNTHESIZE(RSContactModel, avatarUrl)
WCDB_SYNTHESIZE(RSContactModel, sex)
WCDB_SYNTHESIZE_DEFAULT(RSContactModel, delFlag, NO);
WCDB_UNIQUE(RSContactModel, uid)
WCDB_NOT_NULL(RSContactModel, uid)
-(instancetype)init {
    self = [super init];
    if (self) {
        static dispatch_once_t token;
        dispatch_once(&token, ^{
            if ([[RSDBService db] createTableAndIndexesOfName:NSStringFromClass([RSContactModel class]) withClass:[RSContactModel class]]) {
                NSLog(@"creat table RSContactModel success");
            } else {
                NSLog(@"creat table RSContactModel fail");
            }
        });
    }
    return self;
}
@end
