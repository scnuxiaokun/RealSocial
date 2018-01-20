//
//  SYBContainerViewModel.m
//  SybPlatform
//
//  Created by kuncai on 15/4/3.
//  Copyright (c) 2015年 Tencent. All rights reserved.
//

#import "RCContainerViewModel.h"

@implementation RCContainerViewModel
{
    
}

-(instancetype)init {
    self =[super init];
    if (self) {
        _viewModelArray = [[NSMutableArray alloc] init];
        _loadDataStyle = RCContainerViewModelLoadDataStyleAsynchronization;
    }
    return self;
}

-(void)addItemViewModel:(RCViewModel *)viewModel {
    if (!viewModel)return;
    [_viewModelArray addObject:viewModel];
    @weakify(self);
    [viewModel.completeSignal subscribeNext:^(id x) {
        @FPStrongify(self);
        if (_loadDataStyle == RCContainerViewModelLoadDataStyleAsynchronization) {
                [self setCompleted];
        } else {
            BOOL isAllFinish = YES;
            for (RCViewModel *viewModel in _viewModelArray) {
                if (viewModel.viewModelStatus != RCViewModelStatusFinish) {
                    isAllFinish = NO;
                    break;
                }
            }
            if (isAllFinish) {
                [self setCompleted];
            }
        }

    }];
}

-(void)setCompleted {
    @weakify(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        @FPStrongify(self);
        _dataResource = [self configDataResource];
        [super setCompleted];
    });
}

-(NSArray *)configDataResource {
//    NSAssert(NO, @"子类需要重载configDataResource");
    return nil;
}

-(void)loadData {
    [self setStatusLoading];
    for (RCViewModel *viewModel in _viewModelArray) {
        [viewModel resetStatus];
    }
    for (RCViewModel *viewModel in _viewModelArray) {
        [viewModel loadData];
    }
}

-(void)reloadData {
    [self setStatusLoading];
    for (RCViewModel *viewModel in _viewModelArray) {
        [viewModel resetStatus];
    }
    for (RCViewModel *viewModel in _viewModelArray) {
        [viewModel reloadData];
    }
}

-(Class)getCellClassAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataResource.count > 0 && self.dataResource.count > indexPath.section) {
        RCTableViewDataResourse *item = [self.dataResource objectAtIndex:indexPath.section];
        if (item.cellClasses.count > 0 && item.cellClasses.count > indexPath.row) {
            return [item.cellClasses objectAtIndex:indexPath.row];
        }
        return item.defaultCellClass;
    }
    return nil;
}

-(RCViewModel *)getCellViewModelAtindexPath:(NSIndexPath*)indexPath{
    if (self.dataResource.count > 0 && self.dataResource.count > indexPath.section) {
        RCTableViewDataResourse *item = [self.dataResource objectAtIndex:indexPath.section];
        if (item.cellViewModels.count > 0 && item.cellViewModels.count > indexPath.row) {
            return [item.cellViewModels objectAtIndex:indexPath.row];
        }
        return item.defaultCellViewModel;
    }
    return nil;
}
@end
