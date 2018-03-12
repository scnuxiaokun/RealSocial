//
//  RSSpaceCreateCameraViewController.m
//  RealSocial
//
//  Created by kuncai on 2018/3/9.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSSpaceCreateCameraViewController.h"

@interface RSSpaceCreateCameraViewController ()

@end

@implementation RSSpaceCreateCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    UIView *coverView = [[UIView alloc] init];
    coverView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:coverView];
    [self.view sendSubviewToBack:coverView];
    [coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(200);
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

@end
