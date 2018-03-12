//
//  RSStarModel+WCTTableCoding.h
//  RealSocial
//
//  Created by kuncai on 2018/3/10.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSStarModel.h"
#import <WCDB/WCDB.h>

@interface RSStarModel (WCTTableCoding) <WCTTableCoding>

WCDB_PROPERTY(starId)
WCDB_PROPERTY(type)
WCDB_PROPERTY(author)
WCDB_PROPERTY(imgUrl)
WCDB_PROPERTY(videoUrl)
WCDB_PROPERTY(spaceId)

@end
