//
//  RSStoryLineViewController.m
//  RealSocial
//
//  Created by kuncai on 2018/2/7.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSSpaceLineViewController.h"
#import "RSMineViewController.h"
#import "RSSpaceLineViewModel.h"
#import "RSSpaceLineViewTableViewCell.h"

//#import "MGVideoViewController.h"
//#import "MCSetModel.h"
//#import "MCSetCell.h"
//#import "MGHeader.h"
//#import "MGFaceLicenseHandle.h"
//#import "MGMarkSetViewController.h"
#import "RSSpaceCreateViewController.h"
#import "RSSpaceDetailViewController.h"
#import "RSSpaceLineNavigationBar.h"
#import <UIImageView+WebCache.h>
#import "DBCameraViewController.h"
#import "RSAvatarImageView.h"

@interface RSSpaceLineViewController ()<UITableViewDelegate, UITableViewDataSource, DBCameraViewControllerDelegate>
@property (nonatomic, strong) RSSpaceLineNavigationBar *bar;
@property (nonatomic, strong) RSAvatarImageView *avatarImageView;
@property (nonatomic, strong) UIButton *userCenterButton;
@property (nonatomic, strong) UIButton *createButton;
@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) RSSpaceLineViewModel *viewModel;
@end

@implementation RSSpaceLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bar];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.createButton];
    
    
//    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.userCenterButton];
//    UIBarButtonItem *commentButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.commentButton];
//    UIBarButtonItem *searchButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.searchButton];
//    [self.navigationItem setLeftBarButtonItems:@[leftButtonItem] animated:YES];
//    [self.navigationItem setRightBarButtonItems:@[commentButtonItem, searchButtonItem] animated:YES];
    [self.bar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(68);
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).with.offset([[UIApplication sharedApplication] statusBarFrame].size.height);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.bar.mas_bottom);
    }];
    [self.createButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
//    [self.view addSubview:self.userCenterButton];
//    [self.userCenterButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(100);
//        make.right.equalTo(self.view).offset(0);
//        make.width.height.mas_equalTo(100);
//    }];
    [self.viewModel loadData];
    
//    /** 进行联网授权版本判断，联网授权就需要进行网络授权 */
//    BOOL needLicense = [MGFaceLicenseHandle getNeedNetLicense];
//    
//    if (needLicense) {
//        //        self.videoBtn.userInteractionEnabled = NO;
//        [MGFaceLicenseHandle licenseForNetwokrFinish:^(bool License, NSDate *sdkDate) {
//            if (!License) {
//                NSLog(@"联网授权失败 ！！！");
//                assert(NO);
//            } else {
//                NSLog(@"联网授权成功");
//                //                self.videoBtn.userInteractionEnabled = YES;
//            }
//        }];
//    } else {
//        NSLog(@"SDK 为非联网授权版本！");
//    }
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

-(RSSpaceLineNavigationBar *)bar {
    if (_bar) {
        return _bar;
    }
    _bar = [[RSSpaceLineNavigationBar alloc] init];
    [_bar addSubview:self.avatarImageView];
    [_bar addSubview:self.commentButton];
    [_bar addSubview:self.searchButton];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bar);
        make.left.equalTo(_bar).with.offset(12);
    }];
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_bar).with.offset(-12);
        make.centerY.equalTo(_bar);
    }];
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.searchButton.mas_left).with.offset(-12);
        make.centerY.equalTo(_bar);
    }];
    return _bar;
}

-(RSAvatarImageView *)avatarImageView {
    if (_avatarImageView) {
        return _avatarImageView;
    }
    _avatarImageView = [[RSAvatarImageView alloc] init];
    _avatarImageView.url = @"http://www.ladysh.com/d/file/2016080410/2306_160803134243_1.jpg";
    _avatarImageView.type = RSAvatarImageViewType48;
//    _avatarImageView.layer.cornerRadius = _avatarImageView.height/2;
//    _avatarImageView.layer.masksToBounds = YES;
//    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:@"http://www.ladysh.com/d/file/2016080410/2306_160803134243_1.jpg"]];
    _avatarImageView.userInteractionEnabled = YES;
    @weakify(self);
    [_avatarImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        @RSStrongify(self);
        RSMineViewController *mineCtr = [[RSMineViewController alloc] init];
        [self.navigationController pushViewController:mineCtr animated:YES];
    }]];
    return _avatarImageView;
}

