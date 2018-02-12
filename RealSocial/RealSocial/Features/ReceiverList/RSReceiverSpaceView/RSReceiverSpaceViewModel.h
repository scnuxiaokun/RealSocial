//
//  RSReceiverSpaceViewModel.h
//  RealSocial
//
//  Created by kuncai on 2018/2/10.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSViewModel.h"
typedef NS_ENUM(NSInteger, RSReceiverSpaceItemViewModelType) {
    RSReceiverSpaceItemViewModelTypeNormal,
    RSReceiverSpaceItemViewModelTypeAdd,
};
@interface RSReceiverSpaceItemViewModel : RSViewModel
@property (nonatomic, strong) NSArray *avatarUrls;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *num;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) long long spaceId;
@property (nonatomic, assign) RSReceiverSpaceItemViewModelType type;
@end
@interface RSReceiverSpaceViewModel : RSViewModel
@property (nonatomic, strong) NSArray *listData;
-(NSArray *)getSelectedSpaces;
-(RACSignal *)createGroupSpaceWithAuthors:(NSArray *)authors SpaceName:(NSString *)name;
@end
