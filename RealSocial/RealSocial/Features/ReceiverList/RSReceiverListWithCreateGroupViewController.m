//
//  RSReceiverListWithCreateGroupViewController.m
//  RealSocial
//
//  Created by kuncai on 2018/2/12.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSReceiverListWithCreateGroupViewController.h"

@interface RSReceiverListWithCreateGroupViewController ()

@end

@implementation RSReceiverListWithCreateGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.contentView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.equalTo(self.headerView).with.offset(12);
        make.left.centerY.equalTo(self.headerView.titleLabel);
        make.right.equalTo(self.finishButtonItem.mas_left).with.offset(-12);
        //        make.bottom.equalTo(self.headerView).with.offset(-12);
        make.height.mas_equalTo(30);
    }];
    @weakify(self);
    [RACObserve(self.finishButtonItem, enabled) subscribeNext:^(id  _Nullable x) {
        @RSStrongify(self);
        if (self.finishButtonItem.enabled) {
            self.headerView.titleLabel.hidden = YES;
        } else {
            self.headerView.titleLabel.hidden = NO;
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)finishButton:(id)sender {
    if (self.createGroupCompletionHandler) {
        self.createGroupCompletionHandler(self, self.textField, [self.viewModel getSelectedUsers]);
        //            self.completionHandler(self, [self.viewModel getSelectedUsers], [self.spaceView.viewModel getSelectedSpaces]);
//        self.spaceCompletionHandler(self, [self.viewModel getSelectedUsers], [self.spaceView.viewModel getSelectedSpaces]);
    }
//    [self.navigationController popViewControllerAnimated:YES];
}

-(UITextField *)textField {
    if (_textField) {
        return _textField;
    }
    _textField = [[UITextField alloc] init];
    _textField.hidden = YES;
    _textField.font = [UIFont boldSystemFontOfSize:20];
    _textField.backgroundColor = [UIColor clearColor];
    _textField.returnKeyType = UIReturnKeyDone;
    [_textField setClearButtonMode:UITextFieldViewModeAlways];
    _textField.delegate = self;
    _textField.placeholder = @"输入圈子名称";
    @weakify(self);
    [RACObserve(self.finishButtonItem, enabled) subscribeNext:^(id  _Nullable x) {
        @RSStrongify(self);
        if (self.finishButtonItem.enabled) {
            self.textField.hidden = NO;
        } else {
            self.textField.hidden = YES;
        }
    }];
    return _textField;
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
