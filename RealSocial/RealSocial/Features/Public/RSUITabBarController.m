//
//  RSUITabBarController.m
//  RealSocial
//
//  Created by kuncai on 2018/1/19.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSUITabBarController.h"
#import "RSChatListViewController.h"
#import "RSUINavigationController.h"
#import "RSMineViewController.h"
#import "RSFriendListViewController.h"
#import "RSMessageViewController.h"
@interface RSUITabBarController ()

@end

@implementation RSUITabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    RSUINavigationController *tab1 = [[RSUINavigationController alloc] initWithRootViewController:[[RSMessageViewController alloc] init]];
    tab1.title = @"message";
    
    RSUINavigationController *tab2 = [[RSUINavigationController alloc] initWithRootViewController:[[RSFriendListViewController alloc] init]];
    tab2.title = @"friend";
    
    RSUINavigationController *tab3 = [[RSUINavigationController alloc] initWithRootViewController:[[RSMineViewController alloc] init]];
    tab3.title = @"me";
    
    self.viewControllers = @[tab1, tab2, tab3];
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

@end
