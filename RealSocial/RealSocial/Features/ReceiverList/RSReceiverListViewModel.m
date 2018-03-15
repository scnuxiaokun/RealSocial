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
#import "RSLoginService.h"
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
    NSArray<RSContactModel *> *contactList = [[RSContactService shareInstance] getExistContact];
    [self updateListData:contactList];
    RACSignal *signal = [[RSContactService shareInstance] loadData];
    @weakify(self);
    [signal subscribeNext:^(RSResponse *response) {
    } error:^(NSError * _Nullable error) {
        @RSStrongify(self);
        [self sendErrorSignal:error];
    } completed:^{
        @RSStrongify(self);
        NSArray<RSContactModel *> *contactList = [[RSContactService shareInstance] getExistContact];
        [self updateListData:contactList];
        [self sendCompleteSignal];
    }];
}

-(void)updateListData:(NSArray<RSContactModel *> *)contactList {
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    NSString *myuid = [RSLoginService shareInstance].loginInfo.uid;
    for (RSContactModel *model in contactList) {
        if ([model.uid isEqualToString:myuid]) {
            continue;
        }
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
