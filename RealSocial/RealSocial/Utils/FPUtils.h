//
//  FBUtils.h
//  FortunePlat
//
//  Created by kuncai on 15/11/13.
//  Copyright © 2015年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FPEProductType.h"
#import "LGAlertView.h"
#import "MBProgressHUD.h"
#import <YYDispatchQueuePool/YYDispatchQueuePool.h>
#import "YYCategoriesMacro.h"

/* 实现 换算尺寸 的宏
 * 视觉是基于iphone6尺寸设计的，有些空隙的距离需要换算
 */
#define FIX_FONTSIZE_EQUALPRO(x) [FPUtils fixFontSizeInEqualProportion:x]
#define FIX_FONTSIZE(x) [FPUtils fixFontSize:x]
#define FIX_HEIGHT(x) [FPUtils fixHeight:x]
#define FIX_PLUSHEIGHT(x) [FPUtils fixPlusHeight:x]
#define FIX_WIDTH(x) [FPUtils fixWidth:x]
#define FPAlertViewWidth [FPUtils widthInAlertView]

/* 买入赎回的渠道号
 */
#define FINANCE_DETAIL              2
#define FINANCE_HOLDING_DETAIL      1

#define IS_IPHONEX (([[UIScreen mainScreen] bounds].size.height - 812) ? NO : YES)

static inline void fp_create_html_attri(NSString *text ,void (^block)(NSMutableAttributedString *htmlAttr)) {
    static dispatch_queue_t mySerialDispatchQueue;
    if (!mySerialDispatchQueue) {
         mySerialDispatchQueue = dispatch_queue_create("com.fortuneplat.fp_create_html_attri", NULL);
    }
    
    dispatch_async(mySerialDispatchQueue, ^{
        NSString *_text = text?:@"";
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithData:[_text dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        dispatch_async_on_main_queue(^{
            block(attrStr);
        });
    });
}

typedef enum : NSUInteger {
    FPMBProgressHUDTypeLoading = 100001
} FPMBProgressHUDType;

@interface FPUtils : NSObject

+(void)printNavigationStack;
+(UIViewController *)getRootViewController;

+ (UIViewController *)getViewControllerFrom:(UIView *)view;
+ (UIViewController *)getTopViewController;
+ (void)goHomeView;
+ (void)goHomeViewWithCompletion: (void (^)(void))completion;
+ (void)preloadImageResource;

+ (void)showLoadingViewWithMessage:(NSString *)msg;
+ (void)hideAllHUDs;
+ (void)hideAllLoadingHUDs;
+ (void)showProgressViewWithMessage:(NSString *)msg;
+(MBProgressHUD *)loadingViewWithMessage:(NSString *)msg;
+(MBProgressHUD *)loadingViewWithMessage:(NSString *)msg inView:(UIView *)view;
+ (void)showAlertViewWithCustomView:(UIView *)customView;
+ (void)showAlertViewWithMessage:(NSString*)msg;
+ (void)showTipViewWithMessage:(NSString*)msg;
+ (void)showTipViewWithMessage:(NSString*)msg lastTime:(NSInteger)lastTime;
+ (void)showProgressViewWithProgress:(CGFloat)progress;

+(NSString *)UDID;

//根据屏幕宽度fix
+ (CGFloat)fixFontSizeInEqualProportion:(CGFloat)font;

//iphone6以下是0.7
+ (CGFloat)fixFontSize:(CGFloat)y;
+ (CGFloat)fixHeight:(CGFloat)y;
+ (CGFloat)fixWidth:(CGFloat)x;
//按屏幕宽度等比缩放
+ (CGFloat)fixWidthWithScreenWidth:(CGFloat)x;
//LGAlertView专用宽度计算
+ (CGFloat)widthInAlertView;
//适配plus
+ (CGFloat)fixPlusHeight:(CGFloat)y;

+ (BOOL)isInvaildFloat:(CGFloat)value;
+ (BOOL)isInvaildLong:(long long)value;

+ (NSString *)urlEncode:(NSString *)params;

+(BOOL) isWXAppInstalled;

+(void)showWeChatTips:(NSString *)tips;

+(NSString *)buildChannelBuyWithCard:(NSString *)card key:(NSString *)key;
+(NSString *)buildChannelRansomKey:(NSString *)key;
@end

