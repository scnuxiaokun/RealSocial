//
//  RSReceiverCteateGroupFormView.m
//  RealSocial
//
//  Created by kuncai on 2018/3/7.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSReceiverCteateGroupFormView.h"

@implementation RSReceiverCteateGroupFormView

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
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [self addSubview:self.contentView];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(462);
            make.left.right.bottom.equalTo(self);
        }];
    }
    return self;
}

-(UIView *)contentView {
    if (_contentView) {
        return _contentView;
    }
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor main1];
    [_contentView addSubview:self.avatarContentView];
    [_contentView addSubview:self.textFieldTitleLabel];
    [_contentView addSubview:self.textField];
    [_contentView addSubview:self.createButton];
    [self.avatarContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contentView).with.offset(20);
        make.right.equalTo(_contentView).with.offset(-20);
        make.top.equalTo(_contentView).with.offset(32);
        make.height.mas_equalTo(48);
    }];
    [self.textFieldTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarContentView);
        make.top.equalTo(self.avatarContentView.mas_bottom).with.offset(12);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarContentView);
        make.top.equalTo(self.textFieldTitleLabel.mas_bottom).with.offset(12);
    }];
    [self.createButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_contentView);
        make.bottom.equalTo(_contentView);
    }];
    return _contentView;
}

-(RSReceiverAvatarStackView *)avatarContentView {
    if (_avatarContentView) {
        return _avatarContentView;
    }
    _avatarContentView = [[RSReceiverAvatarStackView alloc] init];
    return _avatarContentView;
}

-(UILabel *)textFieldTitleLabel {
    if (_textFieldTitleLabel) {
        return _textFieldTitleLabel;
    }
    _textFieldTitleLabel = [[UILabel alloc] init];
    _textFieldTitleLabel.text = @"圈子名称";
    _textFieldTitleLabel.textColor = [UIColor grayColor];
    _textFieldTitleLabel.font = [UIFont systemFontOfSize:12];
    return _textFieldTitleLabel;
}

-(UITextField *)textField {
    if (_textField) {
        return _textField;
    }
    _textField = [[UITextField alloc] init];
    _textField.font = [UIFont boldSystemFontOfSize:20];
    _textField.backgroundColor = [UIColor clearColor];
    _textField.returnKeyType = UIReturnKeyDone;
    [_textField setClearButtonMode:UITextFieldViewModeAlways];
    _textField.delegate = self;
    _textField.placeholder = @"输入圈子名称";
    return _textField;
}

-(UIButton *)createButton {
    if (_createButton) {
        return _createButton;
    }
    _createButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    _createButton.layer.cornerRadius = _createButton.width/2;
    [_createButton setBackgroundColor:[UIColor whiteColor]];
    [_createButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(_createButton.height);
    }];
    //    [button setTitle:@"完成" forState:UIControlStateNormal];
//    [_createButton setImage:[UIImage imageNamed:@"btn-confirm-nor"] forState:UIControlStateDisabled];
//    [_createButton setImage:[UIImage imageNamed:@"btn-confirm-hl"] forState:UIControlStateNormal];
    return _createButton;
}

#pragma mark textField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    //textField放弃第一响应者 （收起键盘）
    //键盘是textField的第一响应者
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return YES;
}
@end
