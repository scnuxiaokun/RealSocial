//
//  RSFriendListViewController.m
//  RealSocial
//
//  Created by kuncai on 2018/1/22.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSFriendListViewController.h"
#import "RSFriendListViewModel.h"
#import <MJRefresh/MJRefresh.h>
#import <BlocksKit/BlocksKit.h>
#import "RSChatViewController.h"

@interface RSFriendListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) RSFriendListViewModel *viewModel;
@end

@implementation RSFriendListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.viewModel loadData];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
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
-(RSFriendListViewModel *)viewModel {
    if (_viewModel) {
        return _viewModel;
    }
    _viewModel = [[RSFriendListViewModel alloc] init];
    return _viewModel;
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
        [self.viewModel loadData];
    }];
    [[self.viewModel.updateSignal deliverOnMainThread] subscribeNext:^(id  _Nullable x) {
        @RSStrongify(self);
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
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
    RSFriendListItemViewModel *itemViewModel = [self.viewModel.listData objectOrNilAtIndex:indexPath.row];
    if (itemViewModel) {
        cell.textLabel.text = itemViewModel.name;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RSChatViewController *ctr = [[RSChatViewController alloc] init];
    ctr.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ctr animated:YES];
}
@end