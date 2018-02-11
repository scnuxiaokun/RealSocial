//
//  RSReceiverListTableViewCell.h
//  RealSocial
//
//  Created by kuncai on 2018/2/11.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSAvatarImageView.h"
#import "RSReceiverListViewModel.h"
@interface RSReceiverListTableViewCell : UITableViewCell
@property (nonatomic, strong ) RSAvatarImageView *avatarImageView;
@property (nonatomic, strong ) UILabel *nickLabel;
@property (nonatomic, strong ) RSReceiverListItemViewModel *viewModel;
@end
