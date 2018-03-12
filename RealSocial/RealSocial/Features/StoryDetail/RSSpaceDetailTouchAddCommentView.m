//
//  RSSpaceDetailTouchAddCommentView.m
//  RealSocial
//
//  Created by kuncai on 2018/3/10.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSSpaceDetailTouchAddCommentView.h"
#import "RSLoginService.h"
#import "RSContactService.h"

@implementation RSSpaceDetailTouchAddCommentView

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
        [self addSubview:self.avatarImageView];
        [self addSubview:self.textField];
        
        [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.centerY.equalTo(self);
        }];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.avatarImageView.mas_right);
            make.centerY.equalTo(self);
            make.height.mas_equalTo(self.textField.height);
        }];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.avatarImageView.height);
            make.width.mas_equalTo(100);
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
    _avatarImageView.url = [[RSContactService shareInstance] getMyAvatarUrl];
    return _avatarImageView;
}

-(UITextField *)textField {
    if (_textField) {
        return _textField;
    }
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 0, 48)];
    _textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 12, 0)];
    _textField.leftViewMode = UITextFieldViewModeAlways;
    _textField.font = [UIFont boldSystemFontOfSize:14];
    _textField.textColor = [UIColor whiteColor];
    _textField.backgroundColor = [UIColor clearColor];
    _textField.layer.borderColor = [UIColor whiteColor].CGColor;
    _textField.layer.borderWidth = 1;
    _textField.layer.cornerRadius = _textField.height/2;
    _textField.returnKeyType = UIReturnKeyDone;
    [_textField setClearButtonMode:UITextFieldViewModeAlways];
    //    _textField.delegate = self;
    _textField.placeholder = @"评论这个瞬间";
    _textField.delegate = self;
    return _textField;
}

-(RSSpaceDetailAddCommentViewModel *)viewModel {
    if (_viewModel) {
        return _viewModel;
    }
    _viewModel = [[RSSpaceDetailAddCommentViewModel alloc] init];
    return _viewModel;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    //textField放弃第一响应者 （收起键盘）
    //键盘是textField的第一响应者
    [textField resignFirstResponder];
    if ([textField.text length] > 0) {
        if (![self.viewModel addComment:textField.text]) {
            [RSUtils showTipViewWithMessage:@"评论失败"];
        }
    } else {
        [RSUtils showTipViewWithMessage:@"评论不能为空"];
    }
    return YES;
}
@end
