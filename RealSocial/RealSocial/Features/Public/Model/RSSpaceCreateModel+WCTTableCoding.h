//
//  RSSpaceCreateModel+WCTTableCoding.h
//  RealSocial
//
//  Created by kuncai on 2018/2/11.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSSpaceCreateModel.h"
#import <WCDB/WCDB.h>

@interface RSSpaceCreateModel (WCTTableCoding) <WCTTableCoding>

WCDB_PROPERTY(mediaId)
WCDB_PROPERTY(type)
WCDB_PROPERTY(status)
WCDB_PROPERTY(users)
WCDB_PROPERTY(spaces)
WCDB_PROPERTY(createTime)
WCDB_PROPERTY(creator)
@end
