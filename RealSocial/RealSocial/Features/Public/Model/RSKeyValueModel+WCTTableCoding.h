//
//  RSKeyValueModel+WCTTableCoding.h
//  RealSocial
//
//  Created by kuncai on 2018/3/13.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSKeyValueModel.h"
#import <WCDB/WCDB.h>

@interface RSKeyValueModel (WCTTableCoding) <WCTTableCoding>

WCDB_PROPERTY(key)
WCDB_PROPERTY(data)
WCDB_PROPERTY(expirDate)

@end
