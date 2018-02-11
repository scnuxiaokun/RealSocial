//
//  RSFriendListViewModel.h
//  RealSocial
//
//  Created by kuncai on 2018/1/23.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSViewModel.h"
@interface RSReceiverListItemViewModel : RSViewModel
@property (nonatomic, strong) NSString *avatarUrl;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, assign) BOOL isSelected;
@end
@interface RSReceiverListViewModel : RSViewModel
@property (nonatomic, strong) NSArray *listData;
@property (nonatomic, strong) NSDictionary *selectedData;
-(void)setDefaultToUsers:(NSArray *)users;
-(NSArray *)getSelectedUsers;
@end
