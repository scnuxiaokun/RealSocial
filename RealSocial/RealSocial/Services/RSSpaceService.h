//
//  RSSpaceService.h
//  RealSocial
//
//  Created by kuncai on 2018/2/12.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSpaceService : NSObject
+(RSSpaceService *)shareInstance;

//个人创作
-(void)create:(NSData *)fileData mediaId:(NSString *)mediaId toUsers:(NSArray *)users toSpaces:(NSArray *)spaces;
@end
