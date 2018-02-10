//
//  RSUIViewController.m
//  RealSocial
//
//  Created by kuncai on 2018/1/20.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSUIViewController.h"
#import <AlicloudMobileAnalitics/ALBBMAN.h>
#import "BouncePresentAnimation.h"
#import "NormalDismissAnimation.h"
#import "RSSwipeDownInteractiveTransition.h"
@interface RSUIViewController () <UINavigationControllerDelegate>
//@property (nonatomic, strong) BouncePresentAnimation *presentAnimation;
//@property (nonatomic, strong) NormalDismissAnimation *dismissAnimation;
@property(nonatomic,strong)UIPercentDrivenInteractiveTransition *interactiveTransition;
@property (nonatomic, assign) BOOL interacting;
@property (nonatomic, assign) BOOL shouldComplete;
@end

@implementation RSUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    _presentAnimation = [BouncePresentAnimation new];
//    _dismissAnimation = [NormalDismissAnimation new];
//    if ([self.navigationController.viewControllers count] > 1) {
//        [self.transitionController prepareGestureRecognizerInViewController:self];
//    }
//    if ([self.navigationController.viewControllers count] > 1) {
//        self.interactiveTransition=[UIPercentDrivenInteractiveTransition new];
//        [self.interactiveTransition prepareGestureRecognizerInViewController:self];
//    }
    if ([self.navigationController.viewControllers count] > 1) {
        [self prepareGestureRecognizerInView:self.view];
    }
    // 设置导航控制器的代理为self
    self.navigationController.delegate = self;
}

- (void)prepareGestureRecognizerInView:(UIView*)view {
//    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
//    [view addGestureRecognizer:gesture];
    
    @weakify(self);
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithActionBlock:^(UIPanGestureRecognizer *gestureRecognizer) {
        @RSStrongify(self);
        CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
        switch (gestureRecognizer.state) {
            case UIGestureRecognizerStateBegan:
                // 1. Mark the interacting flag. Used when supplying it in delegate.
                self.interacting = YES;
                self.interactiveTransition=[UIPercentDrivenInteractiveTransition new];
                [self.navigationController popViewControllerAnimated:YES];
                break;
            case UIGestureRecognizerStateChanged: {
                // 2. Calculate the percentage of guesture
                CGFloat fraction = translation.y / 400.0;
                //Limit it between 0 and 1
                fraction = fminf(fmaxf(fraction, 0.0), 1.0);
                self.shouldComplete = (fraction > 0.5);
                NSLog(@"updateInteractiveTransition:%f",fraction);
                [self.interactiveTransition updateInteractiveTransition:fraction];
                break;
            }
            case UIGestureRecognizerStateEnded:
            case UIGestureRecognizerStateCancelled: {
                // 3. Gesture over. Check if the transition should happen or not
                self.interacting = NO;
                if (!self.shouldComplete || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
                    [self.interactiveTransition cancelInteractiveTransition];
                } else {
                    [self.interactiveTransition finishInteractiveTransition];
                }
                self.interactiveTransition = nil;
                break;
            }
            default:
                break;
        }
    }];
    [view addGestureRecognizer:gesture];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[ALBBMANPageHitHelper getInstance] pageAppear:self];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[ALBBMANPageHitHelper getInstance] pageDisAppear:self];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 必须在viewDidAppear或者viewWillAppear中写，因为每次都需要将delegate设为当前界面
    self.navigationController.delegate=self;
    
    //显示导航栏
//    [self.navigationController.navigationItem setHidesBackButton:NO];
//    self.navigationController.navigationBar.translucent = YES;
//    [self.navigationController.navigationBar setShadowImage:nil];
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.view.backgroundColor = [UIColor colorWithPatternImage:[self.navigationController.view snapshotImage]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (void)pushViewControllerSwipeDown:(UIViewController *)viewController animated:(BOOL)animated {
////    [self.transitionController prepareGestureRecognizerInViewController:viewController];
//    return [self.navigationController pushViewController:viewController animated:YES];
//}

- (void)snapshotScreenInView:(UIView *)contentView {
    
    CGSize size = contentView.bounds.size;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    CGRect rect = contentView.frame;
    
    //  自iOS7开始，UIView类提供了一个方法-drawViewHierarchyInRect:afterScreenUpdates: 它允许你截取一个UIView或者其子类中的内容，并且以位图的形式（bitmap）保存到UIImage中
    
    [contentView drawViewHierarchyInRect:rect afterScreenUpdates:YES];
    
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    
    
}

- (void)presentViewControllerSwipeDown:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^ __nullable)(void))completion {
    viewControllerToPresent.transitioningDelegate = self;
    [self.transitionController prepareGestureRecognizerInViewController:viewControllerToPresent];
//    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    return [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (UIPercentDrivenInteractiveTransition *)transitionController
{
    if (!_transitionController) {
        _transitionController = [RSSwipeDownInteractiveTransition new];
    }
    return _transitionController;
}

//-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
//    return self.transitionController.interacting ? self.transitionController : nil;
//}
//- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
//{
//    return self.presentAnimation;
//}

//-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
//{
//    return self.dismissAnimation;
//}


#pragma mark push AnimatedTransitioning
//用来自定义转场动画
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    
    if(operation==UINavigationControllerOperationPush)
    {
        BouncePresentAnimation *animateTransitionPush=[BouncePresentAnimation new];
        return animateTransitionPush;
    }
    if (operation == UINavigationControllerOperationPop) {
        NormalDismissAnimation *pingInvert = [NormalDismissAnimation new];
        return pingInvert;
    }
    return nil;
}


//为这个动画添加用户交互
- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    
    return self.interactiveTransition;
}

-(CGFloat)completionSpeed
{
    return 1 - self.interactiveTransition.percentComplete;
}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
//    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
@end
