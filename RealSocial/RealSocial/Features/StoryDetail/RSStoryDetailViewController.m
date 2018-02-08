//
//  RSStoryDetailViewController.m
//  RealSocial
//
//  Created by kuncai on 2018/2/8.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSStoryDetailViewController.h"

@interface RSStoryDetailViewController ()
@property (nonatomic, strong) UIScrollView *mediaScrollView;
@end

@implementation RSStoryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
-(UIScrollView *)mediaScrollView {
    if (_mediaScrollView) {
        return _mediaScrollView;
    }
    _mediaScrollView = [[UIScrollView alloc] init];
    return _mediaScrollView;
}
@end
