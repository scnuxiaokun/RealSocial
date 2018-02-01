//
//  RSPictureListTableViewCell.m
//  RealSocial
//
//  Created by kuncai on 2018/2/1.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSPictureListTableViewCell.h"

@implementation RSPictureListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.pictureImageView];
        [self.contentView addSubview:self.pictureInfoLabel];
        
        [self.pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        [self.pictureInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(UIImageView *)pictureImageView {
    if (_pictureImageView) {
        return _pictureImageView;
    }
    _pictureImageView = [[UIImageView alloc] init];
    _pictureImageView.contentMode = UIViewContentModeScaleAspectFit;
    return _pictureImageView;
}

-(UILabel *)pictureInfoLabel {
    if (_pictureInfoLabel) {
        return _pictureInfoLabel;
    }
    _pictureInfoLabel = [[UILabel alloc] init];
    _pictureInfoLabel.font = [UIFont boldSystemFontOfSize:18];
    _pictureInfoLabel.textColor = [UIColor redColor];
    return _pictureInfoLabel;
}
@end
