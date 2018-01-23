//
//  RSFriendListViewModel.h
//  RealSocial
//
//  Created by kuncai on 2018/1/23.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSViewModel.h"
@interface RSFriendListViewModelItem : RSViewModel
@property (nonatomic, strong) NSString *name;
@end
@interface RSFriendListViewModel : RSViewModel
@property (nonatomic, strong) NSArray *listData;
@end
