//
//  RSFriendListViewController.m
//  RealSocial
//
//  Created by kuncai on 2018/1/22.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSContactListViewController.h"
#import "RSContactListViewModel.h"
#import <MJRefresh/MJRefresh.h>
#import <BlocksKit/BlocksKit.h>
#import "RSChatViewController.h"

@interface RSContactListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) RSContactListViewModel *viewModel;
@property (nonatomic, strong) UIBarButtonItem *finishButtonItem;
@end

@implementation RSContactListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setRightBarButtonItems:@[self.finishButtonItem] animated:YES];
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
-(RSContactListViewModel *)viewModel {
    if (_viewModel) {
        return _viewModel;
    }
    _viewModel = [[RSContactListViewModel alloc] init];
    [_viewModel setDefaultToUsers:self.defaultToUsers];
    return _viewModel;
}

-(UIBarButtonItem *)finishButtonItem {
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
            self.completionHandler(self, [self.viewModel getSelectedUsers]);
//        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
    _finishButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return _finishButtonItem;
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
    RSContactListItemViewModel *itemViewModel = [self.viewModel.listData objectOrNilAtIndex:indexPath.row];
    cell.textLabel.text = itemViewModel.name;
    if (itemViewModel.isSelected) {
        cell.backgroundColor = [UIColor blueColor];
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RSContactListItemViewModel *itemViewModel = [self.viewModel.listData objectOrNilAtIndex:indexPath.row];
    itemViewModel.isSelected = YES;
    [tableView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
//    RSChatViewController *ctr = [[RSChatViewController alloc] init];
//    ctr.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:ctr animated:YES];
}
@end
