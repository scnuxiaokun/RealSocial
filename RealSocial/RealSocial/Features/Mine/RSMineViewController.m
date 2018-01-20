//
//  RSMineViewController.m
//  RealSocial
//
//  Created by kuncai on 2018/1/20.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSMineViewController.h"
#import "RSLoginService.h"

@interface RSMineViewController ()
@property (nonatomic, strong) UIButton *logoutButton;
@property (nonatomic, strong) UILabel *sessionKeyLabel;
@property (nonatomic, strong) UILabel *uidLabel;
@end

@implementation RSMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"me";
    [self.view addSubview:self.uidLabel];
    [self.view addSubview:self.sessionKeyLabel];
    [self.view addSubview:self.logoutButton];
    [self.uidLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(20);
        make.top.equalTo(self.view).with.offset(kNaviBarHeightAndStatusBarHeight);
    }];
    [self.sessionKeyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(20);
        make.top.equalTo(self.uidLabel.mas_bottom).with.offset(0);
    }];
    [self.logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
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

-(UILabel *)sessionKeyLabel {
    if (_sessionKeyLabel) {
        return _sessionKeyLabel;
    }
    _sessionKeyLabel = [[UILabel alloc] init];
    _sessionKeyLabel.textColor = [UIColor greenColor];
    RAC(_sessionKeyLabel, text) = RACObserve([RSLoginService shareInstance].loginInfo, sessionKey);
    return _sessionKeyLabel;
}
-(UILabel *)uidLabel {
    if (_uidLabel) {
        return _uidLabel;
    }
    _uidLabel = [[UILabel alloc] init];
    _uidLabel.textColor = [UIColor greenColor];
    RAC(_uidLabel, text) = RACObserve([RSLoginService shareInstance].loginInfo, uid);
    return _uidLabel;
}
-(UIButton *)logoutButton {
    if (_logoutButton) {
        return _logoutButton;
    }
    _logoutButton = [[UIButton alloc] init];
    [_logoutButton setTitle:@"logout" forState:UIControlStateNormal];
    [_logoutButton setBackgroundColor:[UIColor greenColor]];
    [_logoutButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [[RSLoginService shareInstance] logout];
    }];
    return _logoutButton;
}
@end
