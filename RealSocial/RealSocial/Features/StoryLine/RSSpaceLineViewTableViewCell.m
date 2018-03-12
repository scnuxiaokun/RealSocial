//
//  RSStoryLineViewTableViewCell.m
//  RealSocial
//
//  Created by kuncai on 2018/2/7.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSSpaceLineViewTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIView+WebCache.h>
#import <SDWebImageManager.h>
#import "RSImageDownloadService.h"

@implementation RSSpaceLineViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.x = 12;//这里间距为10，可以根据自己的情况调整
    frame.origin.y += 2;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 4;
    [super setFrame:frame];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.mediaImageView];
//        [self.contentView addSubview:self.avatarBgImageView];
        [self.contentView addSubview:self.avatarImageView];
        [self.contentView addSubview:self.titleLabel];
//        [self.contentView addSubview:self.subtitleLabel];
//
        [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).with.offset(0);
        }];
//        [self.avatarBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.center.equalTo(self.avatarImageView);
//        }];
        [self.mediaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(self.contentView);
            make.left.equalTo(self.avatarImageView.mas_centerX);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).with.offset(38);
            make.left.equalTo(self.avatarImageView.mas_right).with.offset(15);
        }];
//        [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.contentView).with.offset(-38);
//            make.left.equalTo(self.titleLabel);
//        }];
    }
    return self;
}


-(RSAvatarImageView *)avatarImageView {
    if (_avatarImageView) {
        return _avatarImageView;
    }
    _avatarImageView = [[RSAvatarImageView alloc] init];
    [_avatarImageView setType:RSAvatarImageViewType80];
    return _avatarImageView;
}

//-(UIImageView *)avatarBgImageView {
//    if (_avatarBgImageView) {
//        return _avatarBgImageView;
//    }
//    _avatarBgImageView = [[UIImageView alloc] init];
////    _avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
//    [_avatarBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.height.mas_equalTo(86);
//    }];
//    _avatarBgImageView.layer.cornerRadius = 86/2;
////    _avatarImageView.layer.masksToBounds = YES;
//    _avatarBgImageView.backgroundColor = [UIColor whiteColor];
//    return _avatarBgImageView;
//}



-(UIImageView *)mediaImageView {
    if (_mediaImageView) {
        return _mediaImageView;
    }
    _mediaImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"defaultSpaceBg"]];
    _mediaImageView.contentMode = UIViewContentModeScaleAspectFill;
    _mediaImageView.layer.cornerRadius = 10.f;
    _mediaImageView.layer.masksToBounds = YES;
    _mediaImageView.backgroundColor = [UIColor clearColor];
    [_mediaImageView sd_setIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _mediaImageViewEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    [_mediaImageView addSubview:_mediaImageViewEffectView];

    return _mediaImageView;
}

-(UILabel *)titleLabel {
    if (_titleLabel) {
        return _titleLabel;
    }
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont boldSystemFontOfSize:20];
    _titleLabel.textColor = [UIColor mainTextColor];
    return _titleLabel;
}

-(UILabel *)subtitleLabel {
    if (_subtitleLabel) {
        return _subtitleLabel;
    }
    _subtitleLabel = [[UILabel alloc] init];
    _subtitleLabel.font = [UIFont systemFontOfSize:12];
    _subtitleLabel.textColor = [UIColor mainTextColor];
    return _subtitleLabel;
}

-(void)setViewModel:(RSSpaceLineItemViewModel *)viewModel {
    _viewModel = viewModel;
//    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:viewModel.avatarUrl] placeholderImage:[UIImage imageNamed:@"defaultAvatar"]];
    NSLog(@"avatarUrls:%@", viewModel.avatarUrls);
    [self.avatarImageView setUrls:viewModel.avatarUrls];
    @weakify(self);
//    [self.mediaImageView sd_setImageWithURL:[NSURL URLWithString:viewModel.mediaUrl] placeholderImage:[UIImage imageWithColor:[UIColor grayColor]]];
    [self.mediaImageView setImage:[UIImage imageWithColor:[UIColor grayColor]]];
//    [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:viewModel.mediaUrl] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
//
//    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
//        if (!error) {
//            [self.mediaImageView setImage:image];
//        }
//    }];
    [self.mediaImageView sd_removeActivityIndicator];
    [self.mediaImageView sd_addActivityIndicator];
    [RSImageDownloadService downloadImageWithUrl:[NSURL URLWithString:viewModel.mediaUrl] completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        @RSStrongify(self);
        NSString *currentImgUrl = self.viewModel.mediaUrl;
        if (!currentImgUrl && !imageURL) {
            [self.mediaImageView sd_removeActivityIndicator];
            return;
        }
        if ([currentImgUrl isEqualToString:imageURL.absoluteString]) {
            [self.mediaImageView sd_removeActivityIndicator];
            if (!error) {
                [self.mediaImageView setImage:image];
            } else {
                NSLog(@"%@", error);
            }
        }
    }];
    self.titleLabel.text = viewModel.titleString;
    self.subtitleLabel.text = viewModel.subTitleString;
    if (viewModel.isReaded == YES) {
//        self.backgroundColor = [UIColor grayColor];
        self.titleLabel.textColor = [UIColor mainTextColor];
        self.mediaImageViewEffectView.hidden = NO;
    } else {
        self.titleLabel.textColor = [UIColor whiteColor];
        self.mediaImageViewEffectView.hidden = YES;
//        self.backgroundColor = [UIColor clearColor];
    }
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.mediaImageViewEffectView.frame = self.mediaImageView.bounds;
}
@end
