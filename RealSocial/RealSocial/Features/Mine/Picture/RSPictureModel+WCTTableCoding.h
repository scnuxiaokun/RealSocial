//
//  RSPictureListItemViewModel+WCTTableCoding.h
//  RealSocial
//
//  Created by kuncai on 2018/2/1.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSPictureModel.h"
#import <WCDB/WCDB.h>

@interface RSPictureModel (WCTTableCoding) <WCTTableCoding>

WCDB_PROPERTY(pictureId)
WCDB_PROPERTY(width)
WCDB_PROPERTY(height)
WCDB_PROPERTY(info)
WCDB_PROPERTY(status)
WCDB_PROPERTY(createTime)
@end
