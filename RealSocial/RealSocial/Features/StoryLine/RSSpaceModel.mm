//
//  RSSpaceModel.mm
//  RealSocial
//
//  Created by kuncai on 2018/3/10.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSSpaceModel+WCTTableCoding.h"
#import "RSSpaceModel.h"
#import <WCDB/WCDB.h>
#import "RSDBService.h"

@implementation RSSpaceModel

WCDB_IMPLEMENTATION(RSSpaceModel)
WCDB_SYNTHESIZE(RSSpaceModel, spaceId)
//WCDB_SYNTHESIZE(RSSpaceModel, type)
WCDB_SYNTHESIZE(RSSpaceModel, updateTime)
//WCDB_SYNTHESIZE(RSSpaceModel, authorArray)
//WCDB_SYNTHESIZE(RSSpaceModel, creator)
//WCDB_SYNTHESIZE(RSSpaceModel, name)
WCDB_SYNTHESIZE(RSSpaceModel, isReaded)
WCDB_SYNTHESIZE(RSSpaceModel, spaceData)
WCDB_UNIQUE(RSSpaceModel, spaceId)
WCDB_NOT_NULL(RSSpaceModel, spaceId)

-(instancetype)init {
    self = [super init];
    if (self) {
        static dispatch_once_t token;
        dispatch_once(&token, ^{
            if ([[RSDBService db] createTableAndIndexesOfName:NSStringFromClass([RSSpaceModel class]) withClass:[RSSpaceModel class]]) {
                NSLog(@"creat table RSSpaceModel success");
            } else {
                NSLog(@"creat table RSSpaceModel fail");
            }
        });
    }
    return self;
}

-(instancetype)initWithSpace:(RSSpace *)space {
    self = [self init];
    if (self) {
        [self updateWithSpace:space];
    }
    return self;
}

-(void)updateWithSpace:(RSSpace *)space {
    self.spaceId = [NSString stringWithFormat:@"%llu", space.spaceId.svrId];
//    self.type = space.type;
    self.updateTime = space.updateTime;
//    self.authorArray = space.authorArray;
//    self.creator = space.creator;
//    self.name = space.name;
    self.isReaded = NO;
    self.spaceData = [space data];
}

-(RSSpace *)toSpace {
    NSError *error;
    RSSpace *space = [RSSpace parseFromData:self.spaceData error:&error];
    if (error) {
        return [RSSpace new];
    }
    return space;
}
@end
