//
//  RSSettingViewController.m
//  RealSocial
//
//  Created by 蒋陈浩 on 2018/3/12.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSSettingViewController.h"
#import "RSLoginService.h"
#import "RSSettingTableViewCell.h"
#import "RSAvatarImageView.h"
#import "RSContactService.h"
#import "SVProgressHUD.h"
#import "SDImageCache.h"
#import "RSProfileViewController.h"
@interface RSSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *settingTableView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) RSAvatarImageView *headImage;
@property (nonatomic, strong) UILabel *userName, *joinDuration, *shareCount;
@property (nonatomic, strong) UIImageView *next;
@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, strong) NSString *cacheText;
@end

@implementation RSSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self cacheCount];
    self.contentView.backgroundColor = [UIColor main1];
    self.contentView.layer.cornerRadius = 10;
    self.contentView.layer.masksToBounds = YES;
   
    [self.contentView addSubview:self.topView];
    [self.topView addSubview:self.headImage];
    [self.topView addSubview:self.userName];
    [self.topView addSubview:self.joinDuration];
    [self.topView addSubview:self.shareCount];
    [self.topView addSubview:self.next];
    [self.contentView addSubview:self.settingTableView];
    [self.contentView bringSubviewToFront:self.line];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.height.mas_equalTo(160);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_top).mas_offset(60);
        make.left.mas_equalTo(self.topView.mas_left).mas_offset(20);
    }];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImage.mas_top).mas_offset(10);
        make.left.mas_equalTo(self.headImage.mas_right).mas_offset(10);
    }];
    [self.joinDuration mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userName.mas_bottom).mas_offset(8);
        make.left.mas_equalTo(self.headImage.mas_right).mas_offset(10);
    }];
    [self.shareCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.joinDuration.mas_bottom);
        make.left.mas_equalTo(self.headImage.mas_right).mas_offset(10);
    }];
    [self.next mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headImage);
        make.right.mas_equalTo(self.topView.mas_right).mas_offset(-22);
        make.height.mas_equalTo(9);
        make.width.mas_equalTo(7);
    }];
    [self.settingTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_bottom);
        make.left.mas_equalTo(self.topView.mas_left);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
}
-(NSArray *)dataList{
    if (!_dataList) {
        _dataList = @[@[@"管理好友/圈子",@"隐私设置",@"清理缓存"],@[@"意见反馈",@"关于我们"],@[@"退出登录"]];
    }
    return _dataList;
}


-(UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor main1];
    }
    return _topView;
}
-(RSAvatarImageView *)headImage{
    if (!_headImage) {
        _headImage = [[RSAvatarImageView alloc] init];
        _headImage.type = RSAvatarImageViewType80;
        _headImage.url = [[RSContactService shareInstance] getMyAvatarUrl];
    }
    return _headImage;
}
-(UILabel *)userName{
    if (!_userName) {
        _userName = [[UILabel alloc] init];
        NSString *name = [[RSContactService shareInstance] getMyNickName];
        if (![name length]) {
            name = @"未设置昵称";
        }
        _userName.text = name;
        _userName.font = [UIFont systemFontOfSize:20];
        _userName.textColor = [UIColor main2];
    }
    return _userName;
}

- (UILabel *)joinDuration{
    if (!_joinDuration) {
        _joinDuration = [[UILabel alloc] init];
        _joinDuration.text = @"加入圈子 123 天";
        _joinDuration.font = [UIFont systemFontOfSize:12];
        _joinDuration.textColor = RGBA(9, 10, 7, .4);
    }
    return _joinDuration;
}

- (UILabel *)shareCount{
    if (!_shareCount) {
        _shareCount = [[UILabel alloc] init];
        _shareCount.text = @"分享过 38 个瞬间";
        _shareCount.font = [UIFont systemFontOfSize:12];
        _shareCount.textColor = RGBA(9, 10, 7, .4);
    }
    return _shareCount;
}

-(UIImageView *)next{
    if (!_next) {
        _next = [[UIImageView alloc] init];
        [_next setImage:[UIImage imageNamed:@"btn-common-disclosure"]];
    }
    return _next;
}

- (NSString *)cacheText{
    if (!_cacheText) {
        _cacheText = @"正在计算...";
    }
    return _cacheText;
}


- (UITableView *)settingTableView{
    if (!_settingTableView) {
        _settingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:(UITableViewStylePlain)];
        _settingTableView.backgroundColor = [UIColor whiteColor];
        _settingTableView.delegate = self;
        _settingTableView.dataSource = self;
        _settingTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _settingTableView;
}

#pragma mark TableViewDelegat
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ((NSArray*)self.dataList[section]).count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
        if (section == 0) {
            return 0.0f;
        }
    return 30.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifire = @"settingCell";
    RSSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (!cell) {
        cell = [[RSSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifire];
    }
    cell.textLabel.text = self.dataList[indexPath.section][indexPath.row];
        if (indexPath.row == 2 && indexPath.section == 0) {
            cell.describe.text = self.cacheText;
        }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 && indexPath.section == 0) {
        RSProfileViewController *profile = [[RSProfileViewController alloc] init];
        [self.navigationController pushViewController:profile animated:YES];
    }
    if (indexPath.row == 0 && indexPath.section == 2) {
        [[RSLoginService shareInstance] logout];
    }
    if (indexPath.row == 2 && indexPath.section == 0) {
        [self clearCache];
    }
}

- (void)cacheCount{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
 
       NSUInteger size = [SDImageCache sharedImageCache].getSize;//SDWebImage 缓存
        NSString *sizeText = nil;
        if (size >= pow(10, 9)) {
            sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
        }else if (size >= pow(10, 6)) {
            sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
        }else if (size >= pow(10, 3)) {
            sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
        }else {
            sizeText = [NSString stringWithFormat:@"%zdB", size];
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.cacheText = sizeText;
            [self.settingTableView reloadData];
        });
        
        
    });
}

- (void)clearCache
{
    [SVProgressHUD showWithStatus:@"正在清除缓存···"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];
                self.cacheText = @"0KB";
                [self.settingTableView reloadData];
            });
        });
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
