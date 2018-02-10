//
//  RSReceiverSpaceViewModel.h
//  RealSocial
//
//  Created by kuncai on 2018/2/10.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSViewModel.h"
@interface RSReceiverSpaceItemViewModel : RSViewModel
@property (nonatomic, strong) NSString *avatarUrl;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *num;
@property (nonatomic, assign) BOOL isSeleted;
@property (nonatomic, assign) long long spaceId;
@end
@interface RSReceiverSpaceViewModel : RSViewModel
@property (nonatomic, strong) NSArray *listData;
-(NSArray *)getSelectedSpaces;
@end
