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
#import "RSSpaceModel+WCTTableCoding.h"
#import "RSStarModel+WCTTableCoding.h"
#import "RSDBService.h"

@implementation RSSpaceLineItemViewModel
-(instancetype)init {
    self = [super init];
    if (self) {
        _isReaded = NO;
    }
    return self;
}

-(void)updateWithSpaceModel:(RSSpaceModel *)spaceModel {
    [self updateWithSpace:[spaceModel toSpace]];
    _isReaded = spaceModel.isReaded;
}

-(void)updateWithSpace:(RSSpace *)space {
    _space = space;
    if (space.type == RSenSpaceType_SpaceTypeSingle) {
        RSContactModel *creatorModel = [[RSContactService shareInstance] getContactByUid:space.creator];
        if (creatorModel) {
            self.titleString = creatorModel.nickName;
            self.avatarUrls = @[creatorModel.avatarUrl];
            self.subTitleString = @"Single sub title test";
        } else {
            self.titleString = @"";
            self.avatarUrls = @[];
            self.subTitleString = @"Single sub title test";
        }
    }
    if (space.type == RSenSpaceType_SpaceTypeGroup) {
        NSArray<RSContactModel *> *contacts = [[RSContactService shareInstance] getContactsByUids:space.authorArray];
        self.titleString = space.name;
        self.titleString = [self.titleString stringByAppendingString:[NSString stringWithFormat:@"(%lu)",space.authorArray_Count]];
        NSMutableArray *tmp = [[NSMutableArray alloc] init];
        for (RSContactModel *model in contacts) {
            [tmp addObject:model.avatarUrl];
        }
        self.avatarUrls = tmp;
        self.subTitleString = @"group sub title test";
    }
    
    if (space.starListArray_Count > 0) {
        RSStar *firstItem = [space.starListArray lastObject];
        //        self.titleString = firstItem.author;
        //        self.avatarUrl = @"http://www.ladysh.com/d/file/2016080410/2306_160803134243_1.jpg";
        self.mediaUrl = (firstItem.type == RSenStarType_StarTypeImg) ? firstItem.img.imgURL :firstItem.video.videoURL;
    }
}

-(void)saveReadedToDB {
    _isReaded = YES;
    RSSpaceModel *spaceModel = [[RSSpaceModel alloc] initWithSpace:self.space];
    spaceModel.isReaded = _isReaded;
    BOOL result = [[RSDBService db] updateRowsInTable:NSStringFromClass([RSSpaceModel class]) onProperty:RSSpaceModel.isReaded withObject:spaceModel where:RSSpaceModel.spaceId.is(spaceModel.spaceId)];
}
@end
@implementation RSSpaceLineViewModel
-(void)loadData {
    [self loadDataFromDB];
    RSGetAllSpaceReq *req = [RSGetAllSpaceReq new];
    RSRequest *request = [RSRequestFactory requestWithReq:req resp:[RSGetAllSpaceResp class] moke:nil];
    RACSignal *signal = [RSNetWorkService sendRequest:request];
    @weakify(self);
    [signal subscribeNext:^(RSGetAllSpaceResp *resp) {
        @RSStrongify(self);
        [self sendUpdateData:resp];
        [self saveToDB:resp];
        [self loadDataFromDB];
//        NSArray *sortListArray = [resp.listArray sortedArrayWithOptions:NSSortStable usingComparator:
//                                  ^NSComparisonResult(RSSpace *  _Nonnull obj1, RSSpace *  _Nonnull obj2) {
//                                      if (obj1.updateTime > obj2.updateTime) {
//                                          return NSOrderedAscending;
//                                      }
//                                      return  NSOrderedDescending;
//                                  }];
//        NSInteger hour24 = [[NSDate date] timeIntervalSince1970] - 86400;
//        NSMutableArray *tmp = [[NSMutableArray alloc] init];
//        for (RSSpace *space in sortListArray) {
//            if (space.updateTime > hour24) {
//                RSSpaceLineItemViewModel *itemVM = [[RSSpaceLineItemViewModel alloc] init];
//                [itemVM updateWithSpace:space];
//                [tmp addObject:itemVM];
//            }
//        }
        
//        @weakify(self);
//        dispatch_sync_on_main_queue(^{
//            @RSStrongify(self);
//            self.listData = tmp;
//        });
    } error:^(NSError * _Nullable error) {
        [self sendErrorSignal:error];
    } completed:^{
        [self sendCompleteSignal];
    }];
}

-(BOOL)saveToDB:(RSGetAllSpaceResp *)resp {
    return [[RSDBService db] runTransaction:^BOOL{
        for (RSSpace *space in resp.listArray) {
            RSSpaceModel *spaceModel = [[RSSpaceModel alloc] initWithSpace:space];
            NSArray *spaceModels = [[RSDBService db] getObjectsOfClass:[RSSpaceModel class] fromTable:NSStringFromClass([RSSpaceModel class]) where:RSSpaceModel.spaceId.is(spaceModel.spaceId) limit:1];
            if ([spaceModels count] > 0) {
                RSSpaceModel *spaceModelDB = [spaceModels firstObject];
                if (spaceModel.updateTime > spaceModelDB.updateTime) {
                    [[RSDBService db] insertOrReplaceObject:spaceModel into:NSStringFromClass([RSSpaceModel class])];
                }
            } else {
                [[RSDBService db] insertOrReplaceObject:spaceModel into:NSStringFromClass([RSSpaceModel class])];
            }
        }
        return YES;
    }];
}

-(NSArray<RSSpaceModel*> *)getSpacesFromDBIn24Hour{
    NSInteger hour24 = [[NSDate date] timeIntervalSince1970] - 86400;
    NSArray *spaceModels = [[RSDBService db] getObjectsOfClass:[RSSpaceModel class] fromTable:NSStringFromClass([RSSpaceModel class]) where:RSSpaceModel.updateTime > hour24 orderBy:RSSpaceModel.updateTime.order(WCTOrderedDescending) limit:50];
    return spaceModels;
}

-(void)loadDataFromDB {
//    @weakify(self);
//    dispatch_async(YYDispatchQueueGetForQOS(NSQualityOfServiceBackground), ^{
//        @RSStrongify(self);
//        NSInteger hour24 = [[NSDate date] timeIntervalSince1970] - 86400;
        NSArray<RSSpaceModel*> *spaces = [self getSpacesFromDBIn24Hour];
        NSMutableArray *tmp = [[NSMutableArray alloc] init];
        for (RSSpaceModel *spaceModel in spaces) {
            RSSpaceLineItemViewModel *itemVM = [[RSSpaceLineItemViewModel alloc] init];
            [itemVM updateWithSpaceModel:spaceModel];
            [tmp addObject:itemVM];
        }
        @weakify(self);
        dispatch_sync_on_main_queue(^{
            @RSStrongify(self);
            self.listData = tmp;
        });
//    });
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

