//
//  UIScrollView+Swizzle.m
//  FortunePlat
//
//  Created by aldwinlv on 2017/9/28.
//  Copyright © 2017年 Tencent. All rights reserved.
//

#import "UIScrollView+Swizzle.h"
#import <objc/runtime.h>
#import "JRSwizzle.h"

@implementation UIScrollView(Swizzle)

+ (void)load
{
    [self jr_swizzleMethod:@selector(init) withMethod:@selector(fp_init) error:nil];
    [self jr_swizzleMethod:@selector(initWithFrame:) withMethod:@selector(fp_initWithFrame:) error:nil];
    [self jr_swizzleMethod:@selector(initWithCoder:) withMethod:@selector(fp_initWithCoder:) error:nil];

}

- (nullable instancetype)fp_initWithCoder:(NSCoder *)aDecoder
{
    UIScrollView *instance = [self fp_initWithCoder:aDecoder];
    
    if (@available(iOS 11.0, *)) {
        instance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    return instance;
}


- (instancetype)fp_init
{
    UIScrollView *instance = [self fp_init];
    
    if (@available(iOS 11.0, *)) {
        instance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }

    return instance;
}

- (instancetype)fp_initWithFrame:(CGRect)frame
{
    UIScrollView *instance = [self fp_initWithFrame:frame];
    
    if (@available(iOS 11.0, *)) {
        instance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    return instance;
}


@end

@implementation UITableView(Swizzle)

+ (void)load
{
    [self jr_swizzleMethod:@selector(initWithFrame:style:) withMethod:@selector(fp_initWithFrame:style:) error:nil];
    
}

- (instancetype)fp_initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    UITableView *tableView = [self fp_initWithFrame:frame style:style];
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    return tableView;
}


@end

