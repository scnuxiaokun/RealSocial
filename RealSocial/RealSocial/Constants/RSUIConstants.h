//
//  FPUIConstants.h
//  FortunePlat
//
//  Created by kuncai on 16/1/26.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

static CGFloat  const fUINavigationBarItemWidth = 20;
static CGFloat  const fUINavigationBarItemMargin = 15;
static CGFloat  const fUIMargin = 15;
static CGFloat  const fUIMargin20 = 20;

static CGFloat  const fUISeperatorLineWidth = 0.5;
/* navigationBar和tabBar等控件的高度
 *
 */
static CGFloat kNaviBarHeight = 44.0;
static CGFloat kNaviBarBottom = 64.0;
static CGFloat kTabBarHeight = 49.0;
static CGFloat kStatusBarHeight = 20.0;

#define kNaviBarHeightAndStatusBarHeight (kNaviBarHeight+[[UIApplication sharedApplication] statusBarFrame].size.height)
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)

