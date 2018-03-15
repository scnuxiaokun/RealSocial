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

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
static NSString *appKey = @"00259b163e29a9d9c9df9e5b";
static NSString *channel = @"App Store";
static BOOL isProduction = FALSE;
static NSString *advertisingId = nil;
@interface AppDelegate ()<JPUSHRegisterDelegate>

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
    //极光推送初始化
    [self JPUSHRequired:launchOptions];
    
    
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

#pragma mark JPUSH && JPUSHRegisterDelegate
- (void)JPUSHRequired:(NSDictionary *)launchOptions{
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:advertisingId];
    
    //获取自定义消息推送内容
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    
}
//注册APNs成功并上报DeviceToken
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
//实现注册APNs失败接口
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

// iOS 10 Support  当程序处于前台时
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);
    }else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support  当程序在后台  点击推送消息后执行本方法
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 后台收到远程通知:%@", [self logDic:userInfo]);
    }else {
        // 判断为本地通知
        NSLog(@"iOS10 后台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler();  // 系统要求执行这个方法
}

//获取自定义消息推送内容
//只有在前端运行的时候才能收到自定义消息的推送。
//从jpush服务器获取用户推送的自定义消息内容和标题以及附加字段等
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    NSString *content = [userInfo valueForKey:@"content"];
    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    NSString *customizeField1 = [extras valueForKey:@"customizeField1"]; //服务端传递的Extras附加字段，key是自己定义的
    
    NSLog(@"收到自定义消息%@",content);
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}




//JPUSH end

- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
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
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
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
