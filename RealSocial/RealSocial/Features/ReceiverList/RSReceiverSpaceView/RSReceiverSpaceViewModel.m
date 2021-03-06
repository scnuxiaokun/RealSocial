//
//  RSReceiverSpaceViewModel.m
//  RealSocial
//
//  Created by kuncai on 2018/2/10.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSReceiverSpaceViewModel.h"
#import "RSMediaService.h"
#import "RSNetWorkService.h"
#import "Spspacecgi.pbobjc.h"
#import "Spcgicommdef.pbobjc.h"
#import "RSRequestFactory.h"
#import "RSLoginService.h"
#import "RSContactService.h"

@implementation RSReceiverSpaceItemViewModel
-(instancetype)init {
    self = [super init];
    if (self) {
        self.isSelected = NO;
        self.type = RSReceiverSpaceItemViewModelTypeNormal;
    }
    return self;
}
@end
@implementation RSReceiverSpaceViewModel

-(void)loadData {
    RSGetAllMySpaceReq *req = [RSGetAllMySpaceReq new];
    RSRequest *request = [RSRequestFactory requestWithReq:req resp:[RSGetAllMySpaceResp class] moke:nil];
    @weakify(self);
    [[RSNetWorkService sendRequest:request] subscribeNext:^(RSGetAllMySpaceResp *resp) {
        @RSStrongify(self);
        [self sendUpdateData:resp];
        NSMutableArray *tmp = [[NSMutableArray alloc] init];
        for (RSSpace *space in resp.listArray) {
            if (space.type != RSenSpaceType_SpaceTypeGroup) {
                continue;
            }
            RSReceiverSpaceItemViewModel *item = [[RSReceiverSpaceItemViewModel alloc] init];
            NSArray<RSContactModel *> *contacts = [[RSContactService shareInstance] getContactsByUids:space.authorArray];
            NSMutableArray *tmpUrls = [[NSMutableArray alloc] init];
            for (RSContactModel *model in contacts) {
                [tmpUrls addObject:model.avatarUrl];
            }
            item.avatarUrls = tmpUrls;
            item.name = space.name;
            item.spaceId = space.spaceId.svrId;
            item.num = [NSString stringWithFormat:@"(%lu)", (unsigned long)space.authorArray_Count];
            [tmp addObject:item];
        }
//        RSReceiverSpaceItemViewModel *item = [[RSReceiverSpaceItemViewModel alloc] init];
//        item.type = RSReceiverSpaceItemViewModelTypeAdd;
//        [tmp addObject:item];
        @weakify(self);
        dispatch_sync_on_main_queue(^{
            @RSStrongify(self);
            self.listData = [[tmp reverseObjectEnumerator] allObjects];
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
        if (item.isSelected && item.type == RSReceiverSpaceItemViewModelTypeNormal) {
            [tmp addObject:@(item.spaceId)];
        }
    }
    return tmp;
    
}

-(RACSignal *)createGroupSpaceWithAuthors:(NSArray *)authors SpaceName:(NSString *)name {
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self);
        if (!self) {
            return nil;
        }
        if ([authors count] <= 0) {
            [subscriber sendError:[NSError errorWithString:@"创作者为能为空"]];
            return nil;
        }
        NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
        NSString *pictureId = [NSString stringWithFormat:@"%@_%f",[RSLoginService shareInstance].loginInfo.uid, time];
        RSRequest *request = [self buildRequestWithClientId:pictureId Authors:authors Name:name];
        RACSignal *signal = [RSNetWorkService sendRequest:request];
        [signal subscribeNext:^(RSCreateSpaceResp *resp) {
//            RSCreateSpaceResp *resp = [RSCreateSpaceResp parseFromData:response.data error:nil];
            NSLog(@"创建多人协作Space成功,svrId:%llu",resp.spaceId.svrId);
        } error:^(NSError * _Nullable error) {
            NSLog(@"创建多人协作Space失败:%@",error);
            [subscriber sendError:error];
        } completed:^{
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}

//创建多人创作Space
-(RSRequest *)buildRequestWithClientId:(NSString *)clientId Authors:(NSArray *)authors Name:(NSString *)name{
    RSCreateSpaceReq *req = [RSCreateSpaceReq new];
    RSSpace *space = [RSSpace new];
    space.type = RSenSpaceType_SpaceTypeGroup;
    
    if ([name length] > 0) {
        space.name = name;
    } else {
        NSString *myNickName = [[RSContactService shareInstance] getNickNameByUid:[RSLoginService shareInstance].loginInfo.uid];
        space.name = [myNickName stringByAppendingString:@"的圈子"];
    }
    
    RSReceiver *receiver = [RSReceiver new];
    receiver.type = RSenReceiverType_ReceiverTypeAuthor;
    space.receiver = receiver;
    RSIdPair *idpair = [RSIdPair new];
    idpair.clientId = clientId;
    space.spaceId = idpair;
//    RSStar *star = [RSStar new];
//    star.type = RSenStarType_StarTypeImg;
//    star.starId = idpair;
//    RSStarImg *img = [RSStarImg new];
//    img.imgURL = [RSMediaService urlWithPictureId:clientId];
//    img.thumbURL = [RSMediaService urlWithPictureId:clientId];
//    star.img = img;
//    [space.starListArray addObject:star];
    space.creator = [RSLoginService shareInstance].loginInfo.uid;
    space.authorArray = [[NSMutableArray alloc] initWithArray:authors];
    [space.authorArray addObject:space.creator];
    req.space = space;
    RSRequest *request = [RSRequestFactory requestWithReq:req resp:[RSCreateSpaceResp class] moke:nil];
    return request;
}
@end
