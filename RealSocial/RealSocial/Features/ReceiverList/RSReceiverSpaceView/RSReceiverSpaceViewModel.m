//
//  RSReceiverSpaceViewModel.m
//  RealSocial
//
//  Created by kuncai on 2018/2/10.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSReceiverSpaceViewModel.h"
#import "Spspacecgi.pbobjc.h"
#import "RSRequestFactory.h"
@implementation RSReceiverSpaceItemViewModel
@end
@implementation RSReceiverSpaceViewModel

-(void)loadData {
    RSGetAllMySpaceReq *req = [RSGetAllMySpaceReq new];
    RSRequest *request = [RSRequestFactory requestWithReq:req moke:nil];
    @weakify(self);
    [[RSNetWorkService sendRequest:request] subscribeNext:^(RSResponse *response) {
        @RSStrongify(self);
        RSGetAllMySpaceResp *resp = [RSGetAllMySpaceResp parseFromData:response.data error:nil];
        [self sendUpdateData:resp];
        NSMutableArray *tmp = [[NSMutableArray alloc] init];
        for (RSSpace *space in resp.listArray) {
            RSReceiverSpaceItemViewModel *item = [[RSReceiverSpaceItemViewModel alloc] init];
            item.avatarUrl = @"http://www.ladysh.com/d/file/2016080410/2306_160803134243_1.jpg";
            item.name = space.creator;
            item.spaceId = space.spaceId.svrId;
            item.num = [NSString stringWithFormat:@"(%lu)", (unsigned long)space.authorArray_Count];
            item.isSeleted = NO;
            [tmp addObject:item];
        }
        @weakify(self);
        dispatch_sync_on_main_queue(^{
            @RSStrongify(self);
            self.listData = tmp;
        });
    } error:^(NSError * _Nullable error) {
        [self sendErrorSignal:error];
    } completed:^{
        [self sendCompleteSignal];
    }];
}

-(NSArray *)getSelectedSpaces {
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    for (RSReceiverSpaceItemViewModel *item in self.listData) {
        if (item.isSeleted) {
            [tmp addObject:@(item.spaceId)];
        }
        
    }
    return tmp;
    
}
@end
