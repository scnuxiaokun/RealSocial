//
//  RSSyncService.h
//  RealSocial
//
//  Created by kuncai on 2018/3/13.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSyncService : NSObject
+(RSSyncService *)shareInstance;
-(void)loadData;
@end
