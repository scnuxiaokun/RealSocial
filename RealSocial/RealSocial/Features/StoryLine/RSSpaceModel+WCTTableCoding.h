//
//  RSSpaceModel+WCTTableCoding.h
//  RealSocial
//
//  Created by kuncai on 2018/3/10.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSSpaceModel.h"
#import <WCDB/WCDB.h>

@interface RSSpaceModel (WCTTableCoding) <WCTTableCoding>
WCDB_PROPERTY(spaceId)
//WCDB_PROPERTY(type)
WCDB_PROPERTY(updateTime)
//WCDB_PROPERTY(authorArray)
//WCDB_PROPERTY(creator)
//WCDB_PROPERTY(name)
WCDB_PROPERTY(isReaded)
WCDB_PROPERTY(spaceData)

@end
