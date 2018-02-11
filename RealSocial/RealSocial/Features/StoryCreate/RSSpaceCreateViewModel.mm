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
#import "RSSpaceCreateModel+WCTTableCoding.h"
#import "RSDBService.h"

@implementation RSSpaceCreateViewModel

-(RACSignal *)create:(UIImage *)picture toUsers:(NSArray *)users toSpaces:(NSArray *)spaces type:(RSSpaceCreateModelType)type {
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self);
        NSData *fileData = UIImageJPEGRepresentation(picture, 0.1);
        NSString *pictureId = [RSMediaService pictureIdWithData:fileData];
        BOOL result = [RSMediaService savePictureLocal:fileData pictureId:pictureId];
        if (result == NO) {
            [subscriber sendError:[NSError errorWithString:@"照片本地保存失败"]];
            return nil;
        }
        [subscriber sendCompleted];
        RSSpaceCreateModel *spaceCreateModel = [[RSSpaceCreateModel alloc] init];
        spaceCreateModel.mediaId = pictureId;
        spaceCreateModel.creator = [RSLoginService shareInstance].loginInfo.uid;
        spaceCreateModel.createTime = [NSDate date];
        spaceCreateModel.type = type;
        spaceCreateModel.users = users;
        spaceCreateModel.spaces = spaces;
        BOOL dbResult = [[RSDBService db] insertObject:spaceCreateModel into:NSStringFromClass([RSSpaceCreateModel class])];
        if (dbResult == NO) {
            return nil;
        }
        @weakify(self);
        [RSMediaService uploadPictureCDN:fileData pictureId:pictureId complete:^(BOOL isOK, NSError *error) {
            @RSStrongify(self);
            if (isOK == NO) {
                return;
            }
            if (type == RSSpaceCreateModelTypeSignal) {
                [self createSignalSpaceWithPictureId:pictureId toUsers:users toSpaces:spaces];
            }
//            if (type == RSSpaceCreateModelTypeGruop) {
//                [self createGroupSpaceWithPictureId:pictureId Authors:users];
//            }
        }];
        return nil;
    }];
}

-(void)createSignalSpaceWithPictureId:(NSString *)pictureId toUsers:(NSArray *)users toSpaces:(NSArray *)spaces {
    BOOL result = [self updateSpaceCreateModel:pictureId status:RSSpaceCreateModelStatusCreating];
    if (result == NO) {
        return;
    }
    NSMutableArray *signals = [[NSMutableArray alloc] init];
    /*
     //创建多个单人Space 缺失
    for (NSString *user in users) {
        RSRequest *request = [self buildRequestWithPictureId:pictureId toUsers:@[user]];
        RACSignal *signal = [RSNetWorkService sendRequest:request];
        [signal subscribeNext:^(RSResponse *response) {
            RSCreateSpaceResp *resp = [RSCreateSpaceResp parseFromData:response.data error:nil];
            [self sendUpdateData:resp];
            NSLog(@"创建Space成功,svrId:%llu",resp.spaceId.svrId);
        } error:^(NSError * _Nullable error) {
            NSLog(@"创建Space失败:%@",error);
        } completed:^{
            
        }];
        [signals addObject:signal];
    }
     */
    
    for (NSNumber *spaceIds in spaces) {
        //往多个space添加star
        RSRequest *request = [self buildRequestWithPictureId:pictureId toSpaces:@[spaceIds]];
        RACSignal *signal = [RSNetWorkService sendRequest:request];
        [signal subscribeNext:^(RSResponse *response) {
            RSCreateSpaceResp *resp = [RSCreateSpaceResp parseFromData:response.data error:nil];
            NSLog(@"添加start成功,svrId:%llu",resp.spaceId.svrId);
        } error:^(NSError * _Nullable error) {
            NSLog(@"添加start失败:%@",error);
        } completed:^{
            
        }];
        [signals addObject:signal];
    }
    @weakify(self);
    [[RACSignal zip:signals] subscribeNext:^(RACTuple * _Nullable x) {
        NSArray *array = [x allObjects];
        @RSStrongify(self);
        [self updateSpaceCreateModel:pictureId status:RSSpaceCreateModelStatusFinish];
    }];
}

-(BOOL)updateSpaceCreateModel:(NSString *)mediaId status:(RSSpaceCreateModelStatus)status {
    RSSpaceCreateModel *spaceCreateModel = [[RSSpaceCreateModel alloc] init];
    spaceCreateModel.mediaId = mediaId;
    spaceCreateModel.status = status;
    BOOL dbResult = [[RSDBService db] updateAllRowsInTable:NSStringFromClass([RSSpaceCreateModel class]) onProperty:RSSpaceCreateModel.status withObject:spaceCreateModel];
    return dbResult;
}

//添加Start到多个Space
-(RSRequest *)buildRequestWithPictureId:(NSString *)pictureId toSpaces:(NSArray *)spaces {
    RSAddStarReq *req = [RSAddStarReq new];
    RSIdPair *idpair = [RSIdPair new];
    idpair.svrId = [(NSNumber *)[spaces firstObject] longLongValue];
    idpair.clientId = pictureId;
    req.spaceId = idpair;
    RSStar *star = [RSStar new];
    star.type = RSenStarType_StarTypeImg;
    star.starId = idpair;
    star.author = [RSLoginService shareInstance].loginInfo.uid;
    RSStarImg *img = [RSStarImg new];
    img.imgURL = [RSMediaService urlWithPictureId:pictureId];
    img.thumbURL = [RSMediaService urlWithPictureId:pictureId];
    star.img = img;
    [req.starListArray addObject:star];
    RSRequest *request = [RSRequestFactory requestWithReq:req moke:nil];
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
