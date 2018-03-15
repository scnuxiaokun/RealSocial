//
//  RSGeneralCameraView.m
//  RealSocial
//
//  Created by Kira on 2018/3/13.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSGeneralCameraView.h"

//第三方库文件
#import <GPUImage.h>
#import <GPUImageView.h>
#import <Masonry.h>


@interface RSGeneralCameraView()

@property (nonatomic, strong) RSCamera *camera;

@property (nonatomic, strong) GPUImageView *preview;

@property (strong, nonatomic) GPUImageGammaFilter *filter;
@property (strong,nonatomic ) GPUImageView *filterView;

@property (strong, nonatomic) AVCaptureStillImageOutput *photoOutput;
@property (assign, nonatomic) CMSampleBufferRef photoOutputBuffer;

@end

@implementation RSGeneralCameraView

#pragma mark init
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.camera = [[RSCamera alloc] init];
    self.camera.preview = self.preview;
    //初始化滤镜 默认初始化为原图
    _filter = [[GPUImageGammaFilter alloc] init];
    
    [self.camera addTarget:_filter];
    _filterView = self.preview;
    [_filter addTarget:_filterView];
}

#pragma mark camera methods
- (void)setFlashMode:(RSCameraFlashMode)flashMode {
    if (self.camera) {
        [self.camera setFlashMode:flashMode];
    }
}

- (void)rotateCamera {
    if (self.camera) {
        [self.camera rotateCamera];
    }
}

- (void)capturePhoto {
    
}

- (void)savePhotoToAlbum {
    
}

#pragma mark set-get

- (UIView *)preview {
    if(!_preview) {
        _preview = [[GPUImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_preview];
        [_preview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self);
        }];
    }
    return _preview;
}

@end
