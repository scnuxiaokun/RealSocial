//
//  RSAddFriendsViewController.m
//  RealSocial
//
//  Created by 蒋陈浩 on 2018/3/8.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSAddFriendsViewController.h"
#import "UIImageView+WebCache.h"
#import "RSAvatarImageView.h"
@interface RSAddFriendsViewController ()<DBCameraViewControllerDelegate>
@property (nonatomic, strong) UIButton *wxAdd, *successBtn, *okBtn, *reTryBtn, *wxAddBtn;
@property (nonatomic, strong) UILabel *readyTitle, *readyTip, *faildTitle, *faildTip,*takePhotoTip, *succedTip;


@property (nonatomic, strong) RSAvatarImageView *headImageOne, *headImageTwo;
@property (nonatomic, strong) UIView *successLine, *coverView;

@end

@implementation RSAddFriendsViewController

-(instancetype)initWithDelegate:(id<DBCameraViewControllerDelegate>)delegate cameraView:(id)camera {
    self = [super initWithDelegate:delegate cameraView:camera];
    if (self) {
        self.isDefaultBackCamera = NO;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor main1];
    self.contentView.layer.cornerRadius = 10;
    self.contentView.layer.masksToBounds = YES;
    //添加视图
    
    
    [self readyAddFriends];
    
    [self.contentView addSubview:self.coverView];
    CGFloat width = 363/734.0f*(SCREEN_HEIGHT-64);
    [self.coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.customCamera);
        make.height.mas_equalTo(width);
        make.width.mas_equalTo(width);
    }];
   
    
}



#pragma mark Function
- (void)actionPress{
    self.triggerAction(@"1");
}

- (void)readyAddFriends{
    [self.reTryBtn removeFromSuperview];
    [self.wxAddBtn removeFromSuperview];
    [self.faildTitle removeFromSuperview];
    [self.faildTip removeFromSuperview];
    
    [self.contentView addSubview:self.readyTitle];
    [self.contentView addSubview:self.readyTip];
    [self.contentView addSubview:self.takePhotoTip];
    [self.contentView addSubview:self.wxAdd];
    
    
    [self.readyTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(20);
        make.top.equalTo(self.contentView).with.offset(40);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(90);
    }];
    
    [self.readyTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(20);
        make.top.equalTo(self.readyTitle).with.offset(33);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(274);
    }];
    
    [self.takePhotoTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.customCamera);
        make.top.equalTo([(UIView*)self.customCamera mas_bottom]).with.offset(10);
//        make.height.mas_equalTo(18);
//        make.width.mas_equalTo(142);
    }];
    [self.wxAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).with.offset(-30);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(80);
    }];
}

- (void)addingFriends{
    
    [self.readyTitle removeFromSuperview];
    [self.readyTip removeFromSuperview];
    [self.takePhotoTip removeFromSuperview];
    [self.wxAdd removeFromSuperview];
    self.faildTitle.text = @"发送合照给好友";
    self.faildTip.text = @"好友打开APP，进入添加好友界面即可收到合照成为好友";
    [self.contentView addSubview:self.faildTitle];
    [self.contentView addSubview:self.faildTip];
    
    [self.faildTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo([(UIView *)self.customCamera mas_bottom]).with.offset(20);
//        make.height.mas_equalTo(24);
//        make.width.mas_equalTo(230);
    }];
    
    [self.faildTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.faildTitle).with.offset(40);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(240);
    }];
    
    
    
    
}

- (void)succedAddFriends:(NSDictionary *)dic{
    
    [UIView animateWithDuration:.2f animations:^{
        [self.faildTitle removeFromSuperview];
        [self.faildTip removeFromSuperview];
        [self.wxAdd removeFromSuperview];
        [self.coverView removeFromSuperview];
        [self.view bringSubviewToFront:self.contentView];
    } completion:^(BOOL finished) {
        
        [self.contentView addSubview:self.headImageTwo];
        [self.contentView addSubview:self.headImageOne];
        [self.contentView addSubview:self.succedTip];
        [self.contentView addSubview:self.okBtn];
        self.headImageOne.url = [dic objectForKey:@"headImageOne"];
        self.headImageTwo.url = [dic objectForKey:@"headImageTwo"];
        self.succedTip.text = [NSString stringWithFormat:@"与 %@ 成为好友",[dic objectForKey:@"friendName"]];
        
        
        [self.headImageOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).with.offset(98);
            make.top.equalTo(self.contentView).with.offset(188);
            make.height.mas_equalTo(120);
            make.width.mas_equalTo(120);
        }];
        
        [self.headImageTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).with.offset(158);
            make.top.equalTo(self.contentView).with.offset(248);
            make.height.mas_equalTo(120);
            make.width.mas_equalTo(120);
        }];
        
        
    }];
    
}

