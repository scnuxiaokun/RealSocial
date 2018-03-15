//
//  RSKeyValueModel.mm
//  RealSocial
//
//  Created by kuncai on 2018/3/13.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSKeyValueModel+WCTTableCoding.h"
#import "RSKeyValueModel.h"
#import <WCDB/WCDB.h>
#import "RSDBService.h"

@implementation RSKeyValueModel

WCDB_IMPLEMENTATION(RSKeyValueModel)
WCDB_SYNTHESIZE(RSKeyValueModel, key)
WCDB_SYNTHESIZE(RSKeyValueModel, data)
WCDB_SYNTHESIZE(RSKeyValueModel, expirDate)

WCDB_UNIQUE(RSKeyValueModel, key)
WCDB_NOT_NULL(RSKeyValueModel, key)

-(instancetype)init {
    self = [super init];
    if (self) {
        static dispatch_once_t token;
        dispatch_once(&token, ^{
            if ([[RSDBService db] createTableAndIndexesOfName:NSStringFromClass([RSKeyValueModel class]) withClass:[RSKeyValueModel class]]) {
                NSLog(@"creat table RSKeyValueModel success");
            } else {
                NSLog(@"creat table RSKeyValueModel fail");
            }
        });
    }
    return self;
}
@end
