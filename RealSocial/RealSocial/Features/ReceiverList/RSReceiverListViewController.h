//
//  RSFriendListViewController.h
//  RealSocial
//
//  Created by kuncai on 2018/1/22.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSSubUIViewController.h"
#import "RSChatViewController.h"

#import "RSReceiverHeaderView.h"

#import "RSReceiverListViewModel.h"
#import "RSReceiverOperationBar.h"

@class RSReceiverListViewController;
typedef void (^RSReceiverListCompletionHandler)(RSReceiverListViewController *ctr, NSArray *toUsers);

@interface RSReceiverListViewController : RSSubUIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) RSReceiverListViewModel *viewModel;
@property (nonatomic, strong) UIButton *finishButtonItem;

@property (nonatomic, strong) RSReceiverHeaderView *headerView;
@property (nonatomic, strong) NSArray *defaultToUsers;
@property (nonatomic, copy) RSReceiverListCompletionHandler completionHandler;
@property (nonatomic, assign) NSInteger selectedCount;
@property (nonatomic, strong) RSReceiverOperationBar *bottomOperationBar;
//@property (nonatomic, assign) BOOL canSelect;
-(void)finishButton:(id)sender;
-(void)loadData;
-(void)setAllunSelected;
@end
