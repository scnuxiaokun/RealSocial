//
//  AppDelegate.h
//  RealSocial
//
//  Created by kuncai on 2018/1/17.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSUITabBarController.h"
#import "RSSpaceLineViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RSUITabBarController *tabBarController;
@property (strong, nonatomic) UIViewController *mainViewController;

+ (AppDelegate*)shareInstance;
- (void)showMainView;
@end

