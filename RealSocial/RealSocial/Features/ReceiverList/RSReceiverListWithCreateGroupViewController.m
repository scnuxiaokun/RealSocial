//
//  RSReceiverListWithCreateGroupViewController.m
//  RealSocial
//
//  Created by kuncai on 2018/2/12.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSReceiverListWithCreateGroupViewController.h"
#import "RSReceiverCteateGroupFormView.h"
@interface RSReceiverListWithCreateGroupViewController ()
@property (nonatomic, strong) RSReceiverCteateGroupFormView *createGroupFormView;
@end

@implementation RSReceiverListWithCreateGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.contentView addSubview:self.textField];
//    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
//        //        make.left.equalTo(self.headerView).with.offset(12);
//        make.left.centerY.equalTo(self.headerView.titleLabel);
//        make.right.equalTo(self.finishButtonItem.mas_left).with.offset(-12);
//        //        make.bottom.equalTo(self.headerView).with.offset(-12);
//        make.height.mas_equalTo(30);
//    }];
//    @weakify(self);
//    [RACObserve(self.finishButtonItem, enabled) subscribeNext:^(id  _Nullable x) {
//        @RSStrongify(self);
//        if (self.finishButtonItem.enabled) {
//            self.headerView.titleLabel.hidden = YES;
//        } else {
//            self.headerView.titleLabel.hidden = NO;
//        }
//    }];
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
    [self.view addSubview:self.createGroupFormView];
    [self.createGroupFormView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.createGroupFormView.avatarContentView removeAllReceiver];
    for (RSAvatarImageView *avatar in self.bottomOperationBar.avatarContentView.subviews) {
        [self.createGroupFormView.avatarContentView addReceiver:avatar.url];
    }
}

//-(UITextField *)textField {
//    if (_textField) {
//        return _textField;
//    }
//    _textField = [[UITextField alloc] init];
//    _textField.hidden = YES;
//    _textField.font = [UIFont boldSystemFontOfSize:20];
//    _textField.backgroundColor = [UIColor clearColor];
//    _textField.returnKeyType = UIReturnKeyDone;
//    [_textField setClearButtonMode:UITextFieldViewModeAlways];
//    _textField.delegate = self;
//    _textField.placeholder = @"输入圈子名称";
//    @weakify(self);
//    [RACObserve(self.finishButtonItem, enabled) subscribeNext:^(id  _Nullable x) {
//        @RSStrongify(self);
//        if (self.finishButtonItem.enabled) {
//            self.textField.hidden = NO;
//        } else {
//            self.textField.hidden = YES;
//        }
//    }];
//    return _textField;
//}

-(RSReceiverCteateGroupFormView *)createGroupFormView {
    if (_createGroupFormView) {
        return _createGroupFormView;
    }
    _createGroupFormView = [[RSReceiverCteateGroupFormView alloc] init];
    @weakify(self);
    [_createGroupFormView.createButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        @RSStrongify(self);
        if (self.createGroupCompletionHandler) {
            self.createGroupCompletionHandler(self, self.createGroupFormView.textField, [self.viewModel getSelectedUsers]);
        }
    }];
    return _createGroupFormView;
}

@end
