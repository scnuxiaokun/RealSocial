//
//  RSReceiverListWithSpaceViewController.m
//  RealSocial
//
//  Created by kuncai on 2018/2/11.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSReceiverListWithSpaceViewController.h"

@interface RSReceiverListWithSpaceViewController ()

@end

@implementation RSReceiverListWithSpaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableHeaderView = self.spaceView;
    self.headerView.titleLabel.text = @"分享瞬间";
    @weakify(self);
    [RACObserve(self.spaceView.allFriendCell.viewModel, isSelected) subscribeNext:^(id  _Nullable x) {
        @RSStrongify(self);
        if (self.spaceView.allFriendCell.viewModel.isSelected) {
            [self setAllunSelected];
            [self.spaceView setAllunSelected];
            self.spaceView.collectionView.allowsSelection = NO;
            self.tableView.allowsSelection = NO;
            [self.spaceView.memoriesCell setSelected:NO];
            self.spaceView.memoriesCell.viewModel.isSelected = NO;
        }
    }];
    [RACObserve(self.spaceView.memoriesCell.viewModel, isSelected) subscribeNext:^(id  _Nullable x) {
        @RSStrongify(self);
        if (self.spaceView.memoriesCell.viewModel.isSelected) {
            [self setAllunSelected];
            [self.spaceView setAllunSelected];
            self.spaceView.collectionView.allowsSelection = NO;
            self.tableView.allowsSelection = NO;
            [self.spaceView.allFriendCell setSelected:NO];
            self.spaceView.allFriendCell.viewModel.isSelected = NO;
        }
    }];
    [[RACSignal merge:@[RACObserve(self.spaceView.allFriendCell.viewModel, isSelected), RACObserve(self.spaceView.memoriesCell.viewModel, isSelected)]] subscribeNext:^(id  _Nullable x) {
        @RSStrongify(self);
        NSString *tips = @"";
        if (self.spaceView.allFriendCell.viewModel.isSelected) {
            tips = @"所有好友可见";
        }
        if (self.spaceView.memoriesCell.viewModel.isSelected) {
            tips = @"保存到我的回忆录，仅自己可见";
        }
        self.bottomOperationBar.label.text = tips;
        if ([tips length] <= 0) {
//            self.canSelect = YES;
            self.tableView.allowsSelection = YES;
            self.spaceView.collectionView.allowsSelection = YES;
        }
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

-(void)loadData {
    [super loadData];
    [self.spaceView.viewModel loadData];
}
-(RSReceiverSpaceView *)spaceView {
    if (_spaceView) {
        return _spaceView;
    }
    _spaceView = [[RSReceiverSpaceView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, 148+58+160)];
    @weakify(self);
    [[RACObserve(_spaceView, selectedCount) deliverOnMainThread] subscribeNext:^(id  _Nullable x) {
        @RSStrongify(self);
        if (self.spaceView.selectedCount + self.selectedCount > 0) {
            [self.finishButtonItem setEnabled:YES];
        } else {
            [self.finishButtonItem setEnabled:NO];
        }
    }];
    return _spaceView;
}

-(void)finishButton:(id)sender {
    if (self.spaceCompletionHandler) {
        //            self.completionHandler(self, [self.viewModel getSelectedUsers], [self.spaceView.viewModel getSelectedSpaces]);
        self.spaceCompletionHandler(self, [self.viewModel getSelectedUsers], [self.spaceView.viewModel getSelectedSpaces], self.spaceView.allFriendCell.viewModel.isSelected, self.spaceView.memoriesCell.viewModel.isSelected);
    }
//    [self.navigationController popViewControllerAnimated:YES];
}


@end
