//
//  RSStoryLineViewTableViewCell.h
//  RealSocial
//
//  Created by kuncai on 2018/2/7.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSpaceLineViewModel.h"
#import "RSAvatarImageView.h"
@class RSSpaceLineViewTableViewCell;
typedef void (^RSSpaceLineViewTableViewCellCompletionHandler)(RSSpaceLineViewTableViewCell *cell);
@interface RSSpaceLineViewTableViewCell : UITableViewCell
@property (nonatomic, strong) RSAvatarImageView *avatarImageView;
//@property (nonatomic, strong) UIImageView *avatarBgImageView;
@property (nonatomic, strong) UIImageView *mediaImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) RSSpaceLineItemViewModel *viewModel;
@property (nonatomic, copy) RSSpaceLineViewTableViewCellCompletionHandler completionHanldler;
@end
