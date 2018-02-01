//
//  RSPictureListViewModel.h
//  RealSocial
//
//  Created by kuncai on 2018/2/1.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSViewModel.h"
#import "RSPictureListItemViewModel.h"

@interface RSPictureListViewModel : RSViewModel
@property (nonatomic, strong) NSArray<RSPictureListItemViewModel *> *listData;
@end
