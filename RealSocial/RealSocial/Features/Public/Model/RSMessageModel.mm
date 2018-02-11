//
//  RSMessageModel.mm
//  RealSocial
//
//  Created by kuncai on 2018/2/4.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSMessageModel+WCTTableCoding.h"
#import "RSMessageModel.h"
#import <WCDB/WCDB.h>
#import "RSDBService.h"

@implementation RSMessageModel

WCDB_IMPLEMENTATION(RSMessageModel)
WCDB_SYNTHESIZE(RSMessageModel, messageId)
WCDB_SYNTHESIZE(RSMessageModel, type)
WCDB_SYNTHESIZE(RSMessageModel, content)
WCDB_SYNTHESIZE(RSMessageModel, createTime)
WCDB_SYNTHESIZE(RSMessageModel, nextSyncBuff)
WCDB_NOT_NULL(RSMessageModel, messageId)
WCDB_UNIQUE(RSMessageModel, messageId)
///WCDB_MULTI_UNIQUE_DESC(RSMessageModel, createTime, createTime)
-(instancetype)init {
    self = [super init];
    if (self) {
        static dispatch_once_t token;
        dispatch_once(&token, ^{
            if ([[RSDBService db] createTableAndIndexesOfName:NSStringFromClass([RSMessageModel class]) withClass:[RSMessageModel class]]) {
                NSLog(@"creat table RSMessageModel success");
            } else {
                NSLog(@"creat table RSMessageModel fail");
            }
        });
    }
    return self;
}
@end
