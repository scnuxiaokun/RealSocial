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
@property (nonatomic, strong) UIImageView *avatarImageView;
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
    /*
    self.imageCount = [self.viewModel.photoUrlArray count];
    [self.contentView addSubview:self.mediaScrollView];
//    self.mediaScrollView.frame = self.contentView.bounds;
    [self.mediaScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    for (int i=0; i<self.imageViewArrayCount; i++) {
        UIImageView *imageView = [self.imageViewArray objectAtIndex:i];
        [imageView sd_setImageWithURL:[self.viewModel.photoUrlArray objectOrNilAtIndex:i]];
        if (i > 1) {
            [self.freeImageViewArray addObject:imageView];
        } else {
            [self.mediaScrollView addSubview:imageView];
            imageView.frame = CGRectMake(i*self.contentView.width, 0, self.contentView.width, self.contentView.height);
//            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.height.width.equalTo(self.mediaScrollView);
//                make.top.equalTo(self.mediaScrollView);
//                make.left.equalTo(self.mediaScrollView).with.offset(i*self.view.width);
//            }];
        }
    }
    self.currentImageView = [self.imageViewArray firstObject];
    self.nextImageView = [self.imageViewArray objectAtIndex:1];
    self.freeImageView = [self.imageViewArray objectAtIndex:2];
    self.preImageView = nil;
    self.currentImageViewIndex = 0;
    self.currentImageIndex = 0;
    
    */
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.contentView addSubview:self.photoBrower];
    [self.contentView addSubview:self.avatarImageView];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(12);
        make.height.width.mas_equalTo(self.avatarImageView.height);
        make.centerY.equalTo(self.photoBrower.mas_top);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidLayoutSubviews {
    self.mediaScrollView.contentSize = CGSizeMake(self.contentView.width * self.imageCount, 0);
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
    _photoBrower.backgroundColor = [UIColor randomColor];
    _photoBrower.dataSources = self.viewModel.photoUrlArray;
    _photoBrower.layer.cornerRadius = 10;
    _photoBrower.layer.masksToBounds = YES;
    return _photoBrower;
}

-(UIImageView *)avatarImageView {
    if (_avatarImageView) {
        return _avatarImageView;
    }
    _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
    _avatarImageView.layer.cornerRadius = _avatarImageView.height/2;
    _avatarImageView.layer.masksToBounds = YES;
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:@"http://www.ladysh.com/d/file/2016080410/2306_160803134243_1.jpg"]];
    @weakify(self);
    [_avatarImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        @RSStrongify(self);
        RSMineViewController *mineCtr = [[RSMineViewController alloc] init];
        [self.navigationController pushViewController:mineCtr animated:YES];
    }]];
    return _avatarImageView;
}

-(RSSpaceDetailViewModel *)viewModel {
    if (_viewModel) {
        return _viewModel;
    }
    _viewModel = [[RSSpaceDetailViewModel alloc] init];
    return _viewModel;
}
-(UIScrollView *)mediaScrollView {
    if (_mediaScrollView) {
        return _mediaScrollView;
    }
    _mediaScrollView = [[UIScrollView alloc] init];
    _mediaScrollView.backgroundColor = [UIColor grayColor];
//    _mediaScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _mediaScrollView.pagingEnabled = YES;
    _mediaScrollView.delegate = self;
    _mediaScrollView.alwaysBounceVertical = NO;
    _mediaScrollView.showsHorizontalScrollIndicator = NO;
    _mediaScrollView.showsVerticalScrollIndicator = NO;
//    _mediaScrollView.contentOffset = CGPointMake(_mediaScrollView.width, 0.0);
    return _mediaScrollView;
}

-(NSArray *)imageViewArray {
    if (_imageViewArray) {
        return _imageViewArray;
    }
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    for (int i=0; i< self.imageViewArrayCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        if (i==0) {
            imageView.backgroundColor = [UIColor redColor];
            imageView.tag = 0;
        }
        if (i==1) {
            imageView.backgroundColor = [UIColor greenColor];
            imageView.tag = 1;
        }
        if (i==2) {
            imageView.backgroundColor = [UIColor blueColor];
            imageView.tag = 2;
        }
        [tmp addObject:imageView];
    }
    _imageViewArray = tmp;
    return _imageViewArray;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x > self.currentImageView.frame.origin.x) {
        //取下一张图
//        NSLog(@"next");
//        NSInteger nextImageIndex = self.currentImageIndex + 1;
//        if (nextImageIndex < self.imageCount) {
//            self.tmpImageView = [self.freeImageViewArray firstObject];
//            [self.freeImageViewArray removeFirstObject];
//            [self.mediaScrollView addSubview:self.tmpImageView];
//            [self.tmpImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.height.width.equalTo(self.mediaScrollView);
//                make.top.equalTo(self.mediaScrollView);
//                make.left.equalTo(self.mediaScrollView).with.offset(nextImageIndex * self.mediaScrollView.width);
//            }];
//        }
        
//        NSInteger val = self.index + 1;
//        if (self.index >= [self.slideImages count] - 1) {
//            val = 0;
//        }
//
//        // 取缓冲区的View
//        self.resuingView.image = [UIImage imageNamed:[NSString stringWithFormat:@"0%zd.jpg",val]];
//        self.resuingView.x = CGRectGetMinX(_currentView.frame) + _currentView.width;
//        self.isLastScrollDirection = YES;
    }else{
//        NSLog(@"pre");
        //取上一张图
//        NSInteger preImageIndex = self.currentImageIndex - 1;
//        if (preImageIndex >= 0) {
//            self.tmpImageView = [self.freeImageViewArray firstObject];
//            [self.freeImageViewArray removeFirstObject];
//            [self.mediaScrollView addSubview:self.tmpImageView];
//            [self.tmpImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.height.width.equalTo(self.mediaScrollView);
//                make.top.equalTo(self.mediaScrollView);
////                make.left.mas_equalTo(preImageIndex * self.mediaScrollView.width);
//                make.left.equalTo(self.mediaScrollView).with.offset(preImageIndex * self.mediaScrollView.width);
//            }];
        }
