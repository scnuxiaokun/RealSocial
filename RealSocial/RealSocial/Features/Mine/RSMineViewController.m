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
#import "RSAddFriendsViewController.h"
#import "DBCameraViewController.h"
#import "RSCustomCamera.h"
#import "DBMotionManager.h"
#import "RSAddFriendsViewModel.h"
#import "RSSettingViewController.h"
#import "RSContactService.h"
#import "UIButton+WebCache.h"
@interface RSMineViewController ()<DBCameraViewControllerDelegate>
/*
 @property (nonatomic, strong) UIImageView *avatarImageView;
 @property (nonatomic, strong) UIButton *logoutButton;
 @property (nonatomic, strong) UILabel *sessionKeyLabel;
 @property (nonatomic, strong) UILabel *uidLabel;
 @property (nonatomic, strong) UIButton *takePhotoButton;
 @property (nonatomic, strong) UIButton *uploadPhotoButton;
 @property (nonatomic, strong) UIButton *pictureListButton;
 @property (nonatomic, strong) UIButton *clearImageButon;
 */

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIButton *headImage;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIButton *messageBtn;
@property (nonatomic, strong) UIButton *memoirBtn;
@property (nonatomic, strong) UIButton *wdfBtn;
@property (nonatomic, strong) UIButton *photographBtn;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIView *scrollLine;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *background;
@property (nonatomic, strong) UIScrollView *content;
@property (nonatomic, strong) RSAddFriendsViewController *addFriend;
@end

@implementation RSMineViewController
-(UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] init];
        [_topView addSubview:self.headImage];
        [_topView addSubview:self.addBtn];
        [_topView addSubview:self.messageBtn];
    }
    return _topView;
}
-(UIButton *)headImage{
    if (!_headImage) {
        _headImage = [[UIButton alloc] init];
        
        [_headImage sd_setImageWithURL:[NSURL URLWithString:[[RSContactService shareInstance] getMyAvatarUrl]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"defaultAvatar"]];
        
        UIImageView *image = [[UIImageView alloc] init];
        [image setImage:[UIImage imageNamed:@"btn-memoir-setting"]];
        
        
        [_headImage addTarget:self action:@selector(settingCenter) forControlEvents:UIControlEventTouchUpInside];
        _headImage.layer.cornerRadius = 40;
        //_headImage.layer.masksToBounds = YES;
        [_headImage addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_headImage.mas_bottom).mas_offset(-10);
            make.centerX.mas_equalTo(_headImage.mas_centerX);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(20);
        }];
    }
    return _headImage;
}
-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [[UIButton alloc] init];
        [_addBtn setImage:[UIImage imageNamed:@"btn-memoir-add"] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addFriends) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _addBtn;
}
-(UIButton *)messageBtn{
    if (!_messageBtn) {
        _messageBtn = [[UIButton alloc] init];
        [_messageBtn setImage:[UIImage imageNamed:@"btn-memoir-comment"] forState:UIControlStateNormal];
    }
    return _messageBtn;
}
-(UIButton *)memoirBtn{
    if (!_memoirBtn) {
        _memoirBtn = [[UIButton alloc] init];
        [_memoirBtn setTitle:@"回忆录" forState:UIControlStateNormal];
        _memoirBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _memoirBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Semibold" size:14];
        [_memoirBtn setTitleColor:RGB(9, 10, 70) forState:UIControlStateNormal];
        [_memoirBtn addTarget:self action:@selector(memoirBtnPress) forControlEvents:(UIControlEventTouchUpInside)];
        _memoirBtn.alpha = 1.0f;
    }
    return _memoirBtn;
}
-(UIButton *)wdfBtn{
    if (!_wdfBtn) {
        _wdfBtn = [[UIButton alloc] init];
        [_wdfBtn setTitle:@"精彩瞬间" forState:UIControlStateNormal];
        _wdfBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _wdfBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Semibold" size:14];
        [_wdfBtn setTitleColor:RGB(9, 10, 70) forState:UIControlStateNormal];
        [_wdfBtn addTarget:self action:@selector(wdfBtnPress) forControlEvents:UIControlEventTouchUpInside];
        _wdfBtn.titleLabel.alpha = .4f;
    }
    return _wdfBtn;
}
-(UIButton *)photographBtn{
    if (!_photographBtn) {
        _photographBtn = [[UIButton alloc] init];
        _photographBtn.backgroundColor = [UIColor whiteColor];
        _photographBtn.layer.cornerRadius = 39;
        _photographBtn.layer.masksToBounds = YES;
        [_photographBtn setImage:[UIImage imageNamed:@"btn-camera"] forState:UIControlStateNormal];
    }
    return _photographBtn;
}
-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = RGB(227, 227, 227);
    }
    return _line;
}

-(UIView *)scrollLine{
    if (!_scrollLine) {
        _scrollLine = [[UIView alloc] init];
        _scrollLine.backgroundColor = RGB(253, 183, 9);
    }
    return _scrollLine;
}

-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-140, SCREEN_WIDTH, 140)];
        UIColor *colorOne = RGBA(245, 245, 246, 1.0);
        UIColor *colorTwo = RGBA(245, 245, 245, 0.7);
        NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.startPoint = CGPointMake(0, 0);
        gradient.endPoint = CGPointMake(0, 1);
        gradient.colors = colors;
        gradient.frame = CGRectMake(0, 0, SCREEN_WIDTH, 140);
        [_bottomView.layer insertSublayer:gradient atIndex:0];
    }
    return _bottomView;
}

