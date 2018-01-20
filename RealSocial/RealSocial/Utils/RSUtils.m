//
//  RSUtil.m
//  RealSocial
//
//  Created by kuncai on 2018/1/20.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSUtils.h"
#import "MBProgressHUD.h"

@implementation RSUtils
+(MBProgressHUD *)loadingViewWithMessage:(NSString *)msg {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [MBProgressHUD hideHUDForView:window animated:NO];
    window.userInteractionEnabled = YES;
    window.alpha = 1;
    
    MBProgressHUD *progressHud = [[MBProgressHUD alloc] initWithView:window];
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
//    progressHud.backgroundColor = ;
    //    progressHud.labelText = @"正在加载中…";
    progressHud.userInteractionEnabled = NO;
    progressHud.removeFromSuperViewOnHide = YES;
    progressHud.mode = MBProgressHUDModeText;
    progressHud.animationType = MBProgressHUDAnimationZoomIn;
//    progressHud.labelFont = [UIFont systemFontOfSize:13.0];
//    progressHud.cornerRadius = 5.0;
    progressHud.detailsLabel.text = (msg) ? msg : @"loading...";
//    [progressHud show:YES];
//    [progressHud hide:YES afterDelay:lastTime];
}

+(void)showTipViewWithMessage:(NSString*)msg {
    [[self class] showTipViewWithMessage:msg lastTime:3];
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
//        progressHud.labelFont = [UIFont systemFontOfSize:13.0];
//        progressHud.cornerRadius = 5.0;
        progressHud.detailsLabel.text = msg;
        [progressHud showAnimated:YES];
        [progressHud hideAnimated:YES afterDelay:lastTime];
    });
}

@end
