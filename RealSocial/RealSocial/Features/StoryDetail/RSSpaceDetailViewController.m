//
//  RSStoryDetailViewController.m
//  RealSocial
//
//  Created by kuncai on 2018/2/8.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSSpaceDetailViewController.h"
#import <UIImageView+WebCache.h>
#import "RSPhotoBrower.h"
#import "RSMineViewController.h"
#import "RSSpaceDetailAddCommentView.h"
#import "RSSpaceDetailTouchAddCommentView.h"
#import "RSAvatarImageView.h"
@interface RSSpaceDetailViewController () <UIScrollViewDelegate>

//photo brower
@property (nonatomic, strong) UIScrollView *mediaScrollView;
@property (nonatomic, assign) NSInteger imageViewArrayCount;
@property (nonatomic, strong) NSMutableArray *imageViewArray;
@property (nonatomic, strong) NSMutableArray *freeImageViewArray;
@property (nonatomic, assign) NSInteger imageCount;
@property (nonatomic, strong) UIImageView *nextImageView;
@property (nonatomic, strong) UIImageView *preImageView;
@property (nonatomic, strong) UIImageView *currentImageView;
@property (nonatomic, strong) UIImageView *freeImageView;
@property (nonatomic, assign) NSInteger currentImageViewIndex;
@property (nonatomic, assign) NSInteger currentImageIndex;

//RSPhotoBrower
@property (nonatomic, strong) RSPhotoBrower *photoBrower;
@property (nonatomic, strong) RSAvatarImageView *avatarImageView;
@property (nonatomic, strong) RSSpaceDetailAddCommentView *addCommentView;
@property (nonatomic, strong) RSSpaceDetailTouchAddCommentView *touchAddCommentView;
@end

@implementation RSSpaceDetailViewController

-(instancetype)init {
    self = [super init];
    if (self) {
        self.imageViewArrayCount = 5;
        
        self.freeImageViewArray = [[NSMutableArray alloc] init];
    }
    return self;
}
-(void)dealloc {
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.contentView addSubview:self.photoBrower];
    [self.contentView addSubview:self.avatarImageView];
//    [self.contentView addSubview:self.addCommentView];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(12);
//        make.height.width.mas_equalTo(self.avatarImageView.height);
        make.centerY.equalTo(self.photoBrower.mas_top);
    }];
//    [self.addCommentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(self.contentView);
//        make.height.mas_equalTo(100);
//    }];
    @weakify(self);
    [self.photoBrower addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithActionBlock:^(UILongPressGestureRecognizer *longPressRecognizer) {
        @RSStrongify(self);
        NSLog(@"UILongPressGestureRecognizer photoBrower");
        if (longPressRecognizer.state != UIGestureRecognizerStateBegan) return ; // except multiple pressed it !
        
        CGPoint p = [longPressRecognizer locationInView:self.contentView] ;// get longpress pt
        NSLog(@"longPressRecognizer:%@", NSStringFromCGPoint(p));
        if (!self.touchAddCommentView.superview) {
            [self.contentView addSubview:self.touchAddCommentView];
        }
        [self.touchAddCommentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(p.y);
            make.left.mas_equalTo(p.x - 24);
        }];
        [self.touchAddCommentView.textField becomeFirstResponder];
    }]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidLayoutSubviews {
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(RSPhotoBrower *)photoBrower {
    if (_photoBrower) {
        return _photoBrower;
    }
    _photoBrower = [[RSPhotoBrower alloc] initWithFrame:self.contentView.bounds];
    _photoBrower.backgroundColor = [UIColor blackColor];
    _photoBrower.dataSources = self.viewModel.photoUrlArray;
    _photoBrower.layer.cornerRadius = 10;
    _photoBrower.layer.masksToBounds = YES;
    return _photoBrower;
}

-(RSAvatarImageView *)avatarImageView {
    if (_avatarImageView) {
        return _avatarImageView;
    }
    _avatarImageView = [[RSAvatarImageView alloc] init];
    _avatarImageView.type = RSAvatarImageViewType80;
    _avatarImageView.layer.cornerRadius = _avatarImageView.height/2;
    _avatarImageView.layer.masksToBounds = YES;
//    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:@"http://www.ladysh.com/d/file/2016080410/2306_160803134243_1.jpg"]];
    @weakify(self);
    [_avatarImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        @RSStrongify(self);
        RSMineViewController *mineCtr = [[RSMineViewController alloc] init];
        [self.navigationController pushViewController:mineCtr animated:YES];
    }]];
    [[RACObserve(self.viewModel, avatarUrls) deliverOnMainThread] subscribeNext:^(id  _Nullable x) {
        @RSStrongify(self);
        [self.avatarImageView setUrls:self.viewModel.avatarUrls];
    }];
    return _avatarImageView;
}

-(RSSpaceDetailAddCommentView *)addCommentView {
    if (_addCommentView) {
        return _addCommentView;
    }
    _addCommentView = [[RSSpaceDetailAddCommentView alloc] init];
    @weakify(self);
    [self.viewModel.updateSignal subscribeNext:^(RSSpace *space) {
        @RSStrongify(self);
        [self.addCommentView.viewModel updateWithSpace:space];
    }];
    RAC(_addCommentView.viewModel, starIndex) = RACObserve(self.photoBrower, currIndex);
    return _addCommentView;
}

-(RSSpaceDetailTouchAddCommentView *)touchAddCommentView {
    if (_touchAddCommentView) {
        return _touchAddCommentView;
    }
    _touchAddCommentView = [[RSSpaceDetailTouchAddCommentView alloc] init];
    @weakify(self);
    [self.viewModel.updateSignal subscribeNext:^(RSSpace *space) {
        @RSStrongify(self);
        [self.touchAddCommentView.viewModel updateWithSpace:space];
    }];
    RAC(_touchAddCommentView.viewModel, starIndex) = RACObserve(self.photoBrower, currIndex);
    return _touchAddCommentView;
}


-(RSSpaceDetailViewModel *)viewModel {
    if (_viewModel) {
        return _viewModel;
    }
    _viewModel = [[RSSpaceDetailViewModel alloc] init];
    return _viewModel;
}
@end
