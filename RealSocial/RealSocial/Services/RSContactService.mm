//
//  RSContactService.m
//  RealSocial
//
//  Created by kuncai on 2018/2/11.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSContactService.h"
#import "RSDBService.h"
#import "RSContactModel+WCTTableCoding.h"
#import "Spcgicomm.pbobjc.h"
#import "Spbasecgi.pbobjc.h"
#import "RSRequestFactory.h"
#import "RSLoginService.h"
#import "RSNetWorkService.h"

@implementation RSContactService {
    NSMutableDictionary *_dic;
}

+(RSContactService *)shareInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[RSContactService alloc] init];
    });
    return sharedInstance;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        _dic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(RACSignal *)loadData {
    RSGetAllContactReq *req = [RSGetAllContactReq new];
    RSRequest *request = [RSRequestFactory requestWithReq:req moke:nil];
    RACSignal *signal = [RSNetWorkService sendRequest:request];
    @weakify(self);
    [signal subscribeNext:^(RSResponse *response) {
        @RSStrongify(self);
        RSGetAllContactResp *resp = [RSGetAllContactResp parseFromData:response.data error:nil];
        [self saveAllContactResp:resp];
    } error:^(NSError * _Nullable error) {
        
    } completed:^{
        
        
    }];
    return signal;
}

-(BOOL)saveAllContactResp:(RSGetAllContactResp *)resp {
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    for (RSContact *contact in resp.contactArray) {
        RSContactModel *model = [[RSContactModel alloc] init];
        model.uid = contact.userName;
        model.nickName = contact.nickName;
        model.avatarUrl = contact.headImgURL;
        model.sex = (RSenSex)contact.sex;
        [tmp addObject:model];
    }
   return [[RSDBService db] insertOrReplaceObjects:tmp into:NSStringFromClass([RSContactModel class])];
}

-(NSArray*)getAllContact {
    return [[RSDBService db] getAllObjectsOfClass:[RSContactModel class] fromTable:NSStringFromClass([RSContactModel class])];
}

-(RSContactModel *)getContactByUid:(NSString *)uid {
    RSContactModel *model = [_dic objectForKey:uid];
    if (model) {
        return model;
    }
    NSArray *tmp = [[RSDBService db] getObjectsOfClass:[RSContactModel class] fromTable:NSStringFromClass([RSContactModel class]) where:RSContactModel.uid.is(uid)];
    if ([tmp count] > 0) {
        RSContactModel *model = [tmp firstObject];
        [_dic setObject:model forKey:model.uid];
        return model;
    }
    return nil;
}
-(NSString *)getNickNameByUid:(NSString *)uid {
    RSContactModel *model = [self getContactByUid:uid];
    return model.nickName;
}
-(NSString *)getAvatarUrlByUid:(NSString *)uid {
    RSContactModel *model = [self getContactByUid:uid];
    return model.avatarUrl;
}

-(NSArray<RSContactModel *>*)getContactsByUids:(NSArray *)uids {
    NSArray *tmp = [[RSDBService db] getObjectsOfClass:[RSContactModel class] fromTable:NSStringFromClass([RSContactModel class]) where:RSContactModel.uid.in(uids)];
//    for (RSContactModel *model in tmp) {
//        [_dic setObject:model forKey:model.uid];
//    }
    return tmp;
}
@end
