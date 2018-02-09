//
//  RSSubUIViewController.m
//  RealSocial
//
//  Created by kuncai on 2018/2/8.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSSubUIViewController.h"

@interface RSSubUIViewController ()

@end

@implementation RSSubUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.transitionController prepareGestureRecognizerInViewController:self];
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(kNaviBarHeightAndStatusBarHeight);
    }];
    self.contentView.frame = CGRectMake(kNaviBarHeightAndStatusBarHeight, 0, self.view.width, self.view.height);
    
//    UIButton *button = [[UIButton alloc] init];
//    [self.contentView addSubview:button];
//    [button setTitle:@"test" forState:UIControlStateNormal];
//    [button setBackgroundColor:[UIColor randomColor]];
//    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.contentView);
//        make.width.height.mas_equalTo(200);
//    }];
//    @weakify(self);
//    [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
//        @RSStrongify(self);
//        RSSubUIViewController *ctr = [[RSSubUIViewController alloc] init];
//        [self.navigationController pushViewController:ctr animated:YES];
//    }];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //导航透明
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationItem setHidesBackButton:YES];
    
    //隐藏返回
    [self.navigationController.navigationItem setHidesBackButton:YES];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController.navigationBar.backItem setHidesBackButton:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self.navigationController.navigationItem setHidesBackButton:NO];
//    self.navigationController.navigationBar.translucent = YES;
//    [self.navigationController.navigationBar setShadowImage:nil];
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//
//    [self.navigationController.navigationItem setHidesBackButton:NO];
//    [self.navigationItem setHidesBackButton:NO];
//    [self.navigationController.navigationBar.backItem setHidesBackButton:NO];
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
-(UIView *)contentView {
    if (_contentView) {
        return _contentView;
    }
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor whiteColor];
    return _contentView;
}
@end
