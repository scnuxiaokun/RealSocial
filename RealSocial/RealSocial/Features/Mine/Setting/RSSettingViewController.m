//
//  RSSettingViewController.m
//  RealSocial
//
//  Created by 蒋陈浩 on 2018/3/12.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSSettingViewController.h"
#import "RSLoginService.h"
@interface RSSettingViewController ()
@property (nonatomic, strong) UIButton *loginOut;
@end

@implementation RSSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentView.backgroundColor = [UIColor main1];
    [self.contentView addSubview:self.loginOut];
    // Do any additional setup after loading the view.
}
-(UIButton *)loginOut{
    if (!_loginOut) {
        _loginOut = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 80, 50)];
        [_loginOut setTitle:@"退出登录" forState:(UIControlStateNormal)];
        [_loginOut setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_loginOut addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [[RSLoginService shareInstance] logout];
        }];
    }
    return _loginOut;
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

@end
