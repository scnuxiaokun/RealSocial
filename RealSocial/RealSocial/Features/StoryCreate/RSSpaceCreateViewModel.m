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
#import "Spspacecgi.pbobjc.h"
#import "Spcgicommdef.pbobjc.h"

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
    
    RSCreateSpaceReq *req = [RSCreateSpaceReq new];
    RSSpace *space = [RSSpace new];
    space.type = RSenSpaceType_StoryTypePrivate;
    RSIdPair *idpair = [RSIdPair new];
    idpair.clientId = pictureId;
    space.spaceId = idpair;
//    RSStar *toItem = [RSStar new];
//    toItem.type = RSenStarType_StoryItemTypeImg;
//    toItem.toUserNameArray = [[NSMutableArray alloc] initWithArray:users];
//    story.to = toItem;
    RSStar *star = [RSStar new];
    star.type = RSenStarType_StoryItemTypeImg;
    RSStarImg *img = [RSStarImg new];
    img.imgURL = [RSMediaService urlWithPictureId:pictureId];
    star.img = img;
    [space.starListArray addObject:star];
    
    space.authorArray = [[NSMutableArray alloc] initWithArray:users];
    req.space = space;
    
    RSRequest *request = [[RSRequest alloc] init];
    request.cgiName = @"story/create";
    request.data = [req data];
    request.mokeResponseData = [self moke];
    return request;
}

-(NSData *)moke {
    RSCreateSpaceReq *resp = [RSCreateSpaceReq new];
    RSIdPair *idpair = [RSIdPair new];
    idpair.svrId = 123;
    return [resp data];
}
@end
