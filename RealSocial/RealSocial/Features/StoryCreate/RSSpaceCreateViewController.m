//
//  RSStoryCreateViewController.m
//  RealSocial
//
//  Created by kuncai on 2018/2/7.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSSpaceCreateViewController.h"
//#import "DBCameraViewController.h"
//#import "DBCameraContainerViewController.h"
#import "RSSpaceCreateViewModel.h"
#import "RSReceiverListViewController.h"
#import "RSReceiverListWithSpaceViewController.h"

@interface RSSpaceCreateViewController ()
//@property (nonatomic, strong) UIButton *createButton;
@property (nonatomic, strong) RSSpaceCreateViewModel *viewModel;
@property (nonatomic, strong) MBProgressHUD *HUD;
@property (nonatomic, strong) UIButton *toUserButtom;
//@property (nonatomic, strong) UILabel *toUserLabel;
//@property (nonatomic, strong) NSArray *toUsersArray;
//@property (nonatomic, strong) NSArray *toSpaceIdsArray;
//@property (nonatomic, assign) RSSpaceCreateModelType createType;
@end

@implementation RSSpaceCreateViewController

-(void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor randomColor];
    self.contentView.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:self.pictureImageView];
    [self.pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).with.offset(-114);
//        make.height.mas_equalTo(300);
    }];
//    [self.contentView addSubview:self.createButton];
//    [self.createButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.contentView);
//        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
//    }];
    [self.contentView addSubview:self.toUserButtom];
    [self.toUserButtom mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.contentView).with.offset(-12);
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        make.width.height.mas_equalTo(42);
//        make.width.mas_equalTo(100);
    }];
//    [self.contentView addSubview:self.toUserLabel];
//    [self.toUserLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView);
//        make.top.equalTo(self.toUserButtom.mas_bottom).with.offset(20);
//    }];
//    [self.contentView addSubview:self.chooseAuthorButtom];
//    [self.chooseAuthorButtom mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.toUserLabel.mas_bottom).with.offset(20);
//        make.centerX.equalTo(self.contentView);
//    }];
//    DBCameraViewController *cameraController = [DBCameraViewController initWithDelegate:self];
//    [cameraController setUseCameraSegue:NO];
//    [self.navigationController pushViewController:cameraController animated:YES];
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

//-(UIButton *)createButton {
//    if (_createButton) {
//        return _createButton;
//    }_createButton = [[UIButton alloc] init];
//    [_createButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.height.mas_equalTo(80);
//    }];
//    [_createButton setBackgroundColor:[UIColor randomColor]];
//    _createButton.layer.cornerRadius = 80/2;
//    //    [_createButton setTitle:@"+" forState:UIControlStateNormal];
//    //    _createButton.titleLabel.font = [UIFont boldSystemFontOfSize:36];
//    @weakify(self);
//    [_createButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
//        @RSStrongify(self);
//        [self.HUD showAnimated:YES];
//        @weakify(self);
//        [[[self.viewModel create:self.pictureImageView.image toUsers:self.toUsersArray toSpaces:self.toSpaceIdsArray type:self.createType] deliverOnMainThread] subscribeNext:^(id  _Nullable x) {
//
//        } error:^(NSError * _Nullable error) {
//            @RSStrongify(self);
//            [self.HUD hideAnimated:YES];
//            [RSUtils showTipViewWithMessage:@"创建Story失败"];
//        } completed:^{
//            @RSStrongify(self);
//            [self.HUD hideAnimated:YES];
//            [RSUtils showTipViewWithMessage:@"创建Story成功"];
//        }];
//    }];
//    return _createButton;
//}

-(UIButton *)toUserButtom {
    if (_toUserButtom) {
        return _toUserButtom;
    }
    _toUserButtom = [[UIButton alloc] init];
    _toUserButtom.layer.cornerRadius = 30;
//    [_toUserButtom setTitle:@"》》" forState:UIControlStateNormal];
    [_toUserButtom setImage:[UIImage imageNamed:@"btn-send"] forState:UIControlStateNormal];
    [_toUserButtom setBackgroundColor:[UIColor clearColor]];
    @weakify(self);
    [_toUserButtom addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        @RSStrongify(self);
        RSReceiverListWithSpaceViewController *ctr = [[RSReceiverListWithSpaceViewController alloc] init];
//        ctr.defaultToUsers = self.toUsersArray;
        @weakify(self);
        [ctr setSpaceCompletionHandler:^(RSReceiverListWithSpaceViewController *ctr, NSArray *toUsers, NSArray *spaceIds, BOOL isSelectedAllFriend,BOOL isSelectedMemories) {
            @RSStrongify(self);
            [self.HUD showAnimated:YES];
            @weakify(self);
            if (isSelectedAllFriend) {
                [[[self.viewModel createToAllFriends:self.pictureImageView.image] deliverOnMainThread] subscribeError:^(NSError * _Nullable error) {
                    @RSStrongify(self);
                    [self.HUD hideAnimated:YES];
                    [RSUtils showTipViewWithMessage:[error localizedDescription]];
                } completed:^{
                    @RSStrongify(self);
                    [self.HUD hideAnimated:YES];
                    [RSUtils showTipViewWithMessage:@"创建Space给所有朋友成功"];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }];
                return;
            }
            if (isSelectedMemories) {
                [[[self.viewModel createToMemories:self.pictureImageView.image] deliverOnMainThread] subscribeError:^(NSError * _Nullable error) {
                    @RSStrongify(self);
                    [self.HUD hideAnimated:YES];
                    [RSUtils showTipViewWithMessage:[error localizedDescription]];
                } completed:^{
                    @RSStrongify(self);
                    [self.HUD hideAnimated:YES];
                    [RSUtils showTipViewWithMessage:@"创建Space给回忆成功"];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }];
                return;
            }
            if ([toUsers count] <= 0 && [spaceIds count] <= 0) {
                [RSUtils showTipViewWithMessage:@"必须选择一个对象"];
                return;
            }
            [[[self.viewModel create:self.pictureImageView.image toUsers:toUsers toSpaces:spaceIds] deliverOnMainThread] subscribeNext:^(id  _Nullable x) {
                
            } error:^(NSError * _Nullable error) {
                @RSStrongify(self);
                [self.HUD hideAnimated:YES];
                [RSUtils showTipViewWithMessage:[error localizedDescription]];
            } completed:^{
                @RSStrongify(self);
                [self.HUD hideAnimated:YES];
                [RSUtils showTipViewWithMessage:@"创建Space成功"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }];
        }];
        [self.navigationController pushViewController:ctr animated:YES];
    }];
    return _toUserButtom;
}

