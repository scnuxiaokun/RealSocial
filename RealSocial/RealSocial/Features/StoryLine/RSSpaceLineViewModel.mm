//
//  RSStoryLineViewModel.m
//  RealSocial
//
//  Created by kuncai on 2018/2/7.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSSpaceLineViewModel.h"
#import "RSNetWorkService.h"
#import "RSLoginService.h"
#import "RSRequestFactory.h"
#import "RSContactService.h"
@implementation RSSpaceLineItemViewModel
-(void)updateWithSpace:(RSSpace *)space {
    _space = space;
    if (space.type == RSenSpaceType_SpaceTypeSingle) {
        RSContactModel *creatorModel = [[RSContactService shareInstance] getContactByUid:space.creator];
        self.titleString = creatorModel.nickName;
        self.avatarUrls = @[creatorModel.avatarUrl];
        self.subTitleString = @"Single sub title test";
    }
    if (space.type == RSenSpaceType_SpaceTypeGroup) {
        NSArray<RSContactModel *> *contacts = [[RSContactService shareInstance] getContactsByUids:space.authorArray];
        self.titleString = space.name;
        NSMutableArray *tmp = [[NSMutableArray alloc] init];
        for (RSContactModel *model in contacts) {
            [tmp addObject:model.avatarUrl];
        }
        self.avatarUrls = tmp;
        self.subTitleString = @"group sub title test";
    }
    
    if (space.starListArray_Count > 0) {
        RSStar *firstItem = [space.starListArray firstObject];
//        self.titleString = firstItem.author;
//        self.avatarUrl = @"http://www.ladysh.com/d/file/2016080410/2306_160803134243_1.jpg";
        self.mediaUrl = (firstItem.type == RSenStarType_StarTypeImg) ? firstItem.img.imgURL :firstItem.video.videoURL;
        self.titleString = [self.titleString stringByAppendingString:[NSString stringWithFormat:@"(%lu)",space.starListArray_Count]];
    }
}
@end
@implementation RSSpaceLineViewModel
-(void)loadData {
    RSGetAllSpaceReq *req = [RSGetAllSpaceReq new];
    RSRequest *request = [RSRequestFactory requestWithReq:req moke:[self moke]];
    RACSignal *signal = [RSNetWorkService sendRequest:request];
    @weakify(self);
    [signal subscribeNext:^(RSResponse *response) {
        @RSStrongify(self);
        RSGetAllSpaceResp *resp = [RSGetAllSpaceResp parseFromData:response.data error:nil];
        if (!resp) {
            return;
        }
        [self sendUpdateData:resp];
        NSMutableArray *tmp = [[NSMutableArray alloc] init];
        int i=0;
        for (RSSpace *space in resp.listArray) {
            RSSpaceLineItemViewModel *itemVM = [[RSSpaceLineItemViewModel alloc] init];
            [itemVM updateWithSpace:space];
            [tmp addObject:itemVM];
            if (i > 2) {
//                break;
            }
            i++;
        }
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

-(RSGetAllSpaceResp *)moke {
    return nil;
    RSGetAllSpaceResp *resp = [RSGetAllSpaceResp new];
    RSSpace *story1 = [RSSpace new];
    RSStar *storyItem = [RSStar new];
    storyItem.author = @"kkkk test";
    storyItem.type = RSenStarType_StarTypeImg;
    RSStarImg *img = [RSStarImg new];
    img.imgURL = @"https://imgcache.cjmx.com/star/201511/20151121185842938.jpg";
    storyItem.img = img;
    [story1.starListArray addObject:storyItem];
    [story1.starListArray addObject:[storyItem copy]];
    [story1.starListArray addObject:[storyItem copy]];
    [story1.starListArray addObject:[storyItem copy]];
    [story1.starListArray addObject:[storyItem copy]];
    [story1.starListArray addObject:[storyItem copy]];
    [resp.listArray addObject:story1];
    [resp.listArray addObject:[story1 copy]];
    [resp.listArray addObject:[story1 copy]];
    [resp.listArray addObject:[story1 copy]];
    [resp.listArray addObject:[story1 copy]];
    [resp.listArray addObject:[story1 copy]];
    [resp.listArray addObject:[story1 copy]];
    [resp.listArray addObject:[story1 copy]];
    [resp.listArray addObject:[story1 copy]];
    [resp.listArray addObject:[story1 copy]];
    [resp.listArray addObject:[story1 copy]];
    [resp.listArray addObject:[story1 copy]];
    [resp.listArray addObject:[story1 copy]];
    [resp.listArray addObject:[story1 copy]];
    [resp.listArray addObject:[story1 copy]];
    [resp.listArray addObject:[story1 copy]];
    [resp.listArray addObject:[story1 copy]];
    [resp.listArray addObject:[story1 copy]];
    return resp;
}
@end
