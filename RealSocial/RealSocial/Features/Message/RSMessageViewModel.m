//
//  RSMessageViewModel.m
//  RealSocial
//
//  Created by kuncai on 2018/1/30.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSMessageViewModel.h"
#import "Spcgi.pbobjc.h"
#import "Spcgicomm.pbobjc.h"

@implementation RSMessageItemViewModel
@end
@implementation RSMessageViewModel
-(void)loadData {
    RSRequest *request = [[RSRequest alloc] init];
    request.mokeResponseData = [self mokeResponse];
    RACSignal *signal = [RSNetWorkService sendRequest:request];
    [signal subscribeNext:^(RSResponse *response) {
        SyncResp *resp = [SyncResp parseFromData:response.data error:nil];
        [self sendUpdateData:resp];
        NSMutableArray *tmp = [[NSMutableArray alloc] init];
        for (Msg *msg in resp.msgArray) {
            RSMessageItemViewModel *item = [RSMessageItemViewModel new];
            item.name = [[NSString alloc] initWithData:msg.content encoding:NSUTF8StringEncoding];
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
    SyncResp *syncResp = [SyncResp new];
    RSBaseResp *baseResp = [RSBaseResp new];
    baseResp.errCode = 0;
    syncResp.nextSyncBuff = [@"sjsjsjs" dataUsingEncoding:NSUTF8StringEncoding];
    syncResp.baseResp = baseResp;
    Msg *msg = [Msg new];
    msg.content = [@"sjsjsjs" dataUsingEncoding:NSUTF8StringEncoding];
    Msg *msg2 = [Msg new];
    msg2.content = [@"sjsjsjs" dataUsingEncoding:NSUTF8StringEncoding];
    Msg *msg3 = [Msg new];
    msg3.content = [@"sjsjsjs" dataUsingEncoding:NSUTF8StringEncoding];
    [syncResp.msgArray addObject:msg];
    [syncResp.msgArray addObject:msg2];
    [syncResp.msgArray addObject:msg3];
    return [syncResp data];
}
@end
