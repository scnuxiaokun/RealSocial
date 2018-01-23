//
//  RSFriendListViewModel.m
//  RealSocial
//
//  Created by kuncai on 2018/1/23.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSFriendListViewModel.h"
#import "LoginInfo.pbobjc.h"
@implementation RSFriendListViewModelItem
@end
@implementation RSFriendListViewModel

-(RACSignal *)loadDataFromServer {
    RSRequest *request = [[RSRequest alloc] init];
    request.mokeResponseData = [self mokeResponse];
    RACSignal *signal = [RSNetWorkService sendRequest:request];
    [signal subscribeNext:^(RSResponse *response) {
        FriendList *list = [FriendList parseFromData:response.data error:nil];
        NSMutableArray *tmp = [[NSMutableArray alloc] init];
        for (FriendInfo *info in list.listArray) {
            RSFriendListViewModelItem *item = [RSFriendListViewModelItem new];
            item.name = info.name;
            [tmp addObject:item];
        }
        @weakify(self);
        dispatch_async_on_main_queue(^{
            @RSStrongify(self);
            self.listData = tmp;
        });
    }];
    return signal;
}

-(NSData *)mokeResponse {
    FriendList *list = [FriendList new];
    FriendInfo *info = [FriendInfo new];
    info.name = @"kuncai test";
    list.listArray = @[info];
    return [list data];
}
@end