- (void)faildAddFriendsWithErrorType:(ErrorType)errorType{
    
    switch (errorType) {
        case AddFriendImageError:
        {
            [self.reTryBtn setTitle:@"再拍一张" forState:(UIControlStateNormal)];
        }
            break;
        default:{
            [self.reTryBtn setTitle:@"重试" forState:(UIControlStateNormal)];
        }
            break;
    }
    [self.wxAdd removeFromSuperview];
    [self.readyTitle removeFromSuperview];
    [self.readyTip removeFromSuperview];
    [self.takePhotoTip removeFromSuperview];
    
    
    self.faildTitle.text = @"身边未找到好友";
    self.faildTip.text = @"请让好友进入添加好友页面等待，若好友尚未安装app，可发送微信邀请";
    [self.contentView addSubview:self.reTryBtn];
    [self.contentView addSubview:self.wxAddBtn];
    [self.reTryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.reTryBtn.width);
        make.height.mas_equalTo(self.reTryBtn.height);
        make.bottom.equalTo(self.contentView.mas_safeAreaLayoutGuideBottom).with.offset(-20);
        make.right.equalTo(self.contentView.mas_centerX).with.offset(-50);
    }];
    [self.wxAddBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.wxAddBtn.width);
        make.height.mas_equalTo(self.wxAddBtn.height);
        make.bottom.equalTo(self.reTryBtn);
        make.left.equalTo(self.contentView.mas_centerX).with.offset(50);
    }];

//    CGFloat width = 355/734.0f*(SCREEN_HEIGHT-64)-1.0f;
//    [self.customCamera mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
//        make.top.equalTo(self.view).with.offset(100);
//        make.height.mas_equalTo(width);
//        make.width.mas_equalTo(width);
//    }];
    
}

- (void)reTryAddFrinends{
    
    ErrorType errorType = [RSError sharedError].errorType;
    switch (errorType) {
        case UploadImageToCDNError:
        {
            self.reTry();
        }
            break;
        case AddFriendNetError:
        {
            self.reTry();
        }
            break;
        case AddFriendImageError:
        {
            [self readyAddFriends];
            [self startRunning];
        }
            break;
        default:
            break;
    }
    
}


