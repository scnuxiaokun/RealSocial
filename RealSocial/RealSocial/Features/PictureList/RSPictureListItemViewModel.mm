//
//  RSPictureListItemViewModel.mm
//  RealSocial
//
//  Created by kuncai on 2018/2/1.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSPictureListItemViewModel+WCTTableCoding.h"
#import "RSPictureListItemViewModel.h"
#import <WCDB/WCDB.h>
#import "RSDBService.h"

@implementation RSPictureListItemViewModel

WCDB_IMPLEMENTATION(RSPictureListItemViewModel)
WCDB_SYNTHESIZE(RSPictureListItemViewModel, filePath)
WCDB_SYNTHESIZE(RSPictureListItemViewModel, width)
WCDB_SYNTHESIZE(RSPictureListItemViewModel, height)
WCDB_NOT_NULL(RSPictureListItemViewModel, filePath)

-(instancetype)init {
    self = [super init];
    if (self) {
        static dispatch_once_t token;
        dispatch_once(&token, ^{
            [[RSDBService db] createTableAndIndexesOfName:@"RSPictureListItemViewModel" withClass:[RSPictureListItemViewModel class]];
        });
    }
    return self;
}
@end
