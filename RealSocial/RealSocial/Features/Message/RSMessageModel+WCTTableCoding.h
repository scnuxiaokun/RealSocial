//
//  RSMessageModel+WCTTableCoding.h
//  RealSocial
//
//  Created by kuncai on 2018/2/4.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSMessageModel.h"
#import <WCDB/WCDB.h>

@interface RSMessageModel (WCTTableCoding) <WCTTableCoding>

WCDB_PROPERTY(messageId)
WCDB_PROPERTY(type)
WCDB_PROPERTY(content)
WCDB_PROPERTY(createTime)
WCDB_PROPERTY(nextSyncBuff)
@end
