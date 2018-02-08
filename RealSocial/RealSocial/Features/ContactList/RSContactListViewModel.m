//
//  RSFriendListViewModel.m
//  RealSocial
//
//  Created by kuncai on 2018/1/23.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSContactListViewModel.h"
//#import "LoginInfo.pbobjc.h"
#import "Spbasecgi.pbobjc.h"
@implementation RSContactListItemViewModel
@end
@implementation RSContactListViewModel

-(instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}
-(void)loadData {
    RSGetAllContactReq *req = [RSGetAllContactReq new];
    RSRequest *request = [[RSRequest alloc] init];
    request.cgiName = @"contact/getall";
    request.data = [req data];
    request.mokeResponseData = [self mokeResponse];
    RACSignal *signal = [RSNetWorkService sendRequest:request];
    [signal subscribeNext:^(RSResponse *response) {
        RSGetAllContactResp *resp = [RSGetAllContactResp parseFromData:response.data error:nil];
//        FriendList *list = [FriendList parseFromData:response.data error:nil];
//        [self.liveData setData:list];
        [self sendUpdateData:resp];
        NSMutableArray *tmp = [[NSMutableArray alloc] init];
        for (NSString *userName in resp.userNameArray) {
            RSContactListItemViewModel *item = [RSContactListItemViewModel new];
            item.name = userName;
            if ([self.selectedData objectForKey:userName]) {
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
        [self sendErrorSignal:error];
    } completed:^{
        [self sendCompleteSignal];
    }];
}

-(NSData *)mokeResponse {
    RSGetAllContactResp *resp = [RSGetAllContactResp new];
    [resp.userNameArray addObject:@"kuncai1"];
    [resp.userNameArray addObject:@"kuncai2"];
    [resp.userNameArray addObject:@"kuncai3"];
    [resp.userNameArray addObject:@"kuncai4"];
    [resp.userNameArray addObject:@"kuncai5"];
    return [resp data];
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
    for (RSContactListItemViewModel *item in self.listData) {
        if (item.isSelected) {
            [tmp addObject:item.name];
        }
    }
    return tmp;
}
@end
