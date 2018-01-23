//
//  RSVideoViewController.m
//  RealSocial
//
//  Created by kuncai on 2018/1/21.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSVideoViewController.h"

@interface RSVideoViewController ()

@end

@implementation RSVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 1 创建session
    AVCaptureSession *session = [AVCaptureSession new];
    //设置session显示分辨率
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        [session setSessionPreset:AVCaptureSessionPreset640x480];
    else
        [session setSessionPreset:AVCaptureSessionPresetPhoto];
    
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

@end
