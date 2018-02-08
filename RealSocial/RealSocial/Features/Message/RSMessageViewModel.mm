//
//  RSMessageViewModel.m
//  RealSocial
//
//  Created by kuncai on 2018/1/30.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSMessageViewModel.h"
#import "Spbasecgi.pbobjc.h"
#import "Spcgicomm.pbobjc.h"
#import "RSMessageModel+WCTTableCoding.h"
#import "RSDBService.h"

@implementation RSMessageItemViewModel
@end
@implementation RSMessageViewModel

-(void)loadData {
    [self loadDataFromDB];
    RSSyncReq *req = [RSSyncReq new];
    NSArray *messages = [[RSDBService db] getObjectsOfClass:[RSMessageModel class] fromTable:NSStringFromClass([RSMessageModel class]) orderBy:RSMessageModel.createTime.order(WCTOrderedDescending) limit:1];
    if ([messages count] > 0) {
        RSMessageModel *messageModel = [messages lastObject];
        req.syncBuff = messageModel.nextSyncBuff;
    }
    RSRequest *request = [[RSRequest alloc] init];
    request.cgiName = @"sync";
    request.data = [req data];
    request.mokeResponseData = [self mokeResponse];
    RACSignal *signal = [RSNetWorkService sendRequest:request];
    @weakify(self);
    [signal subscribeNext:^(RSResponse *response) {
        @RSStrongify(self);
        RSSyncResp *resp = [RSSyncResp parseFromData:response.data error:nil];
        if (!resp) {
            return;
        }
        [self sendUpdateData:resp];
        NSMutableArray<RSMessageModel *> *tmp = [[NSMutableArray alloc] init];
        for (RSMsg *msg in resp.msgArray) {
            RSMessageModel *messageModel = [[RSMessageModel alloc] init];
            messageModel.messageId = [NSString stringWithFormat:@"%lld",msg.id_p];
            messageModel.type = msg.type;
            messageModel.content = msg.content;
            messageModel.createTime = [NSDate date];
            messageModel.nextSyncBuff = resp.nextSyncBuff;
            if (![[RSDBService db] insertObject:messageModel into:NSStringFromClass([RSMessageModel class])]) {
                //save db fail
                [[RSDBService db] updateAllRowsInTable:NSStringFromClass([RSMessageModel class]) onProperties:RSMessageModel.AllProperties  withObject:messageModel];
            }
        }
        [self loadDataFromDB];
    } error:^(NSError * _Nullable error) {
        [self sendErrorSignal:error];
    } completed:^{
        [self sendCompleteSignal];
    }];
}

-(void)loadDataFromDB {
    NSArray *messages = [[RSDBService db] getObjectsOfClass:[RSMessageModel class] fromTable:NSStringFromClass([RSMessageModel class]) orderBy:RSMessageModel.createTime.order(WCTOrderedDescending) limit:20];
    [self updateListData:messages];
}

-(void)updateListData:(NSArray<RSMessageModel *> *)array {
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    for (RSMessageModel *messageModel in array) {
        RSMessageItemViewModel *item = [RSMessageItemViewModel new];
        item.name = [[NSString alloc] initWithData:messageModel.content encoding:NSUTF8StringEncoding];
        [tmp addObject:item];
    }
    @weakify(self);
    dispatch_async_on_main_queue(^{
        @RSStrongify(self);
        self.listData = tmp;
    });
}
    
-(NSData *)mokeResponse {
    RSSyncResp *syncResp = [RSSyncResp new];
    RSBaseResp *baseResp = [RSBaseResp new];
    baseResp.errCode = 0;
    syncResp.nextSyncBuff = [@"sjsjsjs" dataUsingEncoding:NSUTF8StringEncoding];
    syncResp.baseResp = baseResp;
    RSMsg *msg = [RSMsg new];
    msg.id_p = 111;
    msg.content = [@"sjsjsjs" dataUsingEncoding:NSUTF8StringEncoding];
    RSMsg *msg2 = [RSMsg new];
    msg2.id_p = 222;
    msg2.content = [@"sjsjsjs" dataUsingEncoding:NSUTF8StringEncoding];
    RSMsg *msg3 = [RSMsg new];
    msg3.id_p = 333;
    msg3.content = [@"sjsjsjs" dataUsingEncoding:NSUTF8StringEncoding];
    [syncResp.msgArray addObject:msg];
    [syncResp.msgArray addObject:msg2];
    [syncResp.msgArray addObject:msg3];
    return [syncResp data];
}
@end
