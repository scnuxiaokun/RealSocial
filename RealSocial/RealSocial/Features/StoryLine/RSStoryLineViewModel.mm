//
//  RSStoryLineViewModel.m
//  RealSocial
//
//  Created by kuncai on 2018/2/7.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSStoryLineViewModel.h"
#import "RSNetWorkService.h"
#import "RSLoginService.h"

@implementation RSStoryLineItemViewModel
-(void)updateWithStory:(RSStory *)story {
    _story = story;
    if (story.itemArray_Count > 0) {
        RSStoryItem *firstItem = [story.itemArray firstObject];
        self.titleString = firstItem.fromUserName;
        self.subTitleString = @"kkk sub title test";
        self.avatarUrl = @"http://www.ladysh.com/d/file/2016080410/2306_160803134243_1.jpg";
        self.mediaUrl = (firstItem.type == RSenStoryItemType_StoryItemTypeImg) ? firstItem.img.imgRl :firstItem.video.videoURL;
    }
}
@end
@implementation RSStoryLineViewModel
-(void)loadData {
    RSGetAllStoryReq *req = [RSGetAllStoryReq new];
    RSRequest *request = [[RSRequest alloc] init];
    request.data = [req data];
    request.cgiName = RSGetAllStoryReqCgiName;
    request.mokeResponseData = [self moke];
    RACSignal *signal = [RSNetWorkService sendRequest:request];
    @weakify(self);
    [signal subscribeNext:^(RSResponse *response) {
        @RSStrongify(self);
        RSGetAllStoryResp *resp = [RSGetAllStoryResp parseFromData:response.data error:nil];
        if (!resp) {
            return;
        }
        [self sendUpdateData:resp];
        NSMutableArray *tmp = [[NSMutableArray alloc] init];
        for (RSStory *story in resp.listArray) {
            RSStoryLineItemViewModel *itemVM = [[RSStoryLineItemViewModel alloc] init];
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
    RSGetAllStoryResp *resp = [RSGetAllStoryResp new];
    RSStory *story1 = [RSStory new];
    RSStoryItem *storyItem = [RSStoryItem new];
    storyItem.fromUserName = @"kkkk test";
    storyItem.type = RSenStoryItemType_StoryItemTypeImg;
    RSStoryImg *img = [RSStoryImg new];
    img.imgRl = @"https://imgcache.cjmx.com/star/201511/20151121185842938.jpg";
    storyItem.img = img;
    [story1.itemArray addObject:storyItem];
    [story1.itemArray addObject:[storyItem copy]];
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
