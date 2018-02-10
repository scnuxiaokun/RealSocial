//
//  RSStoryCreateViewController.m
//  RealSocial
//
//  Created by kuncai on 2018/2/7.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSSpaceCreateViewController.h"
#import "DBCameraViewController.h"
#import "DBCameraContainerViewController.h"
#import "RSSpaceCreateViewModel.h"
#import "RSReceiverListViewController.h"

@interface RSSpaceCreateViewController () <DBCameraViewControllerDelegate>
@property (nonatomic, strong) UIImageView *pictureImageView;
@property (nonatomic, strong) UIButton *createButton;
@property (nonatomic, strong) RSSpaceCreateViewModel *viewModel;
@property (nonatomic, strong) MBProgressHUD *HUD;
@property (nonatomic, strong) UIButton *toUserButtom;
@property (nonatomic, strong) UILabel *toUserLabel;
@property (nonatomic, strong) NSArray *toUsersArray;
@end

@implementation RSSpaceCreateViewController

-(void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor randomColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.pictureImageView];
    [self.pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(300);
    }];
    [self.contentView addSubview:self.createButton];
    [self.createButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
    [self.contentView addSubview:self.toUserButtom];
    [self.toUserButtom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pictureImageView.mas_bottom).with.offset(20);
        make.centerX.equalTo(self.contentView);
    }];
    [self.contentView addSubview:self.toUserLabel];
    [self.toUserLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(self.toUserButtom.mas_bottom).with.offset(20);
    }];
    [self openCameraWithoutSegue];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.HUD hideAnimated:NO];
}

-(RSSpaceCreateViewModel *)viewModel {
    if (_viewModel) {
        return _viewModel;
    }
    _viewModel = [[RSSpaceCreateViewModel alloc] init];
    return _viewModel;
}

-(UIImageView *)pictureImageView {
    if (_pictureImageView) {
        return _pictureImageView;
    }
    _pictureImageView = [[UIImageView alloc] init];
    _pictureImageView.backgroundColor = [UIColor randomColor];
    return _pictureImageView;
}

-(UIButton *)createButton {
    if (_createButton) {
        return _createButton;
    }_createButton = [[UIButton alloc] init];
    [_createButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(80);
    }];
    [_createButton setBackgroundColor:[UIColor randomColor]];
    _createButton.layer.cornerRadius = 80/2;
    //    [_createButton setTitle:@"+" forState:UIControlStateNormal];
    //    _createButton.titleLabel.font = [UIFont boldSystemFontOfSize:36];
    @weakify(self);
    [_createButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        @RSStrongify(self);
        [self.HUD showAnimated:YES];
        @weakify(self);
        [[[self.viewModel create:self.pictureImageView.image toUsers:self.toUsersArray] deliverOnMainThread] subscribeNext:^(id  _Nullable x) {
            
        } error:^(NSError * _Nullable error) {
            @RSStrongify(self);
            [self.HUD hideAnimated:YES];
            [RSUtils showTipViewWithMessage:@"创建Story失败"];
        } completed:^{
            @RSStrongify(self);
            [self.HUD hideAnimated:YES];
            [RSUtils showTipViewWithMessage:@"创建Story成功"];
        }];
    }];
    return _createButton;
}

-(UIButton *)toUserButtom {
    if (_toUserButtom) {
        return _toUserButtom;
    }
    _toUserButtom = [[UIButton alloc] init];
    [_toUserButtom setTitle:@"选择发送对象" forState:UIControlStateNormal];
    [_toUserButtom setBackgroundColor:[UIColor randomColor]];
    @weakify(self);
    [_toUserButtom addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        @RSStrongify(self);
        RSReceiverListViewController *ctr = [[RSReceiverListViewController alloc] init];
        ctr.defaultToUsers = self.toUsersArray;
        @weakify(self);
        [ctr setCompletionHandler:^(RSReceiverListViewController *ctr, NSArray *toUsers) {
            @RSStrongify(self);
            self.toUserLabel.text = [toUsers componentsJoinedByString:@";"];
            self.toUsersArray = toUsers;
        }];
        [self.navigationController pushViewController:ctr animated:YES];
    }];
    return _toUserButtom;
}

-(UILabel *)toUserLabel {
    if (_toUserLabel) {
        return _toUserLabel;
    }
    _toUserLabel = [[UILabel alloc] init];
    _toUserLabel.textColor = [UIColor randomColor];
    _toUserLabel.font = [UIFont systemFontOfSize:14];
    return _toUserLabel;
}

-(MBProgressHUD *)HUD {
    if (_HUD) {
        return _HUD;
    }
    _HUD = [RSUtils loadingViewWithMessage:@"创建中..."];
    return _HUD;
}

- (void) openCamera
{
    DBCameraContainerViewController *cameraContainer = [[DBCameraContainerViewController alloc] initWithDelegate:self];
    [cameraContainer setFullScreenMode];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:cameraContainer];
    [nav setNavigationBarHidden:YES];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void) openCameraWithoutSegue
{
    DBCameraViewController *cameraController = [DBCameraViewController initWithDelegate:self];
    [cameraController setUseCameraSegue:NO];
    
    DBCameraContainerViewController *container = [[DBCameraContainerViewController alloc] initWithDelegate:self];
    [container setCameraViewController:cameraController];
    [container setFullScreenMode];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:container];
    [nav setNavigationBarHidden:YES];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void) openCameraWithoutContainer
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[DBCameraViewController initWithDelegate:self]];
    [nav setNavigationBarHidden:YES];
    [self presentViewController:nav animated:YES completion:nil];
}

//Use your captured image
#pragma mark - DBCameraViewControllerDelegate

- (void) camera:(id)cameraViewController didFinishWithImage:(UIImage *)image withMetadata:(NSDictionary *)metadata
{
//    DetailViewController *detail = [[DetailViewController alloc] init];
//    [detail setDetailImage:image];
//    [self.navigationController pushViewController:detail animated:NO];
    [cameraViewController restoreFullScreenMode];
    @weakify(self);
    [self.presentedViewController dismissViewControllerAnimated:YES completion:^{
        @RSStrongify(self);
        [self.pictureImageView setImage:image];
    }];
}

- (void) dismissCamera:(id)cameraViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
    [cameraViewController restoreFullScreenMode];
}

@end