- (void)viewDidDisappear:(BOOL)animated{
    self.view.backgroundColor = [UIColor clearColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark UI懒加载

//开始准备拍照加好友
-(UILabel *)readyTitle{
    if (!_readyTitle) {
        _readyTitle = [[UILabel alloc] init];
        _readyTitle.text = @"添加好友";
        _readyTitle.font = [UIFont fontWithName:@"PingFang-SC-Semibold" size:20];
        [_readyTitle setTextColor:[UIColor main2]];
    }
    return _readyTitle;
}
-(UILabel *)readyTip{
    if (!_readyTip) {
        _readyTip = [[UILabel alloc] init];
        _readyTip.text = @"一起拍个合照，在哪你们都是好友";
        _readyTip.font = [UIFont fontWithName:@"PingFang-SC-Semibold" size:14];
        [_readyTip setTextColor:RGBA(9, 10, 70, .4f)];
    }
    return _readyTip;
}
-(UILabel *)faildTitle{
    if (!_faildTitle) {
        _faildTitle = [[UILabel alloc] init];
        
        _faildTitle.font = [UIFont fontWithName:@"PingFang-SC-Semibold" size:17];
        [_faildTitle setTextColor:[UIColor main2]];
        _faildTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _faildTitle;
}

-(UILabel *)faildTip{
    if (!_faildTip) {
        _faildTip = [[UILabel alloc] init];
        _faildTip.text = @"好友打开APP，进入添加好友界面即可收到合照成为好友";
        _faildTip.font = [UIFont fontWithName:@"PingFang-SC-Semibold" size:14];
        _faildTip.lineBreakMode = NSLineBreakByWordWrapping|NSLineBreakByTruncatingTail;
        _faildTip.numberOfLines = 2;
        [_faildTip setTextColor:RGBA(9, 10, 70, .4f)];
        _faildTip.textAlignment = NSTextAlignmentCenter;
    }
    return _faildTip;
}

//正在加好友



-(UIButton *)wxAdd{
    if (!_wxAdd) {
        _wxAdd = [[UIButton alloc] init];
        [_wxAdd setTitle:@"微信邀请" forState:UIControlStateNormal];
        _wxAdd.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Semibold" size:12];
        [_wxAdd setTitleColor:RGBA(9, 10, 70, .4f) forState:UIControlStateNormal];
        [_wxAdd setImage:[UIImage imageNamed:@"wx-add"] forState:UIControlStateNormal];
        [_wxAdd setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
        [_wxAdd addTarget:self action:@selector(actionPress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wxAdd;
}

-(UIView *)coverView{
    if (!_coverView) {
        _coverView = [[UIView alloc] init];
        _coverView.layer.borderWidth = 8;
        _coverView.layer.borderColor = [RGB(254, 213, 24) CGColor];
        _coverView.layer.cornerRadius = 363/734.0f*(SCREEN_HEIGHT-64)/2;
        _coverView.layer.masksToBounds = YES;
        _coverView.backgroundColor = [UIColor clearColor];
    }
    return _coverView;
}
-(UILabel *)takePhotoTip{
    if (!_takePhotoTip) {
        _takePhotoTip = [[UILabel alloc] init];
        _takePhotoTip.text = @"轻按拍摄区域拍照";
        _takePhotoTip.font = [UIFont fontWithName:@"PingFang-SC-Semibold" size:12];
        [_takePhotoTip setTextColor:RGBA(9, 10, 70, .4f)];
        _takePhotoTip.textAlignment = NSTextAlignmentCenter;
    }
    return _takePhotoTip;
}

//成功加好友
- (RSAvatarImageView *)headImageOne{
    if (!_headImageOne) {
        _headImageOne = [[RSAvatarImageView alloc] init];
        _headImageOne.type = RSAvatarImageViewType120;
    }
    return _headImageOne;
}

- (RSAvatarImageView *)headImageTwo{
    if (!_headImageTwo) {
        _headImageTwo = [[RSAvatarImageView alloc] init];
        _headImageTwo.type = RSAvatarImageViewType120;
    }
    return _headImageTwo;
}
- (UILabel *)succedTip{
    if (!_succedTip) {
        _succedTip = [[UILabel alloc] initWithFrame:CGRectMake(0, 398, SCREEN_WIDTH, 24)];
        _succedTip.text = @"与 彩雪asaya 成为好友";
        _succedTip.font = [UIFont fontWithName:@"PingFang-SC-Semibold" size:17];
        _succedTip.lineBreakMode = NSLineBreakByWordWrapping|NSLineBreakByTruncatingTail;
        _succedTip.numberOfLines = 2;
        [_succedTip setTextColor:[UIColor main2]];
        _succedTip.textAlignment = NSTextAlignmentCenter;
    }
    return _succedTip;
}
-(UIButton *)okBtn{
    if (!_okBtn) {
        _okBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-60)/2, self.contentView.height-134, 60, 60)];
        [_okBtn setImage:[UIImage imageNamed:@"btn-confirm-hl"] forState:UIControlStateNormal];
        [_okBtn addTarget:self action:@selector(toRootView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _okBtn;
}

- (void)toRootView{
    [self.navigationController popViewControllerAnimated:YES];
}

//加好友失败

- (UIButton *)reTryBtn{
    if (!_reTryBtn) {
        _reTryBtn = [[UIButton alloc] initWithFrame:CGRectMake(78, self.contentView.height-90, 60, 90)];
        [_reTryBtn setImage:[UIImage imageNamed:@"btn-profile-share"] forState:UIControlStateNormal];
        [_reTryBtn setTitle:@"重试" forState: UIControlStateNormal];
        [_reTryBtn setTitleColor:[UIColor main2] forState:UIControlStateNormal];
        [_reTryBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_reTryBtn setImageEdgeInsets:UIEdgeInsetsMake(-25, 0, 0, 0)];
        [_reTryBtn setTitleEdgeInsets:UIEdgeInsetsMake(65, -60, 0, 0)];
        [_reTryBtn addTarget:self action:@selector(reTryAddFrinends) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reTryBtn;
}

- (UIButton *)wxAddBtn{
    if (!_wxAddBtn) {
        _wxAddBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-78-60, self.contentView.height-90, 60, 90)];
        [_wxAddBtn setImage:[UIImage imageNamed:@"btn-profile-share"] forState:UIControlStateNormal];
        [_wxAddBtn setTitle:@"微信邀请" forState: UIControlStateNormal];
        [_wxAddBtn setTitleColor:[UIColor main2] forState:UIControlStateNormal];
        [_wxAddBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_wxAddBtn setImageEdgeInsets:UIEdgeInsetsMake(-25, 0, 0, 0)];
        [_wxAddBtn setTitleEdgeInsets:UIEdgeInsetsMake(65, -60, 0, 0)];
    }
    return _wxAddBtn;
}

@end

