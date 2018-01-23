//
//  RSChatTableViewCell.h
//  RealSocial
//
//  Created by kuncai on 2018/1/24.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSChatViewModel.h"
@interface RSChatTableViewCell : UITableViewCell
@property (nonatomic, strong) RSChatItemViewModel *viewModel;
@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@end
