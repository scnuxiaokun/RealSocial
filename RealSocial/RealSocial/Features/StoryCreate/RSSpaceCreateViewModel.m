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
#import "RSRequestFactory.h"
#import "RSLoginService.h"

@implementation RSSpaceCreateViewModel
-(RACSignal *)create:(UIImage *)picture toUsers:(NSArray *)users {
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self);
        NSData *fileData = UIImageJPEGRepresentation(picture, 0.1);
        NSString *pictureId = [RSMediaService pictureIdWithData:fileData];
        BOOL result = [RSMediaService savePictureLocal:fileData pictureId:pictureId];
        if (result) {
            @weakify(self);
            [RSMediaService uploadPictureCDN:fileData pictureId:pictureId complete:^(BOOL isOK, NSError *error) {
                @RSStrongify(self);
                if (isOK) {
                    RSRequest *request = [self buildRequestWithPictureId:pictureId toUsers:users];
                    [[RSNetWorkService sendRequest:request] subscribeNext:^(RSResponse *response) {
                        RSCreateSpaceResp *resp = [RSCreateSpaceResp parseFromData:response.data error:nil];
                        [self sendUpdateData:resp];
                        NSLog(@"创建Space成功,svrId:%llu",resp.spaceId.svrId);
                    } error:^(NSError * _Nullable error) {
                        NSLog(@"创建Space失败:%@",error);
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
    space.type = RSenSpaceType_SpaceTypeSingle;
    RSIdPair *idpair = [RSIdPair new];
    idpair.clientId = pictureId;
    space.spaceId = idpair;
//    RSStar *toItem = [RSStar new];
//    toItem.type = RSenStarType_StoryItemTypeImg;
//    toItem.toUserNameArray = [[NSMutableArray alloc] initWithArray:users];
//    story.to = toItem;
    RSStar *star = [RSStar new];
    star.type = RSenStarType_StarTypeImg;
    star.starId = idpair;
    RSStarImg *img = [RSStarImg new];
    img.imgURL = [RSMediaService urlWithPictureId:pictureId];
    img.thumbURL = [RSMediaService urlWithPictureId:pictureId];
    star.img = img;
    [space.starListArray addObject:star];
    space.creator = [RSLoginService shareInstance].loginInfo.uid;
    space.authorArray = [[NSMutableArray alloc] initWithArray:users];
    req.space = space;
    RSRequest *request = [RSRequestFactory requestWithReq:req moke:nil];
//    RSRequest *request = [[RSRequest alloc] init];
//    request.cgiName = @"story/create";
//    request.data = [req data];
//    request.mokeResponseData = [self moke];
    return request;
}

-(NSData *)moke {
    return nil;
    RSCreateSpaceReq *resp = [RSCreateSpaceReq new];
    RSIdPair *idpair = [RSIdPair new];
    idpair.svrId = 123;
    return [resp data];
}
@end
