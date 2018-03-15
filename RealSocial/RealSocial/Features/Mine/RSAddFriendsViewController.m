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
#import "RSContactService.h"
@interface RSAddFriendsViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIButton *wxAdd, *successBtn, *okBtn, *reTryBtn, *wxAddBtn;
@property (nonatomic, strong) UILabel *readyTitle, *readyTip, *faildTitle, *faildTip,*takePhotoTip, *succedTip, *friendName;


@property (nonatomic, strong) RSAvatarImageView *headImageOne;
@property (nonatomic, strong) UIView *successLine, *coverView, *bottomView;
@property (nonatomic, strong) UIImageView *myImageView;

@property (nonatomic, strong) UIImagePickerController *myPicker;

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
    
    self.myPicker.delegate = self;
    
    
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
    [self.contentView removeAllSubviews];
    [self.contentView addSubview:self.line];
    [self.faildTitle removeFromSuperview];
    [self.faildTip removeFromSuperview];
    [self.view sendSubviewToBack:self.contentView];
    [self.contentView addSubview:self.myImageView];
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
        
       
        [self.contentView addSubview:self.headImageOne];
        [self.contentView addSubview:self.friendName];
        [self.contentView addSubview:self.okBtn];
        [self.contentView addSubview:self.succedTip];
        [self.contentView addSubview:self.bottomView];
        self.headImageOne.url = [dic objectForKey:@"friendHeadImageUrl"];
        self.friendName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"friendName"]];
        
        switch ([[dic objectForKey:@"opCode"] intValue]) {
            case 1:
            self.succedTip.text = @"已发送好友申请，等待对方确认";
            break;
            case 2:
            self.succedTip.text = @"已是好友";
            break;
            case 3:
            self.succedTip.text = @"已加好友";
            break;
            default:
            break;
        }
        
        
        
        [self.headImageOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.contentView).with.offset(188);
        }];
        
        [self.friendName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.headImageOne.mas_bottom).mas_offset(10);
        }];
        [self.succedTip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.friendName.mas_bottom).mas_offset(8);
        }];
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.bottom.equalTo(self.contentView.mas_bottom).mas_offset(-20);
            make.height.mas_equalTo(18);
            make.width.mas_equalTo(170);
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
    [self.reTryBtn removeFromSuperview];
    [self.wxAddBtn removeFromSuperview];
    
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
//        [_wxAdd addTarget:self action:@selector(actionPress) forControlEvents:UIControlEventTouchUpInside];
        
                [_wxAdd addTarget:self action:@selector(choosePicture) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _wxAdd;
}

- (UIImagePickerController *)myPicker{
    if (!_myPicker) {
         _myPicker = [[UIImagePickerController alloc] init];
        UIImagePickerControllerSourceType mySourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _myPicker.sourceType = mySourceType;
        _myPicker.delegate = self;
        _myPicker.allowsEditing = YES;
       
    }
        return _myPicker;
}

-(void)choosePicture{
  
    //通过模态的方式推出系统相册
    [self presentViewController:self.myPicker animated:YES completion:^{
        NSLog(@"进入相册");
//        self.myPicker.delegate = self;
    }];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
//    取得所选取的图片,原大小,可编辑等，info是选取的图片的信息字典
        UIImage *selectImage = [info objectForKey:UIImagePickerControllerOriginalImage];
         NSLog(@"模态返回") ;
        //设置图片进相框
        self.myImageView.image = selectImage;
   
    [picker dismissViewControllerAnimated:YES completion:^{
         NSLog(@"模态返回") ;
    }];

}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"2222222");
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

- (UIImageView *)myImageView{
    if (!_myImageView) {
        _myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        
    }
    return _myImageView;
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
        _headImageOne.type = RSAvatarImageViewType80;
    }
    return _headImageOne;
}


- (UILabel *)friendName{
    if (!_friendName) {
        _friendName = [[UILabel alloc] init];
        _friendName.text = @"与 彩雪asaya 成为好友";
        _friendName.font = [UIFont fontWithName:@"PingFang-SC-Semibold" size:17];
        _friendName.lineBreakMode = NSLineBreakByWordWrapping|NSLineBreakByTruncatingTail;
        _friendName.numberOfLines = 2;
        [_friendName setTextColor:[UIColor main2]];
        _friendName.textAlignment = NSTextAlignmentCenter;
    }
    return _friendName;
}

- (UILabel *)succedTip{
    if(!_succedTip){
        _succedTip = [[UILabel alloc] init];
        [_succedTip setTextColor:RGBA(9, 10, 70, .4f)];
        _succedTip.textAlignment = NSTextAlignmentCenter;
        _succedTip.font = [UIFont systemFontOfSize:14];
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
    
- (UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc] init];
        UILabel *lableOne = [self getText:@"不是TA，"];
        UILabel *lableTwo = [self getText:@" 或 "];
        UIButton *btnOne = [self getBtn:@"重拍一张" action:@selector(reReadyAddFriends)];
        UIButton *btnTwo = [self getBtn:@"微信邀请" action:nil];
        [_bottomView addSubview:lableOne];
        [_bottomView addSubview:lableTwo];
        [_bottomView addSubview:btnOne];
        [_bottomView addSubview:btnTwo];
        
        [lableOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_bottomView.mas_left);
            make.centerY.mas_equalTo(_bottomView.mas_centerY);
            
        }];
        [btnOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lableOne.mas_right);
            make.centerY.mas_equalTo(_bottomView.mas_centerY);
            
        }];
        [lableTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(btnOne.mas_right);
            make.centerY.mas_equalTo(_bottomView.mas_centerY);
            
        }];
        [btnTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lableTwo.mas_right);
            make.centerY.mas_equalTo(_bottomView.mas_centerY);
            
        }];
        
    }
    return _bottomView;
}

- (UILabel *)getText:(NSString *)text{
    UILabel *lable = [[UILabel alloc] init];
    [lable setTextColor:RGBA(9, 10, 70, .4f)];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = [UIFont systemFontOfSize:12];
    lable.text = text;
    return lable;
}

- (void)reReadyAddFriends{
    [self readyAddFriends];
    [self startRunning];
}
    
- (UIButton *)getBtn:(NSString *)title action:(SEL)action{
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:title attributes:attribtDic];
    [attribtStr addAttribute:NSForegroundColorAttributeName value:RGBA(9, 10, 70, .4f)  range:NSMakeRange(0,[attribtStr length])];
    [attribtStr addAttribute:NSUnderlineColorAttributeName value:RGBA(9, 10, 70, .4f) range:(NSRange){0,[attribtStr length]}];
    UIButton *btn = [[UIButton alloc] init];
    [btn setAttributedTitle:attribtStr forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
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
    
    
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self dismissCamera];
}

@end

