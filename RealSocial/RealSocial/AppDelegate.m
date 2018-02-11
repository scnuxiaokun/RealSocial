//
//  AppDelegate.m
//  RealSocial
//
//  Created by kuncai on 2018/1/17.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "AppDelegate.h"
#import "RSLoginViewController.h"
#import "RSLaunchService.h"
#import "RSLoginService.h"
#import "RSLanchViewController.h"
#import "RSHandleOpenUrlHelper.h"
//#import <AlicloudMobileAnalitics/ALBBMAN.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate*)shareInstance
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setTranslucent:YES];
    
    @weakify(self);
    [[RSLaunchService shareInstance] setStartBlock:^{
        @RSStrongify(self);
        [self showStartView];
    }];
    [[RSLaunchService shareInstance] setStartCompleteBlock:^{
        @RSStrongify(self);
        [self showMainView];
    }];
    [[RSLaunchService shareInstance] setStartErrorBlock:^{
        @RSStrongify(self);
        [self showMainView];
    }];
    [[RSLaunchService shareInstance] setLoginCompleteBlock:^{
        @RSStrongify(self);
        [self showMainView];
    }];
    [[RSLaunchService shareInstance] setLogoutCompleteBlock:^{
        @RSStrongify(self);
        self.tabBarController = nil;
        [self showLoginView];
    }];
    [[RSLaunchService shareInstance] start];
    return YES;
}

- (void)showMainView {
    dispatch_sync_on_main_queue(^{
        if ([RSLoginService shareInstance].isLogined) {
            self.window.rootViewController = self.mainViewController;
            [self.window makeKeyWindow];
        } else {
            [self showLoginView];
        }
        
    });
}

- (void)showLoginView {
    dispatch_sync_on_main_queue(^{
        RSLoginViewController *loginCtr = [[RSLoginViewController alloc] init];
        RSUINavigationController *navCtr = [[RSUINavigationController alloc] initWithRootViewController:loginCtr];
        self.window.rootViewController = navCtr;
        [self.window makeKeyWindow];
    });
}

- (void)showStartView {
    dispatch_sync_on_main_queue(^{
        RSLanchViewController *ctr = [[RSLanchViewController alloc] init];
        self.window.rootViewController = ctr;
        [self.window makeKeyWindow];
    });
}

-(RSUITabBarController *)tabBarController {
    if (_tabBarController) {
        return _tabBarController;
    }
    _tabBarController = [[RSUITabBarController alloc] init];
    return _tabBarController;
}

-(UIViewController *)mainViewController {
    if (_mainViewController) {
        return _mainViewController;
    }
    RSSpaceLineViewController *storyLineCtr = [[RSSpaceLineViewController alloc] init];
    _mainViewController = [[RSUINavigationController alloc] initWithRootViewController:storyLineCtr];
    return _mainViewController;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [RSHandleOpenUrlHelper application:application openURL:url sourceApplication:nil annotation:nil];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [RSHandleOpenUrlHelper application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

@end
