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

@implementation RSSpaceLineItemViewModel
-(void)updateWithStory:(RSSpace *)space {
    _space = space;
    if (space.starListArray_Count > 0) {
        RSStar *firstItem = [space.starListArray firstObject];
        self.titleString = firstItem.author;
        self.subTitleString = @"kkk sub title test";
        self.avatarUrl = @"http://www.ladysh.com/d/file/2016080410/2306_160803134243_1.jpg";
        self.mediaUrl = (firstItem.type == RSenStarType_StoryItemTypeImg) ? firstItem.img.imgURL :firstItem.video.videoURL;
    }
}
@end
@implementation RSSpaceLineViewModel
-(void)loadData {
    RSGetAllSpaceReq *req = [RSGetAllSpaceReq new];
    RSRequest *request = [[RSRequest alloc] init];
    request.data = [req data];
    request.cgiName = RSGetAllStoryReqCgiName;
    request.mokeResponseData = [self moke];
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
        for (RSSpace *story in resp.listArray) {
            RSSpaceLineItemViewModel *itemVM = [[RSSpaceLineItemViewModel alloc] init];
            [itemVM updateWithStory:story];
            [tmp addObject:itemVM];
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

-(NSData *)moke {
    RSGetAllSpaceResp *resp = [RSGetAllSpaceResp new];
    RSSpace *story1 = [RSSpace new];
    RSStar *storyItem = [RSStar new];
    storyItem.author = @"kkkk test";
    storyItem.type = RSenStarType_StoryItemTypeImg;
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
    return [resp data];
}
@end
