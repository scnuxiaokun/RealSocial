//
//  RSFriendListViewModel.m
//  RealSocial
//
//  Created by kuncai on 2018/1/23.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSReceiverListViewModel.h"
//#import "LoginInfo.pbobjc.h"
#import "Spbasecgi.pbobjc.h"
#import "Spcgicomm.pbobjc.h"
#import "RSRequestFactory.h"
@implementation RSReceiverListItemViewModel
@end
@implementation RSReceiverListViewModel

-(instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}
-(void)loadData {
    RSGetAllContactReq *req = [RSGetAllContactReq new];
//    RSPKGRequest *request = [[RSPKGRequest alloc] init];
//    request.cgiName = @"contact/getall";
//    request.data = [req data];
//    request.mokeResponseData = [self mokeResponse];
    
    RSRequest *request = [RSRequestFactory requestWithReq:req moke:[self mokeResponse]];
    RACSignal *signal = [RSNetWorkService sendRequest:request];
    @weakify(self);
    [signal subscribeNext:^(RSResponse *response) {
        @RSStrongify(self);
        RSGetAllContactResp *resp = [RSGetAllContactResp parseFromData:response.data error:nil];
//        FriendList *list = [FriendList parseFromData:response.data error:nil];
//        [self.liveData setData:list];
        [self sendUpdateData:resp];
        NSMutableArray *tmp = [[NSMutableArray alloc] init];
        for (RSContact *contact in resp.contactArray) {
            RSReceiverListItemViewModel *item = [RSReceiverListItemViewModel new];
            item.name = contact.nickName;
            item.uid = contact.userName;
            item.avatarUrl = contact.headImgURL;
            if ([self.selectedData objectForKey:contact.userName]) {
                item.isSelected = YES;
            } else {
                item.isSelected = NO;
            }
            [tmp addObject:item];
        }
        @weakify(self);
        dispatch_async_on_main_queue(^{
            @RSStrongify(self);
            self.listData = tmp;
        });
    } error:^(NSError * _Nullable error) {
        @RSStrongify(self);
        [self sendErrorSignal:error];
    } completed:^{
        @RSStrongify(self);
        [self sendCompleteSignal];
    }];
}

-(id)mokeResponse {
    return nil;
    RSGetAllContactResp *resp = [RSGetAllContactResp new];
    RSContact *contact1 = [RSContact new];
    contact1.userName = @"kuncai1";
    RSContact *contact2 = [RSContact new];
    contact2.userName = @"kuncai2";
    [resp.contactArray addObject:contact1];
    [resp.contactArray addObject:contact2];
    return resp;
}

-(void)setDefaultToUsers:(NSArray *)users {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    for (NSString *user in users) {
        [dic setObject:users forKey:user];
    }
    self.selectedData = dic;
}

-(NSArray *)getSelectedUsers {
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    for (RSReceiverListItemViewModel *item in self.listData) {
        if (item.isSelected) {
            [tmp addObject:item.name];
        }
    }
    return tmp;
}

@end
