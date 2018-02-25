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
#import "RSImageUploadController.h"
#import "MGFaceLicenseHandle.h"
#import "MGMarkSetViewController.h"
#import "UIImageView+WebCache.h"
#import "RSPictureListViewController.h"
#import <SDImageCache.h>
#import <LGAlertView.h>

@interface RSMineViewController ()
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UIButton *logoutButton;
@property (nonatomic, strong) UILabel *sessionKeyLabel;
@property (nonatomic, strong) UILabel *uidLabel;
@property (nonatomic, strong) UIButton *takePhotoButton;
@property (nonatomic, strong) UIButton *uploadPhotoButton;
@property (nonatomic, strong) UIButton *pictureListButton;
@property (nonatomic, strong) UIButton *clearImageButon;
@end

@implementation RSMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.uidLabel];
    [self.contentView addSubview:self.sessionKeyLabel];
    [self.contentView addSubview:self.logoutButton];
    [self.contentView addSubview:self.takePhotoButton];
    [self.contentView addSubview:self.uploadPhotoButton];
    [self.contentView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.pictureListButton];
    [self.contentView addSubview:self.clearImageButon];
    
    [self.uidLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(20);
        make.top.equalTo(self.contentView).with.offset(kNaviBarHeightAndStatusBarHeight);
    }];
    [self.sessionKeyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(20);
        make.top.equalTo(self.uidLabel.mas_bottom).with.offset(0);
    }];
    [self.takePhotoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sessionKeyLabel.mas_bottom).with.offset(50);
        make.centerX.equalTo(self.contentView);
    }];
    [self.uploadPhotoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.takePhotoButton.mas_bottom).with.offset(50);
        make.centerX.equalTo(self.contentView);
    }];
    [self.logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
    [self.pictureListButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoutButton.mas_bottom).with.offset(20);
        make.centerX.equalTo(self.contentView);
    }];
    [self.clearImageButon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pictureListButton.mas_bottom).with.offset(20);
        make.centerX.equalTo(self.contentView);
    }];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.centerX.equalTo(self.contentView);
    }];
    
    
    /** 进行联网授权版本判断，联网授权就需要进行网络授权 */
//    BOOL needLicense = [MGFaceLicenseHandle getNeedNetLicense];
//    
//    if (needLicense) {
////        self.videoBtn.userInteractionEnabled = NO;
//        [MGFaceLicenseHandle licenseForNetwokrFinish:^(bool License, NSDate *sdkDate) {
//            if (!License) {
//                NSLog(@"联网授权失败 ！！！");
//                assert(NO);
//            } else {
//                NSLog(@"联网授权成功");
////                self.videoBtn.userInteractionEnabled = YES;
//            }
//        }];
//    } else {
//        NSLog(@"SDK 为非联网授权版本！");
//    }
}

-(void)showVideoViewController {
    MGMarkSetViewController *ctr =  [[MGMarkSetViewController alloc] initWithNibName:nil bundle:nil];
    ctr.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ctr animated:YES];
    return;
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:KMGFACEMODELNAME ofType:@""];
    NSData *modelData = [NSData dataWithContentsOfFile:modelPath];
    int maxFaceCount = 0;
    int faceSize = 100;
    int internal = 40;
    MGDetectROI detectROI = MGDetectROIMake(0, 0, 0, 0);
    MGFacepp *markManager = [[MGFacepp alloc] initWithModel:modelData
                                               maxFaceCount:1
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
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:videoController];
    [self.navigationController presentViewController:navi animated:YES completion:nil];
//    [self.navigationController pushViewController:videoController animated:YES];
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
//    RAC(_sessionKeyLabel, text) = RACObserve([RSLoginService shareInstance].loginInfo, sessionKey);
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
    [_takePhotoButton setTitle:@"视频流demo" forState:UIControlStateNormal];
    [_takePhotoButton setBackgroundColor:[UIColor greenColor]];
    @weakify(self);
    [_takePhotoButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        @RSStrongify(self);
        [self showVideoViewController];
    }];
    return _takePhotoButton;
}

-(UIButton *)clearImageButon {
    if (_clearImageButon) {
        return _clearImageButon;
    }
    _clearImageButon = [[UIButton alloc] init];
    [_clearImageButon setTitle:@"清理图片缓存" forState:UIControlStateNormal];
    [_clearImageButon setBackgroundColor:[UIColor greenColor]];
//    @weakify(self);
    [_clearImageButon addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [[SDWebImageManager sharedManager].imageCache clearDiskOnCompletion:^{
            [[SDWebImageManager sharedManager].imageCache clearMemory];
            [RSUtils showTipViewWithMessage:@"清理成功"];
        }];
    }];
    return _clearImageButon;
}

-(UIButton *)uploadPhotoButton {
    if (_uploadPhotoButton) {
        return _uploadPhotoButton;
    }
    _uploadPhotoButton = [[UIButton alloc] init];
    [_uploadPhotoButton setTitle:@"上传照片" forState:UIControlStateNormal];
    [_uploadPhotoButton setBackgroundColor:[UIColor greenColor]];
    @weakify(self);
    [_uploadPhotoButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        @RSStrongify(self);
        RSImageUploadController *ctr = [[RSImageUploadController alloc] init];
        [self.navigationController pushViewController:ctr animated:YES];
    }];
    return _uploadPhotoButton;
}

-(UIImageView *)avatarImageView {
    if (_avatarImageView) {
        return _avatarImageView;
    }
    _avatarImageView = [[UIImageView alloc] init];
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:@"http://blog.chinaunix.net/image/default/1.png"]];
    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
    }];
    return _avatarImageView;
}

-(UIButton *)pictureListButton {
    if (_pictureListButton) {
        return _pictureListButton;
    }
    _pictureListButton = [[UIButton alloc] init];
    [_pictureListButton setTitle:@"本地照片列表" forState:UIControlStateNormal];
    [_pictureListButton setBackgroundColor:[UIColor greenColor]];
    @weakify(self);
    [_pictureListButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        @RSStrongify(self);
        RSPictureListViewController *ctr = [[RSPictureListViewController alloc] init];
        [self.navigationController pushViewController:ctr animated:YES];
    }];
    return _pictureListButton;
}
@end
