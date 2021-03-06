//
//  RSSpaceService.m
//  RealSocial
//
//  Created by kuncai on 2018/2/12.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSSpaceService.h"
#import "RSMediaService.h"
#import "RSNetWorkService.h"
#import "Spspacecgi.pbobjc.h"
#import "Spcgicommdef.pbobjc.h"
#import "RSRequestFactory.h"
#import "RSLoginService.h"
#import "RSSpaceCreateModel+WCTTableCoding.h"
#import "RSDBService.h"

@implementation RSSpaceService
+(RSSpaceService *)shareInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[RSSpaceService alloc] init];
    });
    return sharedInstance;
}

-(void)createToAllFriends:(NSData *)fileData mediaId:(NSString *)mediaId {
    [self _create:fileData mediaId:mediaId toUsers:@[] toSpaces:@[] type:RSenReceiverType_ReceiverTypeCreatorFriend];
}

-(void)createToMemories:(NSData *)fileData mediaId:(NSString *)mediaId {
    [self _create:fileData mediaId:mediaId toUsers:@[] toSpaces:@[] type:RSenReceiverType_ReceiverTypeCreator];
}

-(void)create:(NSData *)fileData mediaId:(NSString *)mediaId toUsers:(NSArray *)users toSpaces:(NSArray *)spaces {
    [self _create:fileData mediaId:mediaId toUsers:users toSpaces:spaces type:RSenReceiverType_ReceiverTypeList];
}

-(void)_create:(NSData *)fileData mediaId:(NSString *)mediaId toUsers:(NSArray *)users toSpaces:(NSArray *)spaces type:(RSenReceiverType)type {
    RSSpaceCreateModel *spaceCreateModel = [[RSSpaceCreateModel alloc] init];
    spaceCreateModel.mediaId = mediaId;
    spaceCreateModel.creator = [RSLoginService shareInstance].loginInfo.uid;
    spaceCreateModel.createTime = [NSDate date];
    spaceCreateModel.type = type;
    spaceCreateModel.users = users;
    spaceCreateModel.spaces = spaces;
    BOOL dbResult = [[RSDBService db] insertOrReplaceObject:spaceCreateModel into:NSStringFromClass([RSSpaceCreateModel class])];
    if (dbResult == NO) {
        return;
    }
    @weakify(self);
    [RSMediaService uploadPictureCDN:fileData pictureId:mediaId complete:^(BOOL isOK, NSError *error) {
        @RSStrongify(self);
        if (isOK == NO) {
            return;
        }
        BOOL result = [self updateSpaceCreateModel:mediaId status:RSSpaceCreateModelStatusCreating];
        if (result == NO) {
            return;
        }
        switch (type) {
            case RSenReceiverType_ReceiverTypeCreator:
                //回忆
                [self _createSpaceWithMediaId:mediaId type:type];
                break;
            case RSenReceiverType_ReceiverTypeCreatorFriend:
                //所有好友
                [self _createSpaceWithMediaId:mediaId type:type];
                break;
            default:
                [self createSignalSpaceWithPictureId:mediaId toUsers:users toSpaces:spaces];
                break;
        }
        
    }];
}

-(void)_createSpaceWithMediaId:(NSString *)mediaId type:(RSenReceiverType)type {
    RSRequest *request = [self buildRequestWithPictureId:mediaId type:type];
    RACSignal *signal = [RSNetWorkService sendRequest:request];
    [signal subscribeNext:^(RSCreateSpaceResp *resp) {
        NSLog(@"创建Space成功,svrId:%llu",resp.spaceId.svrId);
    } error:^(NSError * _Nullable error) {
        NSLog(@"创建Space失败:%@",error);
    } completed:^{
        
    }];
}

