//
//  RSChatViewModel.m
//  RealSocial
//
//  Created by kuncai on 2018/1/24.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSChatViewModel.h"
#import "LoginInfo.pbobjc.h"
@implementation RSChatItemViewModel

@end
@implementation RSChatViewModel
-(void)loadData {
    RSRequest *request = [[RSRequest alloc] init];
    request.mokeResponseData = [self mokeResponse];
    RACSignal *signal = [RSNetWorkService sendRequest:request];
    [signal subscribeNext:^(RSResponse *response) {
        Chat *list = [Chat parseFromData:response.data error:nil];
        NSMutableArray *tmp = [[NSMutableArray alloc] init];
        for (ChatItem *info in list.listArray) {
            RSChatItemViewModel *item = [RSChatItemViewModel new];
            item.name = info.name;
            item.iconUrl = info.iconURL;
            item.text = info.text;
            [tmp addObject:item];
        }
        @weakify(self);
        dispatch_async_on_main_queue(^{
            @RSStrongify(self);
            self.listData = tmp;
            [self sendUpdateSignal];
        });
    } error:^(NSError * _Nullable error) {
        [self sendErrorSignal:error];
    } completed:^{
        [self sendCompleteSignal];
    }];
}

-(NSData *)mokeResponse {
    Chat *list = [Chat new];
    ChatItem *info = [ChatItem new];
    info.name = @"kuncai test";
    info.iconURL = @"https://gss3.bdstatic.com/7Po3dSag_xI4khGkpoWK1HF6hhy/baike/w%3D268%3Bg%3D0/sign=318b6bf6073387449cc5287a6934bec4/d53f8794a4c27d1e15b40e6210d5ad6edcc43881.jpg";
    info.text = @"say somethine";
    list.listArray = @[info];
    return [list data];
}
@end
