//
//  RSProfileViewController.m
//  RealSocial
//
//  Created by 蒋陈浩 on 2018/3/14.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSProfileViewController.h"
#import "RSAvatarImageView.h"
#import "RSContactService.h"
@interface RSProfileViewController ()
@property (nonatomic, strong) RSAvatarImageView *headerImage;
@property (nonatomic, strong) UILabel *name, *describe;
@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UIButton *shareBtn, *newGroupBtn, *settingBtn;
@end

@implementation RSProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentView.backgroundColor = [UIColor main1];
    self.contentView.layer.cornerRadius = 10;
    self.contentView.layer.masksToBounds = YES;
    
    [self.contentView addSubview:self.headerImage];
    [self.contentView addSubview:self.name];
    [self.contentView addSubview:self.describe];
    [self.contentView addSubview:self.centerView];
    [self.contentView addSubview:self.shareBtn];
    [self.contentView addSubview:self.newGroupBtn];
    [self.contentView addSubview:self.settingBtn];
    
    [self.headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(40);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
    }];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerImage.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
    }];
    [self.describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.name.mas_bottom).offset(8);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
    }];
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.describe.mas_bottom).offset(30);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.height.mas_equalTo(320);
        make.width.mas_equalTo(280);
    }];
    
    [self.newGroupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-20);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(60);
    }];
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.newGroupBtn.mas_left).offset(-50);
        make.centerY.mas_equalTo(self.newGroupBtn.mas_centerY);
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(60);
    }];
    
    [self.settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.newGroupBtn.mas_right).offset(50);
        make.centerY.mas_equalTo(self.newGroupBtn.mas_centerY);
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(60);
    }];

}

- (RSAvatarImageView *)headerImage{
    if (!_headerImage) {
        _headerImage = [[RSAvatarImageView alloc] init];
        _headerImage.type = RSAvatarImageViewType80;
        _headerImage.url = [[RSContactService shareInstance] getMyAvatarUrl];
    }
    return _headerImage;
}
-(UILabel *)name{
    if (!_name) {
        _name = [UILabel lableWithText:@"理查德·王" fontSize:20];
    }
    return _name;
}
- (UILabel *)describe{
    if (!_describe) {
        _describe = [UILabel lableWithText:@"加入圈子 123 天，与你分享过 38 个瞬间" fontSize:14];
    }
    return _describe;
}
- (UIView *)centerView{
    if (!_centerView) {
        _centerView = [[UIView alloc] init];
        _centerView.backgroundColor = [UIColor whiteColor];
        _centerView.layer.cornerRadius = 10;
        _centerView.layer.masksToBounds = YES;
    }
    return _centerView;
}
- (UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithImage:@"btn-profile-share"];
    }
    return _shareBtn;
}
- (UIButton *)newGroupBtn{
    if (!_newGroupBtn) {
        _newGroupBtn = [UIButton buttonWithImage:@"btn-profile-newgroup"];
    }
    return _newGroupBtn;
}
- (UIButton *)settingBtn{
    if (!_settingBtn) {
        _settingBtn = [UIButton buttonWithImage:@"btn-profile-setting"];
    }
    return _settingBtn;
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
