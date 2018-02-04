//
//  RSPictureListTableViewCell.h
//  RealSocial
//
//  Created by kuncai on 2018/2/1.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSPictureListItemViewModel.h"
@interface RSPictureListTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *pictureImageView;
@property (nonatomic, strong) UILabel *pictureInfoLabel;
@property (nonatomic, strong) RSPictureListItemViewModel *viewModel;
@end
