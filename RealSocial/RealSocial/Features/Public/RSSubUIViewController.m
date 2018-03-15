//
//  RSSubUIViewController.m
//  RealSocial
//
//  Created by kuncai on 2018/2/8.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSSubUIViewController.h"

@interface RSSubUIViewController ()

@end

@implementation RSSubUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.transitionController prepareGestureRecognizerInViewController:self];
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(kNaviBarHeightAndStatusBarHeight);
    }];
    self.contentView.frame = CGRectMake(kNaviBarHeightAndStatusBarHeight, 0, self.view.width, self.view.height-kNaviBarHeightAndStatusBarHeight);
    
//    UIButton *button = [[UIButton alloc] init];
//    [self.contentView addSubview:button];
//    [button setTitle:@"test" forState:UIControlStateNormal];
//    [button setBackgroundColor:[UIColor randomColor]];
//    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.contentView);
//        make.width.height.mas_equalTo(200);
//    }];
//    @weakify(self);
//    [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
//        @RSStrongify(self);
//        RSSubUIViewController *ctr = [[RSSubUIViewController alloc] init];
//        [self.navigationController pushViewController:ctr animated:YES];
//    }];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([self.navigationController.viewControllers count] > 1) {
        UIViewController *preCtr = [self.navigationController.viewControllers objectOrNilAtIndex:[self.navigationController.viewControllers count]-2];
        if (preCtr && [preCtr isKindOfClass:[RSUIViewController class]]) {
            self.navigationController.view.backgroundColor = [UIColor colorWithPatternImage:[self imageByApplyingAlpha:0.5 image:[(RSUIViewController*)preCtr snapshotImage]]];
        }
    }
    
    
    //导航透明
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationItem setHidesBackButton:YES];
    
    //隐藏返回
//    [self.navigationController.navigationItem setHidesBackButton:YES];
//    [self.navigationItem setHidesBackButton:YES];
//    [self.navigationController.navigationBar.backItem setHidesBackButton:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(UIView *)contentView {
    if (_contentView) {
        return _contentView;
    }
    _contentView = [[UIView alloc] init];
    [_contentView addSubview:self.line];
    _contentView.backgroundColor = [UIColor clearColor];
    return _contentView;
}
-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-40)/2, 10, 40, 4)];
        _line.backgroundColor = RGBA(0, 0, 0, .2f);
        _line.layer.cornerRadius = 2;
        _line.layer.masksToBounds = YES;
    }
    return _line;
}
@end