-(UIView *)background{
    if (!_background) {
        _background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-140)];
        _background.backgroundColor = RGB(245, 245, 245);
    }
    return _background;
}

-(UIScrollView *)content{
    if (!_content) {
        _content = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, 300)];
        [_content setContentSize:CGSizeMake(SCREEN_WIDTH*1, 300)];
        UIView* viewOne = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
        viewOne.backgroundColor = [UIColor redColor];
        [_content addSubview:viewOne];
    }
    return _content;
}

- (void)memoirBtnPress{
    [UIView animateWithDuration:.2f delay:0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        self.scrollLine.centerX = self.memoirBtn.centerX;
        self.memoirBtn.titleLabel.alpha = 1;
        self.wdfBtn.titleLabel.alpha = .4f;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)wdfBtnPress{
    [UIView animateWithDuration:.2f delay:0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        self.scrollLine.centerX = self.wdfBtn.centerX;
        self.wdfBtn.titleLabel.alpha = 1;
        self.memoirBtn.titleLabel.alpha = .4f;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)settingCenter{
    RSSettingViewController *settingVC = [[RSSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)addFriends{
    UIAlertController *alert=[[UIAlertController alloc]init];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"添加好友" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action){
        
        
        CGFloat width = 355/734.0f*(SCREEN_HEIGHT-64);
        RSCustomCamera *camera = [RSCustomCamera initWithFrame:CGRectMake((SCREEN_WIDTH-width)/2, 172, width, width)];
        [camera buildInterface];
        camera.layer.cornerRadius = width/2.0f;
        camera.layer.masksToBounds = YES;

        RSAddFriendsViewController* addFriends = [[RSAddFriendsViewController alloc] initWithDelegate:self cameraView:camera];
        
        
        addFriends.triggerAction  = ^(NSString *str){
            [camera triggerAction];
        };

        [addFriends setUseCameraSegue:NO];
        
        
        
        self.addFriend =addFriends;
        [self.navigationController pushViewController:addFriends animated:YES];
        
        NSLog(@"添加好友");
    }];
    [alert addAction:action];
    UIAlertAction *action2=[UIAlertAction actionWithTitle:@"新建圈子" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action){
        
    }];
    [alert addAction:action2];
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action){
        NSLog(@"你点击了取消");
    }];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}

#pragma mark DBCamera delegate

- (void) dismissCamera:(id)cameraViewController{
    [cameraViewController restoreFullScreenMode];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)camera:(id)cameraViewController didFinishWithImage:(UIImage *)image withMetadata:(NSDictionary *)metadata{
    [cameraViewController restoreFullScreenMode];

    [self.addFriend addingFriends];
    NSLog(@"66666666666666");
    [self uploadImageAndAddFriends:image isUploadImage:NO];
    
}

- (void)uploadImageAndAddFriends:(UIImage *)image isUploadImage:(BOOL)isUploadImage{
    [[RSAddFriendsViewModel createToAddFriends:image isUploadImage:isUploadImage ] subscribeNext:^(id  _Nullable x) {
        [self.addFriend succedAddFriends:x];
        
    } error:^(NSError * _Nullable error) {
        ErrorType errorType = [RSError sharedError].errorType;
        [self.addFriend faildAddFriendsWithErrorType:errorType];
        switch (errorType) {
            case UploadImageToCDNError:
            {       __weak __typeof(self) weakSelf = self;
                    self.addFriend.reTry = ^(){
                    [weakSelf uploadImageAndAddFriends:image isUploadImage:NO];
                };
                
            }
                break;
            case AddFriendNetError:
            {       __weak __typeof(self) weakSelf = self;
                self.addFriend.reTry = ^(){
                    [weakSelf uploadImageAndAddFriends:image isUploadImage:YES];
                };
                
            }
                break;
            case AddFriendImageError:
            {       __weak __typeof(self) weakSelf = self;
                self.addFriend.reTry = ^(){
                   // [weakSelf uploadImageAndAddFriends:image isUploadImage:YES];
                };
                
            }
                break;
            default:
                break;
        }
        
    } completed:^{
        NSLog(@"222222222");
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor clearColor];
    
    
    [self.view addSubview:self.background];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.memoirBtn];
    [self.view addSubview:self.wdfBtn];
    [self.view addSubview:self.line];
    [self.view addSubview:self.scrollLine];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.photographBtn];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(0);
        make.top.equalTo(self.view).with.offset(60);
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.topView);
        make.height.mas_equalTo(80);
        make.width.mas_equalTo(80);
    }];
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topView);
        make.left.equalTo(self.topView).with.offset(20);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(28);
    }];
    
    [self.messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topView);
        make.right.equalTo(self.topView).with.offset(-20);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(28);
    }];
    
    [self.memoirBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView).with.offset(100);
        make.left.equalTo(self.view).with.offset(0);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(SCREEN_WIDTH/2.0f);
    }];
    
    [self.wdfBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView).with.offset(100);
        make.right.equalTo(self.view).with.offset(0);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(SCREEN_WIDTH/2.0f);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(0);
        make.top.equalTo(self.view).with.offset(200);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    [self.scrollLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(199);
        make.centerX.equalTo(self.memoirBtn);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(148);
    }];
    
    [self.photographBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.view).with.offset(-58);
//        make.centerX.equalTo(self.view);
//        make.height.mas_equalTo(78);
//        make.width.mas_equalTo(78);
        [self.photographBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        }];
    }];
    
    
    
    
    
    
    /*
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
     */
    
    
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

/*
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
 }*/


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
/*
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
 */
@end

