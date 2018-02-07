//
//  RSStoryLineViewController.m
//  RealSocial
//
//  Created by kuncai on 2018/2/7.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSStoryLineViewController.h"
#import "RSMineViewController.h"
#import "RSStoryLineViewModel.h"
#import "RSStoryLineViewTableViewCell.h"
@interface RSStoryLineViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIButton *userCenterButton;
@property (nonatomic, strong) UIButton *createButton;
@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) RSStoryLineViewModel *viewModel;
@end

@implementation RSStoryLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.userCenterButton];
    UIBarButtonItem *commentButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.commentButton];
    UIBarButtonItem *searchButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.searchButton];
    [self.navigationItem setLeftBarButtonItems:@[leftButtonItem] animated:YES];
    [self.navigationItem setRightBarButtonItems:@[commentButtonItem, searchButtonItem] animated:YES];
    
    
//    [self.userCenterButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(0);
//        make.right.equalTo(self.view).offset(0);
//        make.width.height.mas_equalTo(100);
//    }];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.createButton];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.createButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
    [self.viewModel loadData];
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
    [_createButton setBackgroundColor:[UIColor whiteColor]];
    _createButton.layer.cornerRadius = 80/2;
//    [_createButton setTitle:@"+" forState:UIControlStateNormal];
//    _createButton.titleLabel.font = [UIFont boldSystemFontOfSize:36];
    @weakify(self);
    [_createButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        @RSStrongify(self);
        
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
    return _createButton;
}

-(RSStoryLineViewModel *)viewModel {
    if (_viewModel) {
        return _viewModel;
    }
    _viewModel = [[RSStoryLineViewModel alloc] init];
    return _viewModel;
}

-(UITableView *)tableView {
    if (_tableView) {
        return _tableView;
    }
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = [UIColor redColor];
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
    RSStoryLineViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[RSStoryLineViewTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifier];
    }
    cell.viewModel = [self.viewModel.listData objectOrNilAtIndex:indexPath.row];
    return cell;
}
@end
