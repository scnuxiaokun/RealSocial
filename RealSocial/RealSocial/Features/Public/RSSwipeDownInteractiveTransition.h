//
//  RSSwipeDownInteractiveTransition.h
//  RealSocial
//
//  Created by kuncai on 2018/2/8.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSSwipeDownInteractiveTransition : UIPercentDrivenInteractiveTransition
@property (nonatomic, assign) BOOL interacting;
@property (nonatomic, assign) BOOL shouldComplete;
@property (nonatomic, strong) UIViewController *presentingVC;
- (void)prepareGestureRecognizerInViewController:(UIViewController*)viewController;
@end
