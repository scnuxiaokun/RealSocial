//
//  RSUtil.h
//  RealSocial
//
//  Created by kuncai on 2018/1/20.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface RSUtils : NSObject
+(MBProgressHUD *)loadingViewWithMessage:(NSString *)msg inView:(UIView *)view;
+(MBProgressHUD *)loadingViewWithMessage:(NSString *)msg;
+ (void)showTipViewWithMessage:(NSString*)msg;
+ (void)showTipViewWithMessage:(NSString*)msg lastTime:(NSInteger)lastTime;
+ (UIViewController *)getViewControllerFrom:(UIView *)view;
@end
