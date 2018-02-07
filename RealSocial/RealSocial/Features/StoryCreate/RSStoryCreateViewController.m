//
//  RSStoryCreateViewController.m
//  RealSocial
//
//  Created by kuncai on 2018/2/7.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSStoryCreateViewController.h"
#import "DBCameraViewController.h"
#import "DBCameraContainerViewController.h"
#import "RSStoryCreateViewModel.h"

@interface RSStoryCreateViewController () <DBCameraViewControllerDelegate>
@property (nonatomic, strong) UIImageView *pictureImageView;
@property (nonatomic, strong) UIButton *createButton;
@property (nonatomic, strong) RSStoryCreateViewModel *viewModel;
@property (nonatomic, strong) MBProgressHUD *HUD;

@end

@implementation RSStoryCreateViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor randomColor];
    [self.view addSubview:self.pictureImageView];
    [self.pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(300);
    }];
    [self.view addSubview:self.createButton];
    [self.createButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
    [self openCameraWithoutContainer];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(RSStoryCreateViewModel *)viewModel {
    if (_viewModel) {
        return _viewModel;
    }
    _viewModel = [[RSStoryCreateViewModel alloc] init];
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
    [_createButton setBackgroundColor:[UIColor whiteColor]];
    _createButton.layer.cornerRadius = 80/2;
    //    [_createButton setTitle:@"+" forState:UIControlStateNormal];
    //    _createButton.titleLabel.font = [UIFont boldSystemFontOfSize:36];
    @weakify(self);
    [_createButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        @RSStrongify(self);
//        [self showVideoViewController];
    }];
    return _createButton;
}

-(MBProgressHUD *)HUD {
    if (_HUD) {
        return _HUD;
    }
    _HUD = [RSUtils loadingViewWithMessage:nil inView:self.view];
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
        [self.HUD showAnimated:YES];
        @weakify(self);
        [[[self.viewModel create:image toUsers:@[@"kuncai"]] deliverOnMainThread] subscribeNext:^(id  _Nullable x) {
            
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
}

- (void) dismissCamera:(id)cameraViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
    [cameraViewController restoreFullScreenMode];
}

@end
