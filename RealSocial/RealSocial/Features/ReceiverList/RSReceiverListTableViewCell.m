//
//  RSReceiverListTableViewCell.m
//  RealSocial
//
//  Created by kuncai on 2018/2/11.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSReceiverListTableViewCell.h"

@implementation RSReceiverListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.avatarImageView];
        [self.contentView addSubview:self.nickLabel];
        [self.contentView addSubview:self.selectedImageView];
        [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).with.offset(12);
            make.centerY.equalTo(self.contentView);
        }];
        [self.nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.avatarImageView.mas_right).with.offset(12);
            make.centerY.equalTo(self.contentView);
        }];
        [self.selectedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).with.offset(-14);
            make.width.height.mas_equalTo(20);
        }];
    }
    return self;
}

-(RSAvatarImageView *)avatarImageView {
    if (_avatarImageView) {
        return _avatarImageView;
    }
    _avatarImageView = [[RSAvatarImageView alloc] init];
    _avatarImageView.type = RSAvatarImageViewType48;
    return _avatarImageView;
}

-(UILabel *)nickLabel {
    if (_nickLabel) {
        return _nickLabel;
    }
    _nickLabel = [[UILabel alloc] init];
    _nickLabel.font = [UIFont systemFontOfSize:17];
    return _nickLabel;
}

-(UIImageView *)selectedImageView {
    if (_selectedImageView) {
        return _selectedImageView;
    }
    _selectedImageView = [[UIImageView alloc] init];
    return _selectedImageView;
}

-(void)setViewModel:(RSReceiverListItemViewModel *)viewModel {
    _viewModel = viewModel;
    [self.avatarImageView setUrl:viewModel.avatarUrl];
    self.nickLabel.text = viewModel.name;
    if (viewModel.isSelected) {
        self.selectedImageView.image = [UIImage imageNamed:@"checkbox-selected"];
    } else {
        self.selectedImageView.image = [UIImage imageNamed:@"checkbox-nor"];
    }
}
@end
