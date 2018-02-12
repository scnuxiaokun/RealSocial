//
//  RSReceiverHeader.m
//  RealSocial
//
//  Created by kuncai on 2018/2/10.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSReceiverHeaderView.h"

@implementation RSReceiverHeaderView

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
        self.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.titleLabel];
        [self addSubview:self.subTitleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(12);
            make.top.equalTo(self).with.offset(40);
        }];
        [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel);
            make.top.equalTo(self.titleLabel.mas_bottom).with.offset(2);
        }];
    }
    return self;
}

-(UILabel *)titleLabel {
    if (_titleLabel) {
        return _titleLabel;
    }
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont boldSystemFontOfSize:20];
    return _titleLabel;
}

-(UILabel *)subTitleLabel {
    if (_subTitleLabel) {
        return _subTitleLabel;
    }
    _subTitleLabel = [[UILabel alloc] init];
    _subTitleLabel.font = [UIFont systemFontOfSize:14];
    _subTitleLabel.textColor = [UIColor grayColor];
    return _subTitleLabel;
}

@end
