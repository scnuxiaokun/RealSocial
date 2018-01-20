//
//  SYBContainerViewModel.h
//  SybPlatform
//
//  Created by kuncai on 15/4/3.
//  Copyright (c) 2015年 Tencent. All rights reserved.
//

#import "RCViewModel.h"
#import "RCTableViewDataResourse.h"
@interface RCContainerViewModel : RCViewModel
typedef enum
{
    RCContainerViewModelLoadDataStyleAsynchronization,
    RCContainerViewModelLoadDataStyleSynchronization,
    
} RCContainerViewModelLoadDataStyle;
@property (nonatomic, retain) NSMutableArray *viewModelArray;
@property (nonatomic, assign) RCContainerViewModelLoadDataStyle loadDataStyle;
@property (nonatomic, strong) NSArray *dataResource;
-(void)addItemViewModel:(RCViewModel *)viewModel;
- (NSArray *)configDataResource;
-(Class)getCellClassAtIndexPath:(NSIndexPath *)indexPath;
-(RCViewModel *)getCellViewModelAtindexPath:(NSIndexPath*)indexPath;
@end