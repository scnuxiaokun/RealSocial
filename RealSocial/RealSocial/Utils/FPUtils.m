//
//  FBUtils.m
//  FortunePlat
//
//  Created by kuncai on 15/11/13.
//  Copyright © 2015年 Tencent. All rights reserved.
//

#import "AppDelegate.h"
#import "FPKeychainUtils.h"
#import "UIImage+GIF.h"
#import "UINavigationController+Swizzle.h"

static NSInteger loadingImagesCount = 60;
static NSMutableArray * loadingImages;
@implementation FPUtils


+ (void)goHomeView {
//    FPUITabBarController *rootCtr = (FPUITabBarController*)[FPUtils getRootViewController];
//    
//    UINavigationController *selectedViewController = [rootCtr selectedViewController];
//    [[selectedViewController topViewController] dismissViewControllerAnimated:YES completion:^{
//    }];
//    
//    [selectedViewController popToRootViewControllerAnimated:NO];
//    
//    [rootCtr setSelectedIndex:0];
//    
//    selectedViewController = [rootCtr selectedViewController];
//    [[selectedViewController topViewController] dismissViewControllerAnimated:YES completion:^{
//    }];
//    
//    [selectedViewController popToRootViewControllerAnimated:NO];
    [self goHomeViewWithCompletion:nil];
}

+ (void)goHomeViewWithCompletion: (void (^ __nullable)(void))completion {
    UITabBarController *rootCtr = (UITabBarController*)[FPUtils getRootViewController];
    UINavigationController *selectedViewController = [rootCtr selectedViewController];
    
    if (selectedViewController.presentedViewController) {
        @weakify(rootCtr);
        [selectedViewController dismissViewControllerAnimated:NO completion:^{
            @RSStrongify(rootCtr);
            if (rootCtr.selectedIndex == 0) {
                [selectedViewController popToRootViewControllerAnimated:NO completion:^{
                    if (completion) {
                        completion();
                    }
                }];
            } else {
                rootCtr.selectedIndex = 0;
                [selectedViewController popToRootViewControllerAnimated:NO completion:^{
                    [FPUtils goHomeViewWithCompletion:completion];
                }];
            }
        }];
    } else {
        if (rootCtr.selectedIndex == 0) {
            [selectedViewController popToRootViewControllerAnimated:NO completion:^{
                if (completion) {
                    completion();
                }
            }];
        } else {
            rootCtr.selectedIndex = 0;
            [selectedViewController popToRootViewControllerAnimated:NO completion:^{
                [FPUtils goHomeViewWithCompletion:completion];
            }];
        }
    }
}

+ (void)_goHomeViewWithCompletion: (void (^)(void))completion {
    UITabBarController *rootCtr = (UITabBarController*)[FPUtils getRootViewController];
    UINavigationController *selectedViewController = [rootCtr selectedViewController];
    [selectedViewController popToRootViewControllerAnimated:NO];
    if (completion) {
        completion();
    }
}

+(void)printNavigationStack {
//    FPUITabBarController *rootCtr = (FPUITabBarController*)[FPUtils getRootViewController];
//    [self _printNavigationStackWithRoot:rootCtr level:0];
}

+(void)_printNavigationStackWithRoot:(UIViewController *)ctr level:(int)level {
    NSString *levelStr = [@"" stringByPaddingToLength:level*4 withString: @"-" startingAtIndex:0];
    NSLog(@"%@%@",levelStr,ctr);
    if ([ctr isKindOfClass:[UITabBarController class]]) {
        for (UIViewController *subCtr in [(UITabBarController *)ctr viewControllers]) {
            levelStr = [@"" stringByPaddingToLength:(level+1)*4 withString: @"-" startingAtIndex:0];
            NSLog(@"%@UITabBarController subCtrs",levelStr);
            [self _printNavigationStackWithRoot:subCtr level:level+1];
        }
        return;
    }
    if ([ctr isKindOfClass:[UINavigationController class]]) {
        for (UIViewController *subCtr in [(UINavigationController *)ctr viewControllers]) {
            levelStr = [@"" stringByPaddingToLength:(level+1)*4 withString: @"-" startingAtIndex:0];
            NSLog(@"%@UINavigationController subCtrs",levelStr);
            [self _printNavigationStackWithRoot:subCtr level:level+1];
        }
    }
    if (ctr.presentedViewController) {
        levelStr = [@"" stringByPaddingToLength:(level+1)*4 withString: @"-" startingAtIndex:0];
        NSLog(@"%@presentedViewController subCtrs",levelStr);
        [self _printNavigationStackWithRoot:ctr.presentedViewController level:level+1];
    }
}