//        NSInteger val = self.index - 1;
//        if (val < 0) {
//            val = [self.slideImages count]-1;
//        }
//        self.resuingView.image = [UIImage imageNamed:[NSString stringWithFormat:@"0%zd.jpg",val]];
//        self.resuingView.x = 0;
//        self.isLastScrollDirection = NO;
//    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"contentOffset:%f  currentImageView:%f index:%ld",scrollView.contentOffset.x, self.currentImageIndex * self.mediaScrollView.width, (long)self.currentImageIndex);
    if (scrollView.contentOffset.x == self.currentImageIndex * self.mediaScrollView.width) {
        return;
    }
    if (scrollView.contentOffset.x < 0) {
        return;
    }
    
    NSInteger nextImageindex = self.currentImageIndex + 1;
    NSInteger preImageIndex = self.currentImageIndex - 1;
    //快速滚动判断有误
    if (scrollView.contentOffset.x > self.currentImageIndex * self.mediaScrollView.width) {
        //往右
        if (self.preImageView) {
            self.freeImageView = self.preImageView;
//            [self.preImageView removeFromSuperview];
//            [self.freeImageViewArray addObject:self.preImageView];
        }
        self.preImageView = self.currentImageView;
        self.currentImageView = self.nextImageView;
        self.currentImageIndex = nextImageindex;
        if (nextImageindex + 1 < self.imageCount - 1) {
            //准备下一张图
            self.nextImageView = self.freeImageView;
//            [self.freeImageViewArray removeFirstObject];
            [self.mediaScrollView addSubview:self.nextImageView];
//            [self.nextImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.height.width.equalTo(self.mediaScrollView);
//                make.top.equalTo(self.mediaScrollView);
////                make.left.equalTo(self.currentImageView.mas_right);
//                make.left.equalTo(self.mediaScrollView).with.offset((nextImageindex + 1)*self.view.width);
//            }];
            self.nextImageView.frame = CGRectMake((nextImageindex + 1)*self.contentView.width, 0, self.contentView.width, self.contentView.height);
        } else {
            self.nextImageView = nil;
        }
    } else {
        self.currentImageIndex = preImageIndex;
        if (self.nextImageView) {
            self.freeImageView = self.nextImageView;
        }
        
//        [self.nextImageView removeFromSuperview];
//        [self.freeImageViewArray addObject:self.nextImageView];
        self.nextImageView = self.currentImageView;
        self.currentImageView = self.preImageView;
        if (preImageIndex - 1 >= 0) {
            //准备上一张图
            self.preImageView = self.freeImageView;
//            [self.freeImageViewArray removeFirstObject];
            [self.mediaScrollView addSubview:self.preImageView];
//            [self.preImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.height.width.equalTo(self.mediaScrollView);
//                make.top.equalTo(self.mediaScrollView);
////                make.right.equalTo(self.currentImageView.mas_left);
//                make.left.equalTo(self.mediaScrollView).with.offset((preImageIndex - 1)*self.view.width);
//            }];
            self.preImageView.frame = CGRectMake((preImageIndex - 1)*self.contentView.width, 0, self.contentView.width, self.contentView.height);
        } else {
            self.preImageView = nil;
        }
    }
//    NSInteger pretag = (self.preImageView) ? self.preImageView.tag : -1;
//    NSInteger nexttag = (self.nextImageView) ? self.nextImageView.tag : -1;
//    NSLog(@"pre:%d,current:%d,next:%d", pretag, self.currentImageView.tag,self.nextImageView.tag);
}
#pragma mark - MWPhotoBrowserDelegate

//- (void)willAppearPhotoBrowser:(IDMPhotoBrowser *)photoBrowser;
//- (void)willDisappearPhotoBrowser:(IDMPhotoBrowser *)photoBrowser;
//- (void)photoBrowser:(IDMPhotoBrowser *)photoBrowser didShowPhotoAtIndex:(NSUInteger)index;
//- (void)photoBrowser:(IDMPhotoBrowser *)photoBrowser didDismissAtPageIndex:(NSUInteger)index;
//- (void)photoBrowser:(IDMPhotoBrowser *)photoBrowser willDismissAtPageIndex:(NSUInteger)index;
//- (void)photoBrowser:(IDMPhotoBrowser *)photoBrowser didDismissActionSheetWithButtonIndex:(NSUInteger)buttonIndex photoIndex:(NSUInteger)photoIndex;
//- (IDMCaptionView *)photoBrowser:(IDMPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index;
@end
