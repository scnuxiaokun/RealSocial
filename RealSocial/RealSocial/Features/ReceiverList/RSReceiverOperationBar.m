//
//  RSReceiverOperationBar.m
//  RealSocial
//
//  Created by kuncai on 2018/3/6.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSReceiverOperationBar.h"

@implementation RSReceiverOperationBar

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
        self.backgroundColor = [UIColor main1];
        [self addSubview:self.sendButton];
        [self addSubview:self.label];
        [self addSubview:self.avatarContentView];
        
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(20);
            make.top.equalTo(self).with.offset(26);
        }];
        [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(40);
            make.top.equalTo(self).with.offset(14);
            make.right.equalTo(self).with.offset(-20);
        }];
        [self.avatarContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(20);
            make.top.equalTo(self).with.offset(14);
            make.right.equalTo(self.sendButton.mas_left);
            make.height.mas_equalTo(48);
        }];
    }
    return self;
}

-(UIButton *)sendButton {
    if (_sendButton) {
        return _sendButton;
    }
    _sendButton = [[UIButton alloc] init];
    //    [button setEnabled:NO];
    [_sendButton setBackgroundColor:[UIColor clearColor]];
//    [_sendButton setTitle:@"完成" forState:UIControlStateNormal];
    [_sendButton setImage:[UIImage imageNamed:@"btn-confirm-nor"] forState:UIControlStateDisabled];
    [_sendButton setImage:[UIImage imageNamed:@"btn-confirm-hl"] forState:UIControlStateNormal];
    return _sendButton;
}

-(UILabel *)label {
    if (_label) {
        return _label;
    }
    _label = [[UILabel alloc] init];
    _label.font = [UIFont systemFontOfSize:14];
    _label.textColor = [UIColor grayColor];
    return _label;
}

-(RSReceiverAvatarStackView *)avatarContentView {
    if (_avatarContentView) {
        return _avatarContentView;
    }
    _avatarContentView = [[RSReceiverAvatarStackView alloc] init];
    return _avatarContentView;
}

//-(void)addReceiver:(RSReceiverListItemViewModel *)item {
//    if ([self.avatarContentView.subviews count] >= 5) {
//        return;
//    }
//    RSAvatarImageView *avatar = [[RSAvatarImageView alloc] init];
//    [avatar setUrl:item.avatarUrl];
//    [avatar setType:RSAvatarImageViewType48];
//    RSAvatarImageView *lastAvatar = [[self.avatarContentView subviews] lastObject];
//    [self.avatarContentView addSubview:avatar];
//    if (lastAvatar) {
//        [avatar mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(lastAvatar.mas_right).with.offset(-10);
//            make.centerY.equalTo(self.avatarContentView);
//        }];
//    } else {
//        [avatar mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.avatarContentView);
//            make.centerY.equalTo(self.avatarContentView);
//        }];
//    }
//}
//
//-(void)removeReceiver:(RSReceiverListItemViewModel *)item {
//    for (RSAvatarImageView *avatar in self.avatarContentView.subviews) {
//        if ([avatar.url isEqualToString:item.avatarUrl]) {
//            [avatar removeFromSuperview];
//            break;
//        }
//    }
//    RSAvatarImageView *lastAvatar = nil;
//    for (RSAvatarImageView *avatar in self.avatarContentView.subviews) {
//        if (lastAvatar) {
//            [avatar mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(lastAvatar.mas_right).with.offset(-10);
//                make.centerY.equalTo(self.avatarContentView);
//            }];
//        } else {
//            [avatar mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(self.avatarContentView);
//                make.centerY.equalTo(self.avatarContentView);
//            }];
//        }
//        lastAvatar = avatar;
//    }
//}
//
//-(void)removeAllReceiver {
//    for (RSAvatarImageView *avatar in self.avatarContentView.subviews) {
//        [avatar removeFromSuperview];
//    }
//}
@end