+(UIViewController *)getRootViewController {
    RSUITabBarController *rootCtr = [[AppDelegate shareInstance] tabBarController];
    return rootCtr;
}

+ (UIViewController *)getTopViewController{
    RSUITabBarController *rootCtr = (RSUITabBarController*)[FPUtils getRootViewController];
    UIViewController *ctr = [self topViewController:[rootCtr selectedViewController]];
    if ([ctr isKindOfClass:[UITabBarController class]]) {
        ctr = [(UITabBarController*)ctr selectedViewController];
    }
    if ([ctr isKindOfClass:[UINavigationController class]]) {
        return [(UINavigationController*)ctr topViewController];
    }
    return ctr;
}

+ (UIViewController *)topViewController:(UIViewController *)rootViewController
{
    if (rootViewController.presentedViewController == nil) {
        return rootViewController;
    }
    
    if ([rootViewController.presentedViewController isMemberOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController.presentedViewController;
        UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
        return [self topViewController:lastViewController];
    }
    
    UIViewController *presentedViewController = (UIViewController *)rootViewController.presentedViewController;
    return [self topViewController:presentedViewController];
}

+ (UIViewController *)getViewControllerFrom:(UIView *)view {
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

+ (void)preloadImageResource
{
    NSMutableArray *tmp = [[NSMutableArray alloc] initWithCapacity:loadingImagesCount];
    for (int i = 1; i <= loadingImagesCount; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading%d", i]];
        if (image) {
            [tmp addObject:image];
        }
    }
    loadingImages = tmp;
}


+ (void)showLoadingViewWithMessage:(NSString *)msg
{
    dispatch_async_on_main_queue(^{
        MBProgressHUD *progressHud = [self loadingViewWithMessage:msg];
        [progressHud show:YES];
    });
}

+(MBProgressHUD *)loadingViewWithMessage:(NSString *)msg {

    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [MBProgressHUD hideAllHUDsForView:window animated:NO];
    window.userInteractionEnabled = YES;
    window.alpha = 1;
    
    MBProgressHUD *progressHud = [[MBProgressHUD alloc] initWithWindow:window];
    [window addSubview:progressHud];
    [self buildLoadingView:progressHud WithMessage:msg];
    return progressHud;
}

+(MBProgressHUD *)loadingViewWithMessage:(NSString *)msg inView:(UIView *)view {
    MBProgressHUD *progressHud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:progressHud];
    [self buildLoadingView:progressHud WithMessage:msg];
    return progressHud;
}

+(void)buildLoadingView:(MBProgressHUD *)progressHud WithMessage:(NSString *)msg {
//    progressHud.animationType = MBProgressHUDAnimationZoomIn;
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, 82)];
    customView.backgroundColor = [UIColor redColor];
    customView.layer.cornerRadius = 10;
    
//    NSMutableArray *images = [NSMutableArray arrayWithCapacity:60];
//    for (int i = 1; i <= 60; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading%d", i]];
//        if (image) {
//            [images addObject:image];
//        }
//    }
    
    UIImageView *imageViewbg = [[UIImageView alloc] init];
    imageViewbg.image = [UIImage imageNamed:@"loading_64"];
    [customView addSubview:imageViewbg];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    if (!loadingImages) {
        [self preloadImageResource];
    }
    imageView.animationImages = loadingImages;
    
    [customView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(fUIMargin);
        make.centerX.equalTo(customView);
        make.width.height.mas_equalTo(32);
    }];
    
    [imageViewbg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(fUIMargin);
        make.centerX.equalTo(customView);
        make.width.height.mas_equalTo(32);
    }];
    
    imageView.animationDuration = 1.2;
    [imageView startAnimating];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = msg.length > 0 ? msg : @"正在加载中…";
    label.font = [UIFont systemFontOfSize:11];
    label.textColor = [UIColor whiteColor];
    [label sizeToFit];
    customView.width = label.width > customView.width ? label.width + fUIMargin * 2 : customView.width;
    [customView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).with.offset(10);
        make.centerX.equalTo(customView);
        make.height.mas_equalTo(11);