-(void)createSignalSpaceWithPictureId:(NSString *)pictureId toUsers:(NSArray *)users toSpaces:(NSArray *)spaces {
    NSMutableArray *signals = [[NSMutableArray alloc] init];
    if ([users count] > 0) {
        RSRequest *request = [self buildRequestWithPictureId:pictureId toUsers:users];
        RACSignal *signal = [RSNetWorkService sendRequest:request];
        [signal subscribeNext:^(RSCreateSpaceResp *resp) {
            NSLog(@"创建Space成功,svrId:%llu",resp.spaceId.svrId);
        } error:^(NSError * _Nullable error) {
            NSLog(@"创建Space失败:%@",error);
        } completed:^{
            
        }];
        [signals addObject:signal];
    }
    
    for (NSNumber *spaceIds in spaces) {
        //往多个space添加star
        RSRequest *request = [self buildRequestWithPictureId:pictureId toSpaces:@[spaceIds]];
        RACSignal *signal = [RSNetWorkService sendRequest:request];
        [signal subscribeNext:^(RSCreateSpaceResp *resp) {
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
    RSRequest *request = [RSRequestFactory requestWithReq:req resp:[RSCreateSpaceResp class] moke:nil];
    return request;
}

//创建signle space发送给多个好友
-(RSRequest *)buildRequestWithPictureId:(NSString *)pictureId toUsers:(NSArray *)users {
    RSCreateSpaceReq *req = [RSCreateSpaceReq new];
    
    RSSpace *space = [RSSpace new];
    space.type = RSenSpaceType_SpaceTypeSingle;
    
    RSIdPair *idpair = [RSIdPair new];
    idpair.clientId = pictureId;
    space.spaceId = idpair;
    
    RSStar *star = [RSStar new];
    star.type = RSenStarType_StarTypeImg;
    star.starId = idpair;
    star.author = [RSLoginService shareInstance].loginInfo.uid;
    RSStarImg *img = [RSStarImg new];
    img.imgURL = [RSMediaService urlWithPictureId:pictureId];
    img.thumbURL = [RSMediaService urlWithPictureId:pictureId];
    star.img = img;
    [space.starListArray addObject:star];
    
    RSReceiver *receiver = [RSReceiver new];
    receiver.type = RSenReceiverType_ReceiverTypeList;
    receiver.userNameArray = [[NSMutableArray alloc] initWithArray:users];
    space.receiver = receiver;
    
    space.creator = [RSLoginService shareInstance].loginInfo.uid;
    
    req.space = space;
    RSRequest *request = [RSRequestFactory requestWithReq:req resp:[RSCreateSpaceResp class] moke:nil];
    return request;
}

-(RSRequest *)buildRequestWithPictureId:(NSString *)pictureId type:(RSenReceiverType)type{
    RSCreateSpaceReq *req = [RSCreateSpaceReq new];
    
    RSSpace *space = [RSSpace new];
    space.type = RSenSpaceType_SpaceTypeSingle;
    
    RSIdPair *idpair = [RSIdPair new];
    idpair.clientId = pictureId;
    space.spaceId = idpair;
    
    RSStar *star = [RSStar new];
    star.type = RSenStarType_StarTypeImg;
    star.starId = idpair;
    star.author = [RSLoginService shareInstance].loginInfo.uid;
    RSStarImg *img = [RSStarImg new];
    img.imgURL = [RSMediaService urlWithPictureId:pictureId];
    img.thumbURL = [RSMediaService urlWithPictureId:pictureId];
    star.img = img;
    [space.starListArray addObject:star];
    
    RSReceiver *receiver = [RSReceiver new];
    receiver.type = type;
    receiver.userNameArray = [[NSMutableArray alloc] initWithArray:@[[RSLoginService shareInstance].loginInfo.uid]];
    space.receiver = receiver;
    
    space.creator = [RSLoginService shareInstance].loginInfo.uid;
    
    req.space = space;
    RSRequest *request = [RSRequestFactory requestWithReq:req resp:[RSCreateSpaceResp class] moke:nil];
    return request;
}
@end
