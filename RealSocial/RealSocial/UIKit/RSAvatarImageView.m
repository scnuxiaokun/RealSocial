//
//  RSAvatarImageView.m
//  RealSocial
//
//  Created by kuncai on 2018/2/10.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSAvatarImageView.h"
#import <UIImageView+WebCache.h>

@implementation RSAvatarImageView {
    RSAvatarImageView *_oneAvatar;
    RSAvatarImageView *_twoAvatar;
    CAShapeLayer *_maskLayer;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init {
    self = [super init];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"defaultAvatar"]];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.equalTo(self).with.offset(-2);
            make.height.equalTo(self).with.offset(-2);
        }];
//        self.image = [UIImage imageNamed:@"defaultAvatar"];
//        _bgView = [[UIView alloc] init];
//        _bgView.backgroundColor = [UIColor whiteColor];
//        [self addSubview:_bgView];
//        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.center.equalTo(self);
//            make.width.equalTo(self).with.offset(5);
//            make.height.equalTo(self).with.offset(5);
//        }];
//        [self sendSubviewToBack:_bgView];
        
    }
    return self;
}

-(void)setUrl:(NSString *)url {
    _url = url;
    [_oneAvatar removeFromSuperview];
    [_twoAvatar removeFromSuperview];
    self.imageView.hidden = NO;
    self.backgroundColor = [UIColor whiteColor];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"defaultAvatar"]];
}

-(void)setUrls:(NSArray *)urls {
    if ([urls count] > 1 ) {
        NSString *oneUrl = [urls firstObject];
        NSString *twoUrl = [urls lastObject];
        if (oneUrl) {
            if (!_oneAvatar) {
                _oneAvatar = [[RSAvatarImageView alloc] init];
                [_oneAvatar setType:RSAvatarImageViewType48];
            }
            [_oneAvatar setUrl:oneUrl];
            [self addSubview:_oneAvatar];
            [_oneAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.equalTo(self);
            }];
        }
        if (twoUrl) {
            if (!_twoAvatar) {
                _twoAvatar = [[RSAvatarImageView alloc] init];
                [_twoAvatar setType:RSAvatarImageViewType48];
            }
            [_twoAvatar setUrl:twoUrl];
            [self addSubview:_twoAvatar];
            [_twoAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.right.equalTo(self);
            }];
        }
        self.imageView.hidden = YES;
        self.backgroundColor = [UIColor clearColor];
        return;
    }
    NSString *oneUrl = [urls firstObject];
    if (oneUrl) {
        [self setUrl:oneUrl];
    }
    
}

-(void)setType:(RSAvatarImageViewType)type {
    _type = type;
    CGFloat width=0;
    
    switch (type) {
        case RSAvatarImageViewType48:
            width=48;
            break;
        case RSAvatarImageViewType80:
            width=80;
            break;
            
        default:
            break;
    }
    self.width = self.height = width;
    self.imageView.layer.cornerRadius = (self.width-2)/2;
    self.imageView.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.width/2;
//    self.layer.masksToBounds = YES;
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(width);
    }];
}
@end
