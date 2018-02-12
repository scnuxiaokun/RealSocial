//
//  RSReceiverSpaceCollectionViewCell.m
//  RealSocial
//
//  Created by kuncai on 2018/2/10.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSReceiverSpaceCollectionViewCell.h"

@implementation RSReceiverSpaceCollectionViewCell
- (void)prepareForReuse {
    [super prepareForReuse];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self.contentView addSubview:self.avatarImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.numLabel];
        [self.contentView addSubview:self.selectedImageView];
        
        [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.centerX.equalTo(self.contentView);
        }];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.avatarImageView.mas_bottom);
            make.centerX.equalTo(self.contentView);
            make.left.right.equalTo(self);
        }];
        [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.numLabel.mas_bottom);
            make.centerX.equalTo(self.contentView);
        }];
        
        [self.selectedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(self.contentView);
            make.width.height.mas_equalTo(20);
//            make.right.equalTo(self.contentView).with.offset(-14);
        }];
    }
    
    return self;
}

-(RSAvatarImageView *)avatarImageView {
    if (_avatarImageView) {
        return _avatarImageView;
    }
    _avatarImageView = [[RSAvatarImageView alloc] init];
    _avatarImageView.type = RSAvatarImageViewType80;
    return _avatarImageView;
}

-(UILabel *)nameLabel {
    if (_nameLabel) {
        return _nameLabel;
    }
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.textColor = [UIColor grayColor];
    _nameLabel.font = [UIFont systemFontOfSize:12];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    return _nameLabel;
}

-(UILabel *)numLabel {
    if (_numLabel) {
        return _numLabel;
    }
    _numLabel = [[UILabel alloc] init];
    _numLabel.textColor = [UIColor grayColor];
    _numLabel.font = [UIFont systemFontOfSize:12];
    return _numLabel;
}

-(UIImageView *)selectedImageView {
    if (_selectedImageView) {
        return _selectedImageView;
    }
    _selectedImageView = [[UIImageView alloc] init];
    return _selectedImageView;
}

-(void)setViewModel:(RSReceiverSpaceItemViewModel *)viewModel {
    _viewModel = viewModel;
    if (viewModel.type == RSReceiverSpaceItemViewModelTypeNormal) {
        [self.avatarImageView setUrls:viewModel.avatarUrls];
        self.nameLabel.text = viewModel.name;
        self.numLabel.text = viewModel.num;
        if (viewModel.isSelected) {
            self.selectedImageView.image = [UIImage imageNamed:@"checkbox-selected"];
        } else {
            self.selectedImageView.image = [UIImage imageNamed:@"checkbox-nor"];
        }
    }
    if (viewModel.type == RSReceiverSpaceItemViewModelTypeAdd) {
        [self.avatarImageView setUrl:@""];
        
        self.avatarImageView.backgroundColor = [UIColor grayColor];
        self.nameLabel.text = @"创建Group";
//        self.numLabel.text = @"+";
        self.backgroundColor = [UIColor whiteColor];
    }
}
@end
