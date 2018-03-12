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
#import "RSRegisterFaceViewController.h"
//#import <AlicloudMobileAnalitics/ALBBMAN.h>

#import "MGVideoViewController.h"
#import "MCSetModel.h"
#import "MCSetCell.h"
#import "MGHeader.h"
#import "MGFaceLicenseHandle.h"
#import "MGMarkSetViewController.h"

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
        if ([[RSLoginService shareInstance] hasRegisterFace]) {
            [self showMainView];
        } else {
            [self showRegisterFaceView];
        }
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

-(void)showRegisterFaceView {
    /** 进行联网授权版本判断，联网授权就需要进行网络授权 */
    BOOL needLicense = [MGFaceLicenseHandle getNeedNetLicense];
    if (needLicense) {
        [MGFaceLicenseHandle licenseForNetwokrFinish:^(bool License, NSDate *sdkDate) {
            if (!License) {
                NSLog(@"联网授权失败 ！！！");
                @weakify(self);
                dispatch_sync_on_main_queue(^{
                    @RSStrongify(self);
                    [self showMainView];
                });
            } else {
                NSLog(@"联网授权成功");
                @weakify(self);
                dispatch_sync_on_main_queue(^{
                    @RSStrongify(self);
                    if ([RSLoginService shareInstance].isLogined) {
                        NSString *modelPath = [[NSBundle mainBundle] pathForResource:KMGFACEMODELNAME ofType:@""];
                        NSData *modelData = [NSData dataWithContentsOfFile:modelPath];
                        int maxFaceCount = 0;
                        int faceSize = 100;
                        int internal = 40;
                        MGDetectROI detectROI = MGDetectROIMake(0, 0, 0, 0);
                        MGFacepp *markManager = [[MGFacepp alloc] initWithModel:modelData
                                                                   maxFaceCount:1
                                                                  faceppSetting:^(MGFaceppConfig *config) {
                                                                      config.minFaceSize = faceSize;
                                                                      config.interval = internal;
                                                                      config.orientation = 0;
                                                                      config.detectionMode = MGFppDetectionModeTrackingFast;
                                                                      
                                                                      config.detectROI = detectROI;
                                                                      config.pixelFormatType = PixelFormatTypeRGBA;
                                                                  }];
                        AVCaptureDevicePosition device = [self getCamera:NO];
                        MGVideoManager *videoManager = [MGVideoManager videoPreset:AVCaptureSessionPreset640x480
                                                                    devicePosition:device
                                                                       videoRecord:NO
                                                                        videoSound:NO];
                        RSRegisterFaceViewController *videoController = [[RSRegisterFaceViewController alloc] initWithNibName:nil bundle:nil];
                        //                        videoController.detectRect = CGRectMake(100, 100, 300, 300);
                        videoController.videoSize = CGSizeMake(480, 640);
                        videoController.videoManager = videoManager;
                        videoController.markManager = markManager;
                        videoController.debug = NO;
                        videoController.pointsNum = 81;
                        videoController.show3D = NO;
                        videoController.faceInfo = YES;
                        videoController.faceCompare = NO;
                        self.window.rootViewController = videoController;
                        [self.window makeKeyWindow];
                    } else {
                        [self showMainView];
                    }
                });
            }
        }];
    } else {
        NSLog(@"SDK 为非联网授权版本！");
    }
    
    
}

- (AVCaptureDevicePosition)getCamera:(BOOL)index{
    AVCaptureDevicePosition tempVideo;
    if (index == NO) {
        tempVideo = AVCaptureDevicePositionFront;
    }else{
        tempVideo = AVCaptureDevicePositionBack;
    }
    return tempVideo;
}

- (void)showLoginView {
    dispatch_sync_on_main_queue(^{
        if ([self.window.rootViewController isKindOfClass:[RSUINavigationController class]]) {
            RSUINavigationController *navCtr = (RSUINavigationController *)self.window.rootViewController;
            if ([navCtr.topViewController isKindOfClass:[RSLoginViewController  class]]) {
                return;//防止重复显示
            }
        }
        RSLoginViewController *loginCtr = [[RSLoginViewController alloc] init];
        RSUINavigationController *navCtr = [[RSUINavigationController alloc] initWithRootViewController:loginCtr];
        self.window.rootViewController = navCtr;
        [self.window makeKeyWindow];
    });
}

- (void)showStartView {
    dispatch_sync_on_main_queue(^{
        if ([RSLoginService shareInstance].isLogined) {
            RSLanchViewController *ctr = [[RSLanchViewController alloc] init];
            self.window.rootViewController = ctr;
            [self.window makeKeyWindow];
        } else {
            [self showLoginView];
        }
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
