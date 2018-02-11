//
//  RSSpaceCreateModel.mm
//  RealSocial
//
//  Created by kuncai on 2018/2/11.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSSpaceCreateModel+WCTTableCoding.h"
#import "RSSpaceCreateModel.h"
#import <WCDB/WCDB.h>
#import "RSDBService.h"

@implementation RSSpaceCreateModel

WCDB_IMPLEMENTATION(RSSpaceCreateModel)
WCDB_SYNTHESIZE(RSSpaceCreateModel, mediaId)
WCDB_SYNTHESIZE(RSSpaceCreateModel, type)
WCDB_SYNTHESIZE(RSSpaceCreateModel, status)
WCDB_SYNTHESIZE(RSSpaceCreateModel, users)
WCDB_SYNTHESIZE(RSSpaceCreateModel, spaces)
WCDB_SYNTHESIZE(RSSpaceCreateModel, createTime)
WCDB_SYNTHESIZE(RSSpaceCreateModel, creator)
WCDB_UNIQUE(RSSpaceCreateModel, mediaId)
WCDB_NOT_NULL(RSSpaceCreateModel, mediaId)
-(instancetype)init {
    self = [super init];
    if (self) {
        self.status = RSSpaceCreateModelStatusInit;
        static dispatch_once_t token;
        dispatch_once(&token, ^{
            if ([[RSDBService db] createTableAndIndexesOfName:NSStringFromClass([RSSpaceCreateModel class]) withClass:[RSSpaceCreateModel class]]) {
                NSLog(@"creat table RSSpaceCreateModel success");
            } else {
                NSLog(@"creat table RSSpaceCreateModel fail");
            }
        });
    }
    return self;
}
@end
