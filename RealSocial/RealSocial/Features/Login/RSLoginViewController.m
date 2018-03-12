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
@property (nonatomic, strong) UIView *circleOne;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *circleTwo;
@property (nonatomic, strong) UIButton *wxLoginButtom;
@property (nonatomic, strong) UILabel *wxLable;
@property (nonatomic, strong) UILabel *agreeLable;
@property (nonatomic, strong) MBProgressHUD *progressHud;
@end

@implementation RSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(245, 245, 245);
    self.title = @"Login";
    
    [self.view addSubview:self.circleOne];
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.circleTwo];
    [self.view addSubview:self.wxLoginButtom];
    [self.view addSubview:self.wxLable];
    [self.view addSubview:self.agreeLable];
    
    
    [self.circleOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(119/812.0f*SCREEN_HEIGHT);
        make.left.equalTo(self.view).offset(111/375.0f*SCREEN_WIDTH);
        make.height.mas_equalTo(114);
        make.width.mas_equalTo(114);
    }];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.circleOne).offset(57);
        make.left.equalTo(self.circleOne).offset(57);
        make.height.mas_equalTo(130);
        make.width.mas_equalTo(130);
    }];
    
    [self.circleTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.bgView);
        make.height.mas_equalTo(114);
        make.width.mas_equalTo(114);
    }];
    
    [self.wxLoginButtom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-182);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(80);
        make.width.mas_equalTo(80);
    }];
    
    [self.wxLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-161);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(17);
        make.width.mas_equalTo(48);
    }];
    
    [self.agreeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-44);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(17);
        make.width.mas_equalTo(168);
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

-(UIView *)circleOne{
    if (!_circleOne) {
        _circleOne = [[UIView alloc] init];
        _circleOne.layer.cornerRadius = 57.0f;
        _circleOne.layer.masksToBounds = YES;
        _circleOne.layer.borderWidth = 4;
        _circleOne.layer.borderColor = [RGB(9, 19, 79) CGColor];
    }
    return _circleOne;
}

-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = RGB(245, 245, 245);
    }
    return _bgView;
}

-(UIView *)circleTwo{
    if (!_circleTwo) {
        _circleTwo = [[UIView alloc] init];
        _circleTwo.layer.cornerRadius = 57.0f;
        _circleTwo.layer.masksToBounds = YES;
        _circleTwo.layer.borderWidth = 4;
        _circleTwo.layer.borderColor = [RGB(9, 10, 70) CGColor];
    }
    return _circleTwo;
}

-(UIButton *)wxLoginButtom {
    if (_wxLoginButtom) {
        return _wxLoginButtom;
    }
    _wxLoginButtom = [[UIButton alloc] init];
    [_wxLoginButtom setImage:[UIImage imageNamed:@"btn-login-wechat"] forState:UIControlStateNormal];
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
-(UILabel *)wxLable{
    if (!_wxLable) {
        _wxLable = [[UILabel alloc] init];
        _wxLable.text = @"微信登录";
        _wxLable.textAlignment = NSTextAlignmentCenter;
        _wxLable.textColor = RGB(9, 10, 70);
        _wxLable.font = [UIFont fontWithName:@"PingFang-SC-Semibold" size:12];
    }
    return _wxLable;
}

-(UILabel *)agreeLable{
    if (!_agreeLable) {
        _agreeLable = [[UILabel alloc] init];
        _agreeLable.text = @"登录即代表你同意《用户协议》";
        _agreeLable.textAlignment = NSTextAlignmentCenter;
        _agreeLable.textColor = RGBA(9, 10, 70, .2f);
        _agreeLable.font = [UIFont fontWithName:@"PingFang-SC-Semibold" size:12];
    }
    return _agreeLable;
}



@end

