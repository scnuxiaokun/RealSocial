//
//  RSChatTableViewCell.m
//  RealSocial
//
//  Created by kuncai on 2018/1/24.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSChatTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation RSChatTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.avatarView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.detailLabel];
        [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView);
            make.width.height.mas_equalTo(40);
        }];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.avatarView.mas_right).with.offset(10);
        }];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.top.equalTo(self.nameLabel.mas_bottom);
            make.bottom.right.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setViewModel:(RSChatItemViewModel *)viewModel {
    _viewModel = viewModel;
    [self.avatarView sd_setImageWithURL:[NSURL URLWithString:viewModel.iconUrl]];
    self.nameLabel.text = viewModel.name;
    self.detailLabel.text = viewModel.text;
}

-(UIImageView *)avatarView {
    if (_avatarView) {
        return _avatarView;
    }
    _avatarView = [[UIImageView alloc] init];
    return _avatarView;
}

-(UILabel *)nameLabel {
    if (_nameLabel) {
        return _nameLabel;
    }
    _nameLabel = [[UILabel alloc] init];
    return _nameLabel;
}

-(UILabel *)detailLabel {
    if (_detailLabel) {
        return _detailLabel;
    }
    _detailLabel = [[UILabel alloc] init];
    return _detailLabel;
}
@end
