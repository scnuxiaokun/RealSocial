//
//  RSLoginViewController.m
//  RealSocial
//
//  Created by kuncai on 2018/1/20.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSLoginViewController.h"
#import "WXApiService.h"
#import "MBProgressHUD.h"

@interface RSLoginViewController ()
@property (nonatomic, strong) UIButton *wxLoginButtom;
@property (nonatomic, strong) MBProgressHUD *progressHud;
@end

@implementation RSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Login";
    [self.view addSubview:self.wxLoginButtom];
    [self.wxLoginButtom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    self.progressHud = [RSUtils loadingViewWithMessage:@"登录中..." inView:self.view];
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

-(UIButton *)wxLoginButtom {
    if (_wxLoginButtom) {
        return _wxLoginButtom;
    }
    _wxLoginButtom = [[UIButton alloc] init];
    [_wxLoginButtom setTitle:@"weixin login" forState:UIControlStateNormal];
    [_wxLoginButtom setBackgroundColor:[UIColor greenColor]];
    @weakify(self);
    [_wxLoginButtom addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        @RSStrongify(self);
        @weakify(self);
        [[[[WXApiService shareInstance] login:self] deliverOnMainThread] subscribeNext:^(id  _Nullable x) {
            @RSStrongify(self);
            [self.progressHud showAnimated:YES];
        } error:^(NSError * _Nullable error) {
            @RSStrongify(self);
            [self.progressHud hideAnimated:YES];
            [RSUtils showTipViewWithMessage:[error localizedDescription]];
        } completed:^{
            @RSStrongify(self);
            [self.progressHud hideAnimated:YES];
            [RSUtils showTipViewWithMessage:WXloginSuccessTips];
        }];
    }];
    return _wxLoginButtom;
}
@end