//-(UIButton *)chooseAuthorButtom {
//    if (_chooseAuthorButtom) {
//        return _chooseAuthorButtom;
//    }
//    _chooseAuthorButtom = [[UIButton alloc] init];
//    [_chooseAuthorButtom setTitle:@"创建多人Space" forState:UIControlStateNormal];
//    [_chooseAuthorButtom setBackgroundColor:[UIColor randomColor]];
//    @weakify(self);
//    [_chooseAuthorButtom addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
//        @RSStrongify(self);
//        RSReceiverListViewController *ctr = [[RSReceiverListViewController alloc] init];
//        ctr.defaultToUsers = self.toUsersArray;
//        @weakify(self);
//        [ctr setCompletionHandler:^(RSReceiverListViewController *ctr, NSArray *toUsers) {
//            @RSStrongify(self);
//            self.createType = RSSpaceCreateModelTypeGruop;
//            self.toUserLabel.text = [toUsers componentsJoinedByString:@";"];
//            self.toUsersArray = toUsers;
//        }];
//        [self.navigationController pushViewController:ctr animated:YES];
//    }];
//    return _chooseAuthorButtom;
//}

//-(UILabel *)toUserLabel {
//    if (_toUserLabel) {
//        return _toUserLabel;
//    }
//    _toUserLabel = [[UILabel alloc] init];
//    _toUserLabel.textColor = [UIColor randomColor];
//    _toUserLabel.font = [UIFont systemFontOfSize:14];
//    return _toUserLabel;
//}

-(MBProgressHUD *)HUD {
    if (_HUD) {
        return _HUD;
    }
    _HUD = [RSUtils loadingViewWithMessage:@"创建中..."];
    return _HUD;
}

//- (void) openCamera
//{
//    DBCameraContainerViewController *cameraContainer = [[DBCameraContainerViewController alloc] initWithDelegate:self];
//    [cameraContainer setFullScreenMode];
//
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:cameraContainer];
//    [nav setNavigationBarHidden:YES];
//    [self presentViewController:nav animated:YES completion:nil];
//}
//
//- (void) openCameraWithoutSegue
//{
//    DBCameraViewController *cameraController = [DBCameraViewController initWithDelegate:self];
//    [cameraController setUseCameraSegue:NO];
//
//    DBCameraContainerViewController *container = [[DBCameraContainerViewController alloc] initWithDelegate:self];
//    [container setCameraViewController:cameraController];
//    [container setFullScreenMode];
//
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:container];
//    [nav setNavigationBarHidden:YES];
//    [self presentViewController:nav animated:YES completion:nil];
//}
//
//- (void) openCameraWithoutContainer
//{
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[DBCameraViewController initWithDelegate:self]];
//    [nav setNavigationBarHidden:YES];
//    [self presentViewController:nav animated:YES completion:nil];
//}

//Use your captured image
#pragma mark - DBCameraViewControllerDelegate
//
//- (void) camera:(id)cameraViewController didFinishWithImage:(UIImage *)image withMetadata:(NSDictionary *)metadata
//{
////    DetailViewController *detail = [[DetailViewController alloc] init];
////    [detail setDetailImage:image];
////    [self.navigationController pushViewController:detail animated:NO];
//    [cameraViewController restoreFullScreenMode];
////    @weakify(self);
////    [self.presentedViewController dismissViewControllerAnimated:YES completion:^{
////        @RSStrongify(self);
////        [self.pictureImageView setImage:image];
////    }];
//    [self.pictureImageView setImage:image];
//    [self.navigationController popViewControllerAnimated:cameraViewController];
//}
//
//- (void) dismissCamera:(id)cameraViewController{
////    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popViewControllerAnimated:cameraViewController];
//    [cameraViewController restoreFullScreenMode];
//}

@end