//        make.bottom.mas_equalTo(-fUIMargin);
//        make.left.mas_equalTo(fUIMargin);
//        make.right.mas_equalTo(-fUIMargin);
    }];
//    [customView layoutIfNeeded];
    @weakify(progressHud);
    [progressHud addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id sender) {
        @RSStrongify(progressHud);
        [progressHud hide:YES];
    }]];
//    progressHud.backgroundColor = [FPUIStyleManager colorForKey:kMain001 withAlpha:0.5];
    //    progressHud.labelText = @"正在加载中…";
    progressHud.mode = MBProgressHUDModeCustomView;
    progressHud.color = [UIColor clearColor];
    progressHud.customView = customView;
    progressHud.removeFromSuperViewOnHide = YES;
//    progressHud.tag = FPMBProgressHUDTypeLoading;
}

+ (void)hideAllHUDs
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        [MBProgressHUD hideAllHUDsForView:window animated:NO];
    });
}

+ (void)hideAllLoadingHUDs {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        NSArray *huds = [MBProgressHUD allHUDsForView:window];
        for (MBProgressHUD *hud in huds) {
            if (hud.tag == FPMBProgressHUDTypeLoading) {
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES];
            }
        }
    });
}

+ (void)showProgressViewWithMessage:(NSString *)msg
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        [MBProgressHUD hideAllHUDsForView:window animated:NO];
        window.userInteractionEnabled = YES;
        window.alpha = 1;
        
        MBProgressHUD *progressHud = [[MBProgressHUD alloc] initWithWindow:window];
        [window addSubview:progressHud];
        progressHud.mode = MBProgressHUDModeAnnularDeterminate;
        progressHud.removeFromSuperViewOnHide = YES;
        progressHud.labelFont = [UIFont systemFontOfSize:13.0];
        progressHud.labelText = msg;
        [progressHud show:YES];
    });
}

+ (void)showProgressViewWithProgress:(CGFloat)progress
{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    MBProgressHUD *hud = [MBProgressHUD HUDForView:window];
    
    if (!hud) {
        [[self class] showProgressViewWithMessage:@""];
    }
    
    [MBProgressHUD HUDForView:window].progress = progress;
}

+ (void)showAlertViewWithCustomView:(UIView *)customView {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        [MBProgressHUD hideAllHUDsForView:window animated:NO];
        window.userInteractionEnabled = YES;
        window.alpha = 1;
        
        MBProgressHUD *progressHud = [[MBProgressHUD alloc] initWithWindow:window];
        [window addSubview:progressHud];
        [progressHud addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id sender) {
            [progressHud hide:YES];
        }]];
        progressHud.backgroundColor = [FPUIStyleManager colorForKey:kMain001 withAlpha:0.5];
        //        _HUD.labelText = @"操作成功";
        progressHud.mode = MBProgressHUDModeCustomView;
        progressHud.color = [UIColor clearColor];
        progressHud.customView = customView;
        progressHud.removeFromSuperViewOnHide = YES;
        progressHud.margin = 0;
        [progressHud show:YES];
    });
    

}

+(void)showAlertViewWithMessage:(NSString*)msg{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        [MBProgressHUD hideAllHUDsForView:window animated:NO];
        window.userInteractionEnabled = YES;
        window.alpha = 1;
        
        MBProgressHUD *progressHud = [[MBProgressHUD alloc] initWithWindow:window];
        [window addSubview:progressHud];
//        progressHud.userInteractionEnabled = NO;
        progressHud.removeFromSuperViewOnHide = YES;
        progressHud.mode = MBProgressHUDModeText;
        progressHud.animationType = MBProgressHUDAnimationZoomIn;
        progressHud.labelFont = [UIFont systemFontOfSize:13.0];
        progressHud.cornerRadius = 5.0;
//        progressHud.labelText = msg;
         progressHud.detailsLabelText = msg;
//        progressHud.completionBlock = finishedCallback;
//        progressHud.delegate = [SYBProjectUtils sharedInstance];
        [progressHud show:YES];
        [progressHud hide:YES afterDelay:1];
    });
}

