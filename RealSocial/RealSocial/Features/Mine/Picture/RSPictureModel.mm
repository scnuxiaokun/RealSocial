//
//  RSPictureListItemViewModel.mm
//  RealSocial
//
//  Created by kuncai on 2018/2/1.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSPictureModel+WCTTableCoding.h"
#import "RSPictureModel.h"
#import <WCDB/WCDB.h>
#import "RSDBService.h"

@implementation RSPictureModel

WCDB_IMPLEMENTATION(RSPictureModel)
WCDB_SYNTHESIZE(RSPictureModel, pictureId)
WCDB_SYNTHESIZE(RSPictureModel, width)
WCDB_SYNTHESIZE(RSPictureModel, height)
WCDB_SYNTHESIZE(RSPictureModel, info)
WCDB_SYNTHESIZE(RSPictureModel, status)
WCDB_SYNTHESIZE(RSPictureModel, createTime)
WCDB_NOT_NULL(RSPictureModel, pictureId)

-(instancetype)init {
    self = [super init];
    if (self) {
        self.status = RSPictureStatusInit;
        static dispatch_once_t token;
        dispatch_once(&token, ^{
            if ([[RSDBService db] createTableAndIndexesOfName:NSStringFromClass([RSPictureModel class]) withClass:[RSPictureModel class]]) {
                NSLog(@"creat table RSPictureModel success");
            } else {
                NSLog(@"creat table RSPictureModel fail");
            }
        });
    }
    return self;
}
@end
