//
//  RSSpaceDetailCommentView.m
//  RealSocial
//
//  Created by kuncai on 2018/3/3.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSSpaceDetailAddCommentView.h"

@implementation RSSpaceDetailAddCommentView

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
        self.backgroundColor = [UIColor grayColor];
        
        [self addSubview:self.sendButton];
        [self addSubview:self.likeButton];
        [self addSubview:self.textField];
        
        [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(10);
            make.top.equalTo(self).with.offset(20);
        }];
        [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.likeButton);
            make.right.equalTo(self).with.offset(-10);
        }];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(20);
            make.left.equalTo(self.likeButton.mas_right).with.offset(10);
            make.right.equalTo(self.sendButton.mas_left).with.offset(-10);
            make.height.mas_equalTo(32);
        }];
    }
    return self;
}

-(UITextField *)textField {
    if (_textField) {
        return _textField;
    }
    _textField = [[UITextField alloc] init];
    _textField.font = [UIFont boldSystemFontOfSize:20];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.returnKeyType = UIReturnKeyDone;
    [_textField setClearButtonMode:UITextFieldViewModeAlways];
    _textField.delegate = self;
    _textField.placeholder = @"评论这个瞬间";
//    _textField.inputAccessoryView = self;
    return _textField;
}

-(UIButton *)sendButton {
    if (_sendButton) {
        return _sendButton;
    }
    _sendButton = [[UIButton alloc] init];
    [_sendButton setBackgroundColor:[UIColor whiteColor]];
    [_sendButton setTitle:@"send" forState:UIControlStateNormal];
    @weakify(self);
    [_sendButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull  sender) {
        @RSStrongify(self);
        self.sendButton.enabled = NO;
        if ([self.textField.text length] > 0) {
            if ([self.viewModel addComment:self.textField.text]) {
                
            } else {
                self.sendButton.enabled = YES;
            }
        } else {
            [RSUtils showTipViewWithMessage:@"评论不能为空"];
            self.sendButton.enabled = YES;
        }
    }];
    [[self.viewModel.completeSignal deliverOnMainThread] subscribeNext:^(id  _Nullable x) {
        @RSStrongify(self);
        [RSUtils showTipViewWithMessage:@"评论成功"];
        self.sendButton.enabled = YES;
    }];
    [[self.viewModel.errorSignal deliverOnMainThread] subscribeNext:^(NSError *error) {
        @RSStrongify(self);
        [RSUtils showTipViewWithMessage:[error localizedDescription]];
        self.sendButton.enabled = YES;
    }];
    return _sendButton;
}

-(UIButton *)likeButton {
    if (_likeButton) {
        return _likeButton;
    }
    _likeButton = [[UIButton alloc] init];
    [_likeButton setBackgroundColor:[UIColor whiteColor]];
    [_likeButton setTitle:@"like" forState:UIControlStateNormal];
    return _likeButton;
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
-(RSSpaceDetailAddCommentViewModel *)viewModel {
    if (_viewModel) {
        return _viewModel;
    }
    _viewModel = [[RSSpaceDetailAddCommentViewModel alloc] init];
    return _viewModel;
}
@end
