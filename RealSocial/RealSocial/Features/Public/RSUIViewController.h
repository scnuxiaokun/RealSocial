//
//  RSUIViewController.h
//  RealSocial
//
//  Created by kuncai on 2018/1/20.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>
#import "RSSwipeDownInteractiveTransition.h"
@interface RSUIViewController : UIViewController<UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) RSSwipeDownInteractiveTransition * transitionController;
- (void)presentViewControllerSwipeDown:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^ __nullable)(void))completion;
//- (void)pushViewControllerSwipeDown:(UIViewController *)viewController animated:(BOOL)animated;
@end
