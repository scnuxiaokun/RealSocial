//
//  RSStarModel.mm
//  RealSocial
//
//  Created by kuncai on 2018/3/10.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSStarModel+WCTTableCoding.h"
#import "RSStarModel.h"
#import <WCDB/WCDB.h>
#import "RSDBService.h"

@implementation RSStarModel

WCDB_IMPLEMENTATION(RSStarModel)
WCDB_SYNTHESIZE(RSStarModel, starId)
WCDB_SYNTHESIZE(RSStarModel, type)
WCDB_SYNTHESIZE(RSStarModel, author)
WCDB_SYNTHESIZE(RSStarModel, imgUrl)
WCDB_SYNTHESIZE(RSStarModel, videoUrl)
WCDB_SYNTHESIZE(RSStarModel, spaceId)

WCDB_UNIQUE(RSStarModel, starId)
WCDB_NOT_NULL(RSStarModel, starId)
-(instancetype)init {
    self = [super init];
    if (self) {
        static dispatch_once_t token;
        dispatch_once(&token, ^{
            if ([[RSDBService db] createTableAndIndexesOfName:NSStringFromClass([RSStarModel class]) withClass:[RSStarModel class]]) {
                NSLog(@"creat table RSStarModel success");
            } else {
                NSLog(@"creat table RSStarModel fail");
            }
        });
    }
    return self;
}

-(instancetype)initWithStar:(RSStar *)star spaceId:(NSString *)spaceId {
    self = [self init];
    if (self) {
        self.spaceId = spaceId;
        self.starId = [NSString stringWithFormat:@"%@_%lld",spaceId,star.starId.svrId];
        self.type = star.type;
        self.author = star.author;
        self.imgUrl = star.img.imgURL;
        self.videoUrl = star.video.videoURL;
    }
    return self;
}
@end
