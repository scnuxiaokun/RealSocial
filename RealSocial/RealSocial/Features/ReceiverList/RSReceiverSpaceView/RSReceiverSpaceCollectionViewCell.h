//
//  RSReceiverSpaceCollectionViewCell.h
//  RealSocial
//
//  Created by kuncai on 2018/2/10.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSReceiverSpaceViewModel.h"
#import "RSAvatarImageView.h"
@interface RSReceiverSpaceCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) RSAvatarImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) RSReceiverSpaceItemViewModel *viewModel;
@end
