//
//  RSPictureListViewModel.m
//  RealSocial
//
//  Created by kuncai on 2018/2/1.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSPictureListViewModel.h"
#import "RSDBService.h"
#import <YYModel.h>
#import "MGFacepp.h"
@implementation RSPictureListViewModel
-(instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)loadData {
    NSArray<RSPictureModel *> * items =[[RSDBService db] getObjectsOfClass:[RSPictureModel class] fromTable:NSStringFromClass([RSPictureModel class]) limit:10];
    NSMutableArray<RSPictureListItemViewModel*> *tmp = [[NSMutableArray alloc] init];
    for (RSPictureModel *model in items) {
        RSPictureListItemViewModel *itemViewModel = [[RSPictureListItemViewModel alloc] init];
        itemViewModel.pictureModel = model;
        itemViewModel.faceInfos = [NSArray yy_modelArrayWithClass:[MGFaceInfo class] json:model.info];
        [tmp addObject:itemViewModel];
    }
    [self sendUpdateData:tmp];
    @weakify(self);
    dispatch_async_on_main_queue(^{
        @RSStrongify(self);
        self.listData = tmp;
        [self sendCompleteSignal];
    });
}
@end
