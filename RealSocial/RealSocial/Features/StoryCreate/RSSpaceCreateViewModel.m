//
//  RSStoryCreateViewModel.m
//  RealSocial
//
//  Created by kuncai on 2018/2/7.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSSpaceCreateViewModel.h"
#import "RSMediaService.h"
#import "RSNetWorkService.h"
#import "Spstorycgi.pbobjc.h"

@implementation RSSpaceCreateViewModel
-(RACSignal *)create:(UIImage *)picture toUsers:(NSArray *)users {
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self);
        NSData *fileData = UIImageJPEGRepresentation(picture, 1);
        NSString *pictureId = [RSMediaService pictureIdWithData:fileData];
        BOOL result = [RSMediaService savePictureLocal:fileData pictureId:pictureId];
        if (result) {
            @weakify(self);
            [RSMediaService uploadPictureCDN:fileData pictureId:pictureId complete:^(BOOL isOK, NSError *error) {
                @RSStrongify(self);
                if (isOK) {
                    RSRequest *request = [self buildRequestWithPictureId:pictureId toUsers:users];
                    [[RSNetWorkService sendRequest:request] subscribeError:^(NSError * _Nullable error) {
                    } completed:^{
                    }];
                } else {
                }
            }];
            [subscriber sendCompleted];
        } else {
            [subscriber sendError:[NSError errorWithString:@"照片本地保存失败"]];
        }
//        dispatch_async(YYDispatchQueueGetForQOS(NSQualityOfServiceBackground), ^{
//            [NSThread sleepForTimeInterval:3];
//            [subscriber sendCompleted];
//        });
        return nil;
    }];
}

-(RSRequest *)buildRequestWithPictureId:(NSString *)pictureId toUsers:(NSArray *)users {
    RSCreateStoryReq *req = [RSCreateStoryReq new];
    RSStory *story = [RSStory new];
    story.type = RSenStoryType_StoryTypePrivate;
    story.clientId = pictureId;
    RSStoryToItem *toItem = [RSStoryToItem new];
    toItem.type = RSenStoryToType_StoryToTypeUser;
    toItem.toUserNameArray = [[NSMutableArray alloc] initWithArray:users];
    story.to = toItem;
    RSStoryItem *item = [RSStoryItem new];
    item.type = RSenStoryItemType_StoryItemTypeImg;
    RSStoryImg *img = [RSStoryImg new];
    img.imgRl = [RSMediaService urlWithPictureId:pictureId];
    item.img = img;
    [story.itemArray addObject:item];
    req.story = story;
    
    RSRequest *request = [[RSRequest alloc] init];
    request.cgiName = @"story/create";
    request.data = [req data];
    request.mokeResponseData = [self moke];
    return request;
}

-(NSData *)moke {
    RSCreateStoryResp *resp = [RSCreateStoryResp new];
    resp.svrId =123;
    return [resp data];
}
@end
