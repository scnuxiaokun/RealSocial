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
        self.backgroundColor = RGBA(245, 245, 245, 0.9);
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.textFieldImageView];
        [self addSubview:self.textField];
//        [self addSubview:self.subTitleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(12);
            make.top.equalTo(self).with.offset(30);
        }];
        [self.textFieldImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel);
            make.width.height.mas_equalTo(20);
            make.top.equalTo(self.titleLabel.mas_bottom).with.offset(16);
        }];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.textFieldImageView.mas_right).with.offset(5);
            make.centerY.equalTo(self.textFieldImageView);
            make.right.equalTo(self);
        }];
//        [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.titleLabel);
//            make.top.equalTo(self.titleLabel.mas_bottom).with.offset(2);
//        }];
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

-(UIImageView *)textFieldImageView {
    if (_textFieldImageView) {
        return _textFieldImageView;
    }
    _textFieldImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:[UIColor randomColor]]];
    return _textFieldImageView;
}

-(UITextField *)textField {
    if (_textField) {
        return _textField;
    }
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 0, 20)];
    _textField.font = [UIFont boldSystemFontOfSize:14];
    _textField.textColor = [UIColor grayColor];
    _textField.backgroundColor = [UIColor clearColor];
//    _textField.layer.borderColor = [UIColor whiteColor].CGColor;
//    _textField.layer.borderWidth = 1;
//    _textField.layer.cornerRadius = _textField.height/2;
    _textField.returnKeyType = UIReturnKeySearch;
//    [_textField setClearButtonMode:UITextFieldViewModeAlways];
    //    _textField.delegate = self;
    _textField.placeholder = @"搜索好友";
    return _textField;
}

//-(UILabel *)subTitleLabel {
//    if (_subTitleLabel) {
//        return _subTitleLabel;
//    }
//    _subTitleLabel = [[UILabel alloc] init];
//    _subTitleLabel.font = [UIFont systemFontOfSize:14];
//    _subTitleLabel.textColor = [UIColor grayColor];
//    return _subTitleLabel;
//}

@end
