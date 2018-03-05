//
//  RSSpaceDetailCommentView.m
//  RealSocial
//
//  Created by kuncai on 2018/3/3.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSSpaceDetailAddCommentView.h"
@implementation RSSpaceDetailAddCommentInputAccessoryViewView
-(instancetype)init {
    self = [super init];
    if (self) {
        [self _init];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    return self;
}

-(void)_init {
    self.backgroundColor = [UIColor grayColor];
    [self addSubview:self.sendButton];
    [self addSubview:self.likeButton];
    [self addSubview:self.textField];
    
    [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.left.equalTo(self);
        make.width.height.mas_equalTo(30);
    }];
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.right.equalTo(self);
        make.width.height.mas_equalTo(30);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.likeButton.mas_right).with.offset(10);
        make.right.equalTo(self.sendButton.mas_left).with.offset(-10);
        make.height.mas_equalTo(self.textField.height);
    }];
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

-(UIButton *)sendButton {
    if (_sendButton) {
        return _sendButton;
    }
    _sendButton = [[UIButton alloc] init];
    [_sendButton setBackgroundColor:[UIColor whiteColor]];
    [_sendButton setTitle:@"send" forState:UIControlStateNormal];
    return _sendButton;
}

-(UITextField *)textField {
    if (_textField) {
        return _textField;
    }
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
    _textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 12, 0)];
    _textField.leftViewMode = UITextFieldViewModeAlways;
    _textField.font = [UIFont boldSystemFontOfSize:12];
    _textField.textColor = [UIColor whiteColor];
    _textField.backgroundColor = [UIColor clearColor];
    _textField.layer.borderColor = [UIColor whiteColor].CGColor;
    _textField.layer.borderWidth = 1;
    _textField.layer.cornerRadius = _textField.height/2;
    _textField.returnKeyType = UIReturnKeyDone;
    [_textField setClearButtonMode:UITextFieldViewModeAlways];
//    _textField.delegate = self;
    _textField.placeholder = @"评论这个瞬间";
    return _textField;
}

@end
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
        
        [self addSubview:self.contentView];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(36);
            make.left.equalTo(self).with.offset(10);
            make.right.equalTo(self).with.offset(-10);
            make.top.equalTo(self).with.offset(20);
        }];
    }
    return self;
}


-(RSSpaceDetailAddCommentInputAccessoryViewView *)contentView {
    if (_contentView) {
        return _contentView;
    }
    _contentView = [[RSSpaceDetailAddCommentInputAccessoryViewView alloc] init];
    _contentView.textField.inputAccessoryView = self.customAccessoryView;
    _contentView.textField.delegate = self;
    @weakify(self);
    [_contentView.textField addBlockForControlEvents:UIControlEventEditingChanged block:^(UITextField *textField) {
        @RSStrongify(self);
        self.customAccessoryView.textField.text = textField.text;
    }];
    [_contentView.sendButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull  sender) {
        @RSStrongify(self);
        self.contentView.sendButton.enabled = NO;
        if ([self.contentView.textField.text length] > 0) {
            if ([self.viewModel addComment:self.contentView.textField.text]) {
                
            } else {
                self.contentView.sendButton.enabled = YES;
            }
        } else {
            [RSUtils showTipViewWithMessage:@"评论不能为空"];
            self.contentView.sendButton.enabled = YES;
        }
    }];
    [[self.viewModel.completeSignal deliverOnMainThread] subscribeNext:^(id  _Nullable x) {
        @RSStrongify(self);
        [RSUtils showTipViewWithMessage:@"评论成功"];
        self.contentView.sendButton.enabled = YES;
    }];
    [[self.viewModel.errorSignal deliverOnMainThread] subscribeNext:^(NSError *error) {
        @RSStrongify(self);
        [RSUtils showTipViewWithMessage:[error localizedDescription]];
        self.contentView.sendButton.enabled = YES;
    }];
    return _contentView;
}

- (RSSpaceDetailAddCommentInputAccessoryViewView *)customAccessoryView{
    if (!_customAccessoryView) {
//        _customAccessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 40)];
        _customAccessoryView = [[RSSpaceDetailAddCommentInputAccessoryViewView alloc] initWithFrame:CGRectMake(0, 0, self.width, 40)];
        _customAccessoryView.textField.delegate = self;
        @weakify(self);
        [_customAccessoryView.sendButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull  sender) {
            @RSStrongify(self);
            self.customAccessoryView.sendButton.enabled = NO;
            if ([self.customAccessoryView.textField.text length] > 0) {
                if ([self.viewModel addComment:self.customAccessoryView.textField.text]) {
                    
                } else {
                    self.customAccessoryView.sendButton.enabled = YES;
                }
            } else {
                [RSUtils showTipViewWithMessage:@"评论不能为空"];
                self.customAccessoryView.sendButton.enabled = YES;
            }
        }];
        [[self.viewModel.completeSignal deliverOnMainThread] subscribeNext:^(id  _Nullable x) {
            @RSStrongify(self);
            [RSUtils showTipViewWithMessage:@"评论成功"];
            self.customAccessoryView.sendButton.enabled = YES;
        }];
        [[self.viewModel.errorSignal deliverOnMainThread] subscribeNext:^(NSError *error) {
            @RSStrongify(self);
            [RSUtils showTipViewWithMessage:[error localizedDescription]];
            self.customAccessoryView.sendButton.enabled = YES;
        }];
    }
    return _customAccessoryView;
}
#pragma mark textField delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    [self.customAccessoryView addSubview:self.contentView];
//    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(36);
//        make.left.equalTo(self.customAccessoryView).with.offset(10);
//        make.right.equalTo(self.customAccessoryView).with.offset(-10);
//        make.centerY.equalTo(self.customAccessoryView).with.offset(0);
//    }];
//    if (self.contentView.textField == textField) {
//        [self.contentView.textField resignFirstResponder];
//        [self.customAccessoryView.textField becomeFirstResponder];
//    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    //textField放弃第一响应者 （收起键盘）
    //键盘是textField的第一响应者
    [textField resignFirstResponder];
//    [self addSubview:self.contentView];
//    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(36);
//        make.left.equalTo(self).with.offset(10);
//        make.right.equalTo(self).with.offset(-10);
//        make.top.equalTo(self).with.offset(20);
//    }];
    return YES;
}



//- (void)textFieldDidEndEditing:(UITextField *)textField {
//    [textField resignFirstResponder];
//}

//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
//    return YES;
//}
-(RSSpaceDetailAddCommentViewModel *)viewModel {
    if (_viewModel) {
        return _viewModel;
    }
    _viewModel = [[RSSpaceDetailAddCommentViewModel alloc] init];
    return _viewModel;
}
@end