+ (void)showTipViewWithMessage:(NSString*)msg lastTime:(NSInteger)lastTime{
    if ([msg length] <= 0) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        [MBProgressHUD hideAllHUDsForView:window animated:NO];
        window.userInteractionEnabled = YES;
        window.alpha = 1;
        
        MBProgressHUD *progressHud = [[MBProgressHUD alloc] initWithWindow:window];
        [window addSubview:progressHud];
        progressHud.userInteractionEnabled = NO;
        progressHud.removeFromSuperViewOnHide = YES;
        progressHud.mode = MBProgressHUDModeText;
        progressHud.animationType = MBProgressHUDAnimationZoomIn;
        progressHud.labelFont = [UIFont systemFontOfSize:13.0];
        progressHud.cornerRadius = 5.0;
        progressHud.detailsLabelText = msg;
        [progressHud show:YES];
        [progressHud hide:YES afterDelay:lastTime];
    });
}

+(void)showTipViewWithMessage:(NSString*)msg {
    [[self class] showTipViewWithMessage:msg lastTime:3];
}

+(NSString *)UDID {
    static NSString *udidKey = @"udidKeyChainKey";
    NSString *udid = [FPKeychainUtils load:udidKey];
    if (udid) {
        return udid;
    }
    udid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    [FPKeychainUtils save:udidKey data:udid];
    return udid;
}

+ (CGFloat)fixFontSize:(CGFloat)x
{
    if (YYScreenSize().height < 667) {
        return 0.73 * x > 11 ? 0.73 * x : 11;
    }
    else if (YYScreenSize().height == 667) {
        return x;
    }
    else {
        return 1.15*x;
    }
}


+ (CGFloat)fixFontSizeInEqualProportion:(CGFloat)font
{
    return ceil((YYScreenSize().width / 375.0) * font);
}

+ (CGFloat)fixHeight:(CGFloat)x
{
    if (YYScreenSize().height < 667) {
        return 0.73 * x;
    }
    else if (YYScreenSize().height == 667) {
        return x;
    }
    else {
        return 1.15*x;
    }
}

+ (CGFloat)fixPlusHeight:(CGFloat)y {
    if (YYScreenSize().height < 667) {
        return y;
    }
    else if (YYScreenSize().height == 667) {
        return y;
    }
    else {
        return 1.15*y;
    }
}

+ (CGFloat)fixWidth:(CGFloat)x
{
    if (YYScreenSize().width < 375) {
        return 0.73 * x;
    }
    else if (YYScreenSize().width == 375) {
        return x;
    }
    else {
        return 1.15*x;
    }
}

+ (CGFloat)fixWidthWithScreenWidth:(CGFloat)x {
    CGFloat rate = YYScreenSize().width/375;
    return rate * x;
}

+ (CGFloat)widthInAlertView {
    if (YYScreenSize().width < 375) {
        return  280;
    }
    return 300;
}

//+ (BOOL)isInvaildFloat:(CGFloat)value {
//    if (value == kInvaildValue) {
//        return YES;
//    }
//    return NO;
//}
//+ (BOOL)isInvaildLong:(long long)value {
//    if (value == kInvaildValue) {
//        return YES;
//    }
//    return NO;
//}

+ (NSString *)urlEncode:(NSString *)params {
    if (params.length == 0) {
        return @"";
    }
    
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)params,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    return encodedString;
//    NSString *charactersToEscape = @"`#%^{}\"[]|\\<> ";
//    NSCharacterSet *customEncodingSet = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
//    params = [params stringByAddingPercentEncodingWithAllowedCharacters:customEncodingSet];
//    return params;
}

+(BOOL) isWXAppInstalled {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:WXScheme]];
}

+(void)showWeChatTips:(NSString *)tips {
    NSString *title = [tips length] > 0 ? tips : @"请先安装微信客户端";
    LGAlertView *alert = [LGAlertView alertViewWithTitle:title message:nil style:LGAlertViewStyleAlert buttonTitles:nil cancelButtonTitle:nil destructiveButtonTitle:@"我知道了"];
    [alert showAnimated:YES completionHandler:nil];
}

+(NSString *)buildChannelBuyWithCard:(NSString *)card key:(NSString *)key {
    return [NSString stringWithFormat:@"%@_58|%@", card, key];
}
+(NSString *)buildChannelRansomKey:(NSString *)key {
    return [NSString stringWithFormat:@"58|%@", key];
}
@end
