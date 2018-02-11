//
//  RSContactModel+WCTTableCoding.h
//  RealSocial
//
//  Created by kuncai on 2018/2/11.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSContactModel.h"
#import <WCDB/WCDB.h>

@interface RSContactModel (WCTTableCoding) <WCTTableCoding>

WCDB_PROPERTY(uid)
WCDB_PROPERTY(nickName)
WCDB_PROPERTY(avatarUrl)
WCDB_PROPERTY(sex)

@end
