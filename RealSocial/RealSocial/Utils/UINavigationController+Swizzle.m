//
//  UINavigationController+Swizzle.m
//  FortunePlat
//
//  Created by aldwinlv on 16/8/19.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import "UINavigationController+Swizzle.h"
#import "JRSwizzle.h"
#import <objc/runtime.h>
#import "FPWeakProxy.h"
#import "UIViewController+Swizzle.h"
#import "Common.h"

#define isIOS9 ([Common DeviceSystemIsIOS9])
#define isIOS8 ([Common DeviceSystemIsIOS8])

@interface UINavigationController ()

@property (weak, nonatomic) UIViewController *qz_popingController;

@end

@implementation UINavigationController(Swizzle)

+ (void)load
{
    [self jr_swizzleMethod:@selector(pushViewController:animated:) withMethod:@selector(fp_pushViewController:animated:) error:nil];
    [self jr_swizzleMethod:@selector(popViewControllerAnimated:) withMethod:@selector(fp_popViewControllerAnimated:) error:nil];
    [self jr_swizzleMethod:@selector(popToViewController:animated:) withMethod:@selector(fp_popToViewController:animated:) error:nil];
    [self jr_swizzleMethod:@selector(popToRootViewControllerAnimated:) withMethod:@selector(fp_popToRootViewControllerAnimated:) error:nil];
}

- (void)fp_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(self.topViewController == viewController) {
        FPLogError(@"%@ controller(%@) has been pushed.", NSStringFromSelector(_cmd), viewController);
        return;
    }
    
    // 非ios9，满足self.topViewController.animating && viewController != nil，就阻止push
    // ios9下，不阻止
    
    if (self.topViewController.animating && viewController != nil) {
        if (isIOS9 && self.topViewController.push_ctr == viewController) {
            FPLogError(@"%@ controller(%@) push when animating, device system is iOS9, and viewCtr matches pushCtr. pushes allowed", NSStringFromSelector(_cmd), viewController);
        }
        else {
            FPLogError(@"%@ controller(%@) push when animating.", NSStringFromSelector(_cmd), viewController);
            return;
        }
    }
    
    if(!viewController){
        FPLogError(@"%@ controller is nil.", NSStringFromSelector(_cmd));
        return;
    }
    
    viewController.hk_parent = self.topViewController;
    
    self.topViewController.animating = animated;
    if (self.topViewController.push_ctr == viewController) {
        self.topViewController.push_ctr = nil;
    }
    else {
        self.topViewController.push_ctr = viewController;
    }
    viewController.animating = animated;
    
    
    FPLogError(@"********** %@  %@", NSStringFromSelector(_cmd), viewController);
    [self fp_pushViewController:viewController animated:animated];
}

- (UIViewController*)fp_popViewControllerAnimated:(BOOL)animated
{
    if (self.viewControllers.count == 1) {
        return [self fp_popViewControllerAnimated:animated];
    }
    
    if (self.qz_popingController == self.topViewController && isIOS8) {
        return [self fp_popViewControllerAnimated:animated];
    }
    
    if (self.topViewController.animating) {
        FPLogError(@"%@ controller(%@) pop when animating.", NSStringFromSelector(_cmd), self.topViewController);
        return nil;
    }
    
    self.topViewController.animating = animated;
    FPLogError(@"********** %@ %@ ",NSStringFromSelector(_cmd), self.topViewController);
    
    if (self.viewControllers.count >= 2) {
        UIViewController *backController = self.viewControllers[self.viewControllers.count - 2];
        backController.animating = animated;
    }
    
    self.qz_popingController = self.topViewController;
    UIViewController *popedViewController = [self fp_popViewControllerAnimated:animated];
    self.qz_popingController = nil;
    
    return popedViewController;
}

- (NSArray *)fp_popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count == 1) {
        return [self fp_popToViewController:viewController animated:animated];
    }
    
    if (self.topViewController.animating) {
        FPLogError(@"%@ controller(%@) pop when animating.", NSStringFromSelector(_cmd), self.topViewController);
        return nil;
    }
    
    self.topViewController.animating = animated;
    
    FPLogError(@"********** %@ %@ ", NSStringFromSelector(_cmd), self.topViewController);
    NSArray *popedViewControllerList = [self fp_popToViewController:viewController animated:animated];
    
    self.topViewController.animating = animated;
    
    return popedViewControllerList;
}

- (NSArray *)fp_popToRootViewControllerAnimated:(BOOL)animated
{
    if (self.viewControllers.count == 1) {
        return [self fp_popToRootViewControllerAnimated:animated];
    }
    
    if (self.topViewController.animating) {
        FPLogError(@"%@ controller(%@) pop when animating.", NSStringFromSelector(_cmd), self.topViewController);
        return nil;
    }
    
    self.topViewController.animating = animated;
    
    FPLogError(@"********** %@ %@ ", NSStringFromSelector(_cmd), self.topViewController);
    NSArray *popedViewControllerList = [self fp_popToRootViewControllerAnimated:animated];
    
    self.topViewController.animating = animated;
    
    return popedViewControllerList;
}

- (void)setQz_popingController:(UIViewController *)qz_popingController
{
    FPWeakProxy *proxy = [FPWeakProxy weakProxyForObject:qz_popingController];
    objc_setAssociatedObject(self, @"qz_popingController", proxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIViewController *)qz_popingController
{
    FPWeakProxy *proxy = objc_getAssociatedObject(self, @"qz_popingController");
    return proxy.target;
}

- (void)popToRootViewControllerAnimated: (BOOL)flag completion: (void (^ __nullable)(void))completion {
    static int count=0;
    if (count > 5) {
        count=0;
        return;
    }
    if ([self.topViewController animating]) {
        count++;
        @weakify(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            @FPStrongify(self);
            [self popToRootViewControllerAnimated:flag completion:completion];
        });
        return;
    }
    count=0;
    [self popToRootViewControllerAnimated:flag];
    if (completion) {
        completion();
    }
}

@end
