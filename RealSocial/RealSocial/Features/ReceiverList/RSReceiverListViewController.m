//
//  RSFriendListViewController.m
//  RealSocial
//
//  Created by kuncai on 2018/1/22.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSReceiverListViewController.h"
#import <MJRefresh/MJRefresh.h>
#import <BlocksKit/BlocksKit.h>
#import <UIImageView+WebCache.h>
#import "RSReceiverTitleView.h"
#import "RSReceiverListTableViewCell.h"
@interface RSReceiverListViewController ()
@end

@implementation RSReceiverListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.navigationItem setRightBarButtonItems:@[self.finishButtonItem] animated:YES];
    
    [self.contentView addSubview:self.headerView];
    [self.contentView addSubview:self.finishButtonItem];
    [self.contentView addSubview:self.tableView];
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.mas_equalTo(160);
    }];
    
    [self.finishButtonItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self.headerView);
        make.height.mas_equalTo(100);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(self.headerView.mas_bottom);
    }];
    [self loadData];
}

-(void)loadData {
    NSLog(@"RSReceiverListViewController loadData");
    [self.viewModel loadData];
    
//    [self.spaceView.viewModel loadData];
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
-(RSReceiverListViewModel *)viewModel {
    if (_viewModel) {
        return _viewModel;
    }
    _viewModel = [[RSReceiverListViewModel alloc] init];
    [_viewModel setDefaultToUsers:self.defaultToUsers];
    return _viewModel;
}
-(UIButton *)finishButtonItem {
    if (_finishButtonItem) {
        return _finishButtonItem;
    }
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundColor:[UIColor blueColor]];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    @weakify(self);
    [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        @RSStrongify(self);
//        if (self.completionHandler) {
////            self.completionHandler(self, [self.viewModel getSelectedUsers], [self.spaceView.viewModel getSelectedSpaces]);
//            self.completionHandler(self, [self.viewModel getSelectedUsers]);
//        }
//        [self.navigationController popViewControllerAnimated:YES];
        [self finishButton:sender];
    }];
    _finishButtonItem = button;
//    _finishButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return _finishButtonItem;
}

-(void)finishButton:(id)sender {
    if (self.completionHandler) {
        //            self.completionHandler(self, [self.viewModel getSelectedUsers], [self.spaceView.viewModel getSelectedSpaces]);
        self.completionHandler(self, [self.viewModel getSelectedUsers]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(RSReceiverHeaderView *)headerView {
    if (_headerView) {
        return _headerView;
    }
    _headerView = [[RSReceiverHeaderView alloc] init];
    return _headerView;
}

-(UITableView *)tableView {
    if (_tableView) {
        return _tableView;
    }
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    @weakify(self);
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self loadData];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel.listData count];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    RSReceiverTitleView *view = [[RSReceiverTitleView alloc] init];
    view.label.text = @"我的好友";
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *indentifier = @"RSReceiverListTableViewCell";
    RSReceiverListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[RSReceiverListTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifier];
    }
    RSReceiverListItemViewModel *itemViewModel = [self.viewModel.listData objectOrNilAtIndex:indexPath.row];
    cell.viewModel = itemViewModel;
    if (itemViewModel.isSelected) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RSReceiverListItemViewModel *itemViewModel = [self.viewModel.listData objectOrNilAtIndex:indexPath.row];
    itemViewModel.isSelected = !itemViewModel.isSelected;
    [tableView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
//    RSChatViewController *ctr = [[RSChatViewController alloc] init];
//    ctr.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:ctr animated:YES];
}
@end
