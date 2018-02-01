//
//  RSPictureListItemViewModel+WCTTableCoding.h
//  RealSocial
//
//  Created by kuncai on 2018/2/1.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSPictureListItemViewModel.h"
#import <WCDB/WCDB.h>

@interface RSPictureListItemViewModel (WCTTableCoding) <WCTTableCoding>

WCDB_PROPERTY(filePath)
WCDB_PROPERTY(width)
WCDB_PROPERTY(height)
@end
