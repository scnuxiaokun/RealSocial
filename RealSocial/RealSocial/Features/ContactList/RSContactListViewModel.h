//
//  RSFriendListViewModel.h
//  RealSocial
//
//  Created by kuncai on 2018/1/23.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSViewModel.h"
@interface RSContactListItemViewModel : RSViewModel
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) BOOL isSelected;
@end
@interface RSContactListViewModel : RSViewModel
@property (nonatomic, strong) NSArray *listData;
@property (nonatomic, strong) NSDictionary *selectedData;
-(void)setDefaultToUsers:(NSArray *)users;
-(NSArray *)getSelectedUsers;
@end
