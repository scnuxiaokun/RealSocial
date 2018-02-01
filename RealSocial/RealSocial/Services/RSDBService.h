//
//  RSDBService.h
//  RealSocial
//
//  Created by kuncai on 2018/2/1.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WCDB/WCDB.h>
@interface RSDBService : NSObject

@property (nonatomic, strong) WCTDatabase* db;
+(RSDBService *)shareInstance;
+(WCTDatabase *)db;
@end
