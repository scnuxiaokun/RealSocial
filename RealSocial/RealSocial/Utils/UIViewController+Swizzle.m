//
//  UIViewController+Swizzle.m
//  FortunePlat
//
//  Created by aldwinlv on 16/8/19.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import "UIViewController+Swizzle.h"
#import <objc/runtime.h>
#import "FPWeakProxy.h"
#import "JRSwizzle.h"

@implementation UIViewController (Swizzle)

+ (void)load
{
    [self jr_swizzleMethod:@selector(viewDidAppear:) withMethod:@selector(fp_viewDidAppear:) error:nil];
    [self jr_swizzleMethod:@selector(viewDidDisappear:) withMethod:@selector(fp_viewDidDisappear:) error:nil];
    [self jr_swizzleMethod:@selector(presentViewController:animated:completion:) withMethod:@selector(fp_presentViewController:animated:completion:) error:nil];
    [self jr_swizzleMethod:@selector(dismissViewControllerAnimated:completion:) withMethod:@selector(fp_dismissViewControllerAnimated:completion:) error:nil];
    [self jr_swizzleMethod:NSSelectorFromString(@"dealloc") withMethod:@selector(fp_dealloc) error:nil];
}

- (void)fp_viewDidAppear:(BOOL)animated
{
    [self fp_viewDidAppear:animated];
    self.animating = NO;
    self.push_ctr = nil;
    
    NSString *className = [NSString stringWithUTF8String:object_getClassName(self)];
    FPLogError(@"********** %@ viewDidAppear", className);
}

- (void)fp_viewDidDisappear:(BOOL)animated
{
    [self fp_viewDidDisappear:animated];
    NSString *className = [NSString stringWithUTF8String:object_getClassName(self)];
    FPLogError(@"********** %@ viewDidDisappear", className);
    self.animating = NO;
}

- (void)fp_presentViewController:(UIViewController *)modalViewController animated:(BOOL)animated completion:(void (^)(void))completion
{
    if (!modalViewController) {
        FPLogError(@"%@ controller(%@) is nil.", NSStringFromSelector(_cmd), modalViewController);
        return;
    }
    
    if (self.animating) {
        FPLogError(@"%@ controller(%@) present when animating.", NSStringFromSelector(_cmd), modalViewController);
        return;
    }
    
    if ([modalViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)modalViewController;
        UIViewController *topViewController = [navigationController topViewController];
        topViewController.hk_parent = self;
        topViewController.animating = animated;
        navigationController.hk_parent = self;
        navigationController.animating = animated;
    } else {
        modalViewController.hk_parent = self;
        modalViewController.animating = animated;
    }
    
    NSString *className = [NSString stringWithUTF8String:object_getClassName(self)];
    FPLogError(@"********** presentViewController %@ ", className);
    [self fp_presentViewController:modalViewController animated:animated completion:^{
        self.animating = NO;
        if (completion) {
            completion();
        }
    }];
}

- (void)fp_dismissViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    NSString *className = [NSString stringWithUTF8String:object_getClassName(self)];
    NSString *className2 = [NSString stringWithUTF8String:object_getClassName(self.presentedViewController)];

    FPLogError(@"********** dismissViewControllerAnimated %@ presentedviewcontroller:%@ animated: %d completion", className, className2, animated);
    [self fp_dismissViewControllerAnimated:animated completion:completion];
}

- (void)fp_onViewControllerDidEnterBackground:(id)sender
{
    self.animating = NO;
}

- (void)fp_dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSString *className = [NSString stringWithUTF8String:object_getClassName(self)];
    FPLogError(@"********** %@ dealloc %@", className, self);
    [self fp_dealloc];
}

- (void)setAnimating:(BOOL)animating
{
    objc_setAssociatedObject(self, @"animating", @(animating), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)animating
{
    return ((NSNumber *)objc_getAssociatedObject(self, @"animating")).boolValue;
}

- (void)setHk_parent:(UIViewController *)hk_parent
{
    FPWeakProxy *proxy = [FPWeakProxy weakProxyForObject:hk_parent];
    objc_setAssociatedObject(self, @"hk_parent", proxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIViewController *)hk_parent
{
    FPWeakProxy *proxy = objc_getAssociatedObject(self, @"hk_parent");
    return proxy.target;
}

- (void)setPush_ctr:(UIViewController *)push_ctr
{
    FPWeakProxy *proxy = [FPWeakProxy weakProxyForObject:push_ctr];
    objc_setAssociatedObject(self, @"push_ctr", proxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIViewController *)push_ctr
{
    FPWeakProxy *proxy = objc_getAssociatedObject(self, @"push_ctr");
    return proxy.target;
}

@end
