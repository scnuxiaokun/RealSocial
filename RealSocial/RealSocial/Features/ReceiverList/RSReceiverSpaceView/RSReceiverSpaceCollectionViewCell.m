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
        
        [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.centerX.equalTo(self.contentView);
        }];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.avatarImageView.mas_bottom);
            make.centerX.equalTo(self.contentView);
        }];
        [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.numLabel.mas_bottom);
            make.centerX.equalTo(self.contentView);
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

-(void)setViewModel:(RSReceiverSpaceItemViewModel *)viewModel {
    _viewModel = viewModel;
    if (viewModel.type == RSReceiverSpaceItemViewModelTypeNormal) {
        self.avatarImageView.url = viewModel.avatarUrl;
        self.nameLabel.text = viewModel.name;
        self.numLabel.text = viewModel.num;
        if (viewModel.isSeleted) {
            self.backgroundColor = [UIColor blueColor];
        } else {
            self.backgroundColor = [UIColor whiteColor];
        }
    }
    if (viewModel.type == RSReceiverSpaceItemViewModelTypeAdd) {
        self.avatarImageView.url = @"";
        self.avatarImageView.backgroundColor = [UIColor yellowColor];
        self.numLabel.text = @"+";
        self.backgroundColor = [UIColor whiteColor];
    }
}
@end
