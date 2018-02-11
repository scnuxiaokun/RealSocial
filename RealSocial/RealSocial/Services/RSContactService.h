//
//  RSContactService.h
//  RealSocial
//
//  Created by kuncai on 2018/2/11.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Spbasecgi.pbobjc.h"
#import "RSContactModel.h"
@interface RSContactService : NSObject
+(RSContactService *)shareInstance;
-(BOOL)saveAllContactResp:(RSGetAllContactResp *)resp;
-(NSArray<RSContactModel *>*)getAllContact;
-(RSContactModel *)getContactByUid:(NSString *)uid;
-(NSArray<RSContactModel *>*)getContactsByUids:(NSArray *)uids;
-(NSString *)getNickNameByUid:(NSString *)uid;
-(NSString *)getAvatarUrlByUid:(NSString *)uid;
@end
