//
//  RSReceiverAvatarStackView.m
//  RealSocial
//
//  Created by kuncai on 2018/3/7.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSReceiverAvatarStackView.h"

@implementation RSReceiverAvatarStackView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)addReceiver:(NSString *)url {
    if ([self.subviews count] >= 5) {
        return;
    }
    RSAvatarImageView *avatar = [[RSAvatarImageView alloc] init];
    [avatar setUrl:url];
    [avatar setType:RSAvatarImageViewType48];
    RSAvatarImageView *lastAvatar = [[self subviews] lastObject];
    [self addSubview:avatar];
    if (lastAvatar) {
        [avatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lastAvatar.mas_right).with.offset(-10);
            make.centerY.equalTo(self);
        }];
    } else {
        [avatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.centerY.equalTo(self);
        }];
    }
}

-(void)removeReceiver:(NSString *)url {
    for (RSAvatarImageView *avatar in self.subviews) {
        if ([avatar.url isEqualToString:url]) {
            [avatar removeFromSuperview];
            break;
        }
    }
    RSAvatarImageView *lastAvatar = nil;
    for (RSAvatarImageView *avatar in self.subviews) {
        if (lastAvatar) {
            [avatar mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastAvatar.mas_right).with.offset(-10);
                make.centerY.equalTo(self);
            }];
        } else {
            [avatar mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self);
                make.centerY.equalTo(self);
            }];
        }
        lastAvatar = avatar;
    }
}

-(void)removeAllReceiver {
    for (RSAvatarImageView *avatar in self.subviews) {
        [avatar removeFromSuperview];
    }
}

@end