-(UIButton *)userCenterButton {
    if (_userCenterButton) {
        return _userCenterButton;
    }
    _userCenterButton = [[UIButton alloc] init];
    [_userCenterButton setBackgroundColor:[UIColor blueColor]];
    [_userCenterButton setTitle:@"我" forState:UIControlStateNormal];
    @weakify(self);
    [_userCenterButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        @RSStrongify(self);
        RSMineViewController *mineCtr = [[RSMineViewController alloc] init];
        [self.navigationController pushViewController:mineCtr animated:YES];
    }];
    return _userCenterButton;
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
        [self showVideoViewController];
    }];
    return _createButton;
}

-(UIButton *)searchButton {
    if (_searchButton) {
        return _searchButton;
    }_searchButton = [[UIButton alloc] init];
    [_searchButton setBackgroundColor:[UIColor grayColor]];
    [_searchButton setTitle:@"评论" forState:UIControlStateNormal];
    return _searchButton;
}
-(UIButton *)commentButton {
    if (_commentButton) {
        return _commentButton;
    }_commentButton = [[UIButton alloc] init];
    [_commentButton setBackgroundColor:[UIColor grayColor]];
    [_commentButton setTitle:@"搜索" forState:UIControlStateNormal];
    return _commentButton;
}

-(RSSpaceLineViewModel *)viewModel {
    if (_viewModel) {
        return _viewModel;
    }
    _viewModel = [[RSSpaceLineViewModel alloc] init];
    return _viewModel;
}

-(UITableView *)tableView {
    if (_tableView) {
        return _tableView;
    }
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorColor  = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    @weakify(self);
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self.viewModel loadData];
    }];
    [[RACObserve(self.viewModel, listData) deliverOnMainThread] subscribeNext:^(id  _Nullable x) {
        @RSStrongify(self);
        [self.tableView reloadData];
    }];
    [[self.viewModel.completeSignal deliverOnMainThread] subscribeNext:^(id  _Nullable x) {
        @RSStrongify(self);
        [self.tableView.mj_header endRefreshing];
    }];
    [[self.viewModel.errorSignal deliverOnMainThread] subscribeNext:^(id  _Nullable x){
        @RSStrongify(self);
        [self.tableView.mj_header endRefreshing];
    }];
    return _tableView;
}

#pragma mark table delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel.listData count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
    //    RSPictureModel *itemViewModel = [self.viewModel.listData objectOrNilAtIndex:indexPath.row];
    //    return itemViewModel.height;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *indentifier = @"RSStoryLineViewTableViewCell";
    RSSpaceLineViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[RSSpaceLineViewTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifier];
    }
    cell.viewModel = [self.viewModel.listData objectOrNilAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RSSpaceLineItemViewModel *itemViewModel = [self.viewModel.listData objectOrNilAtIndex:indexPath.row];
    RSSpaceDetailViewController *ctr = [[RSSpaceDetailViewController alloc] init];
    [ctr.viewModel updateWithStory:itemViewModel.space];
    [self.navigationController pushViewController:ctr animated:YES];
}

#pragma mark take picture
-(void)showVideoViewController {
    DBCameraViewController *cameraController = [DBCameraViewController initWithDelegate:self];
    [cameraController setUseCameraSegue:NO];
    [self.navigationController pushViewController:cameraController animated:YES];
//    RSSpaceCreateViewController *ctr = [[RSSpaceCreateViewController alloc] init];
//    [self.navigationController pushViewController:ctr animated:YES];
//    MGMarkSetViewController *ctr =  [[MGMarkSetViewController alloc] initWithNibName:nil bundle:nil];
//    ctr.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:ctr animated:YES];
}

#pragma mark - DBCameraViewControllerDelegate

- (void) camera:(id)cameraViewController didFinishWithImage:(UIImage *)image withMetadata:(NSDictionary *)metadata
{
    //    DetailViewController *detail = [[DetailViewController alloc] init];
    //    [detail setDetailImage:image];
    //    [self.navigationController pushViewController:detail animated:NO];
    [cameraViewController restoreFullScreenMode];
    //    @weakify(self);
    //    [self.presentedViewController dismissViewControllerAnimated:YES completion:^{
    //        @RSStrongify(self);
    //        [self.pictureImageView setImage:image];
    //    }];
//    [self.pictureImageView setImage:image];
//    [self.navigationController popViewControllerAnimated:cameraViewController];
    RSSpaceCreateViewController *ctr = [[RSSpaceCreateViewController alloc] init];
    [ctr.pictureImageView setImage:image];
    [self.navigationController pushViewController:ctr animated:YES];
}

- (void) dismissCamera:(id)cameraViewController{
    //    [self dismissViewControllerAnimated:YES completion:nil];
    [cameraViewController restoreFullScreenMode];
    [self.navigationController popViewControllerAnimated:cameraViewController];
    
}
@end
