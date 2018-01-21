//
//  RSMineViewController.m
//  RealSocial
//
//  Created by kuncai on 2018/1/20.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSMineViewController.h"
#import "RSLoginService.h"
#import "MGVideoViewController.h"
#import "MCSetModel.h"
#import "MCSetCell.h"
#import "MGHeader.h"

@interface RSMineViewController ()
@property (nonatomic, strong) UIButton *logoutButton;
@property (nonatomic, strong) UILabel *sessionKeyLabel;
@property (nonatomic, strong) UILabel *uidLabel;
@property (nonatomic, strong) UIButton *takePhotoButton;
@end

@implementation RSMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"me";
    [self.view addSubview:self.uidLabel];
    [self.view addSubview:self.sessionKeyLabel];
    [self.view addSubview:self.logoutButton];
    [self.view addSubview:self.takePhotoButton];
    [self.uidLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(20);
        make.top.equalTo(self.view).with.offset(kNaviBarHeightAndStatusBarHeight);
    }];
    [self.sessionKeyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(20);
        make.top.equalTo(self.uidLabel.mas_bottom).with.offset(0);
    }];
    [self.takePhotoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sessionKeyLabel.mas_bottom).with.offset(50);
        make.centerX.equalTo(self.view);
    }];
    [self.logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
}

-(void)showVideoViewController {
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:KMGFACEMODELNAME ofType:@""];
    NSData *modelData = [NSData dataWithContentsOfFile:modelPath];
    int maxFaceCount = 1;
    int faceSize = 100;
    int internal = 40;
    MGDetectROI detectROI = MGDetectROIMake(0, 0, 0, 0);
    MGFacepp *markManager = [[MGFacepp alloc] initWithModel:modelData
                                               maxFaceCount:maxFaceCount
                                              faceppSetting:^(MGFaceppConfig *config) {
                                                  config.minFaceSize = faceSize;
                                                  config.interval = internal;
                                                  config.orientation = 90;
                                                  config.detectionMode = MGFppDetectionModeTrackingFast;
                                                  
                                                  config.detectROI = detectROI;
                                                  config.pixelFormatType = PixelFormatTypeRGBA;
                                              }];
    AVCaptureDevicePosition device = [self getCamera:NO];
    MGVideoManager *videoManager = [MGVideoManager videoPreset:AVCaptureSessionPreset640x480
                                                devicePosition:device
                                                   videoRecord:NO
                                                    videoSound:NO];
    MGVideoViewController *videoController = [[MGVideoViewController alloc] initWithNibName:nil bundle:nil];
    videoController.detectRect = CGRectMake(100, 100, 300, 300);
    videoController.videoSize = CGSizeMake(480, 640);
    videoController.videoManager = videoManager;
    videoController.markManager = markManager;
    videoController.debug = NO;
    videoController.pointsNum = 81;
    videoController.show3D = YES;
    videoController.faceInfo = YES;
    videoController.faceCompare = NO;
    [self.navigationController pushViewController:videoController animated:YES];
}

- (AVCaptureDevicePosition)getCamera:(BOOL)index{
    AVCaptureDevicePosition tempVideo;
    if (index == NO) {
        tempVideo = AVCaptureDevicePositionFront;
    }else{
        tempVideo = AVCaptureDevicePositionBack;
    }
    return tempVideo;
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

-(UILabel *)sessionKeyLabel {
    if (_sessionKeyLabel) {
        return _sessionKeyLabel;
    }
    _sessionKeyLabel = [[UILabel alloc] init];
    _sessionKeyLabel.textColor = [UIColor greenColor];
    RAC(_sessionKeyLabel, text) = RACObserve([RSLoginService shareInstance].loginInfo, sessionKey);
    return _sessionKeyLabel;
}
-(UILabel *)uidLabel {
    if (_uidLabel) {
        return _uidLabel;
    }
    _uidLabel = [[UILabel alloc] init];
    _uidLabel.textColor = [UIColor greenColor];
    RAC(_uidLabel, text) = RACObserve([RSLoginService shareInstance].loginInfo, uid);
    return _uidLabel;
}
-(UIButton *)logoutButton {
    if (_logoutButton) {
        return _logoutButton;
    }
    _logoutButton = [[UIButton alloc] init];
    [_logoutButton setTitle:@"logout" forState:UIControlStateNormal];
    [_logoutButton setBackgroundColor:[UIColor greenColor]];
    [_logoutButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [[RSLoginService shareInstance] logout];
    }];
    return _logoutButton;
}

-(UIButton *)takePhotoButton {
    if (_takePhotoButton) {
        return _takePhotoButton;
    }
    _takePhotoButton = [[UIButton alloc] init];
    [_takePhotoButton setTitle:@"take photo" forState:UIControlStateNormal];
    [_takePhotoButton setBackgroundColor:[UIColor greenColor]];
    @weakify(self);
    [_takePhotoButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        @RSStrongify(self);
        [self showVideoViewController];
    }];
    return _takePhotoButton;
}
@end
