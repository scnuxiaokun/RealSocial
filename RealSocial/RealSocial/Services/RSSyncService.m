//
//  RSSyncService.m
//  RealSocial
//
//  Created by kuncai on 2018/3/13.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSSyncService.h"
#import "Spbasecgi.pbobjc.h"
#import "RSKeyValueService.h"
#import "RSRequestFactory.h"
#import "RSNetWorkService.h"
#import "RSContactService.h"
#import <AFNetworkReachabilityManager.h>
#import "RSLoginService.h"
@implementation RSSyncService {
    RACDisposable *_disp;
}
+(RSSyncService *)shareInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[RSSyncService alloc] init];
    });
    return sharedInstance;
}
-(instancetype)init {
    self = [super init];
    if (self) {
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
                [self loadData];
            }
            NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        }];
    }
    return self;
}
-(void)loadData {
    if (![[RSLoginService shareInstance] isLogined]) {
        return;
    }
    if (_disp) {
        [_disp dispose];
        NSLog(@"RSSyncService dispose");
    }
    RSSyncReq *req = [RSSyncReq new];
    req.syncBuff = [RSKeyValueService dataWithKey:kKeyValueSyncBuff];
    req.selector = 0xFfffffff;
    RSRequest *request = [RSRequestFactory requestWithReq:req resp:[RSSyncResp class] moke:nil];
    @weakify(self);
    _disp = [[RSNetWorkService sendRequest:request] subscribeNext:^(RSSyncResp *resp) {
        @RSStrongify(self);
        BOOL contactResult = [self saveContact:resp.contactListArray];
        BOOL groupResult = [self saveGroup:resp.groupListArray];
        if (contactResult && groupResult) {
            BOOL syncBuffResult = [RSKeyValueService saveData:resp.syncBuff key:kKeyValueSyncBuff];
            if (syncBuffResult && resp.isEnd == 0) {
                [self loadData];
            }
        }
    } error:^(NSError * _Nullable error) {
        @RSStrongify(self);
        NSLog(@"RSSyncService:%@",error);
    } completed:^{
        @RSStrongify(self);
    }];
}

-(BOOL)saveContact:(NSArray *)array {
    return [[RSContactService shareInstance] saveContactList:array];
}
-(BOOL)saveGroup:(NSArray *)array {
    return YES;
}
@end
