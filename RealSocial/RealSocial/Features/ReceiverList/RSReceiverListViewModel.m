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
#import "RSContactService.h"
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
    NSArray<RSContactModel *> *contactList = [[RSContactService shareInstance] getAllContact];
    [self updateListData:contactList];
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
        [[RSContactService shareInstance] saveAllContactResp:resp];
        NSArray<RSContactModel *> *contactList = [[RSContactService shareInstance] getAllContact];
        [self updateListData:contactList];
    } error:^(NSError * _Nullable error) {
        @RSStrongify(self);
        [self sendErrorSignal:error];
    } completed:^{
        @RSStrongify(self);
        [self sendCompleteSignal];
    }];
}

-(void)updateListData:(NSArray<RSContactModel *> *)contactList {
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    for (RSContactModel *model in contactList) {
        RSReceiverListItemViewModel *item = [RSReceiverListItemViewModel new];
        item.name = model.nickName;
        item.uid = model.uid;
        item.avatarUrl = model.avatarUrl;
        if ([self.selectedData objectForKey:item.uid]) {
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
            [tmp addObject:item.uid];
        }
    }
    return tmp;
}

@end
