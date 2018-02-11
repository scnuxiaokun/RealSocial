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
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *indentifier = @"RSFriendListViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@""];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifier];
    }
    RSReceiverListItemViewModel *itemViewModel = [self.viewModel.listData objectOrNilAtIndex:indexPath.row];
    cell.textLabel.text = itemViewModel.name;
    if (itemViewModel.isSelected) {
        cell.backgroundColor = [UIColor blueColor];
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RSReceiverListItemViewModel *itemViewModel = [self.viewModel.listData objectOrNilAtIndex:indexPath.row];
    itemViewModel.isSelected = YES;
    [tableView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
//    RSChatViewController *ctr = [[RSChatViewController alloc] init];
//    ctr.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:ctr animated:YES];
}
@end
