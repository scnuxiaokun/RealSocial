//
//  RSLanchViewController.m
//  RealSocial
//
//  Created by kuncai on 2018/1/20.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSLanchViewController.h"
#import "RSAvatarImageView.h"
#import "RSContactService.h"

@interface RSLanchViewController ()
@property (nonatomic, strong) RSAvatarImageView *headImage;
@property (nonatomic, strong) UILabel *name;

@end

@implementation RSLanchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(245, 245, 245);
    [self.view addSubview:self.headImage];
    [self.view addSubview:self.name];
    
    
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(326/812.0f*SCREEN_HEIGHT);
//        make.height.mas_equalTo(100);
//        make.width.mas_equalTo(100);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.headImage).offset(120);
        make.height.mas_equalTo(40);
//        make.width.mas_equalTo(136);
    }];
}

-(RSAvatarImageView *)headImage{
    if (!_headImage) {
        _headImage = [[RSAvatarImageView alloc] init];
        _headImage.url = [[RSContactService shareInstance] getMyAvatarUrl];
        _headImage.type = RSAvatarImageViewType100;
    }
    return _headImage;
}

-(UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc] init];
        NSString *nickName = [[RSContactService shareInstance] getMyNickName];
        _name.text = [NSString stringWithFormat:@"Hi~ %@", nickName];
        _name.textAlignment = NSTextAlignmentCenter;
        _name.textColor = RGB(9, 10, 70);
        _name.font = [UIFont fontWithName:@"PingFang-SC-Semibold" size:28];
    }
    return _name;
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

