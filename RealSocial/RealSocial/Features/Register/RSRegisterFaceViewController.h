//
//  RSRegisterFaceViewController.h
//  RealSocial
//
//  Created by kuncai on 2018/3/8.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSCameraViewController.h"
#import "RSRegisterFaceViewModel.h"
#import <MGBaseKit/MGBaseKit.h>
#import "MGFacepp.h"
@interface RSRegisterFaceViewController : UIViewController
@property (nonatomic, strong) RSRegisterFaceViewModel *viewModel;

@property (nonatomic, strong) MGFacepp *markManager;

@property (nonatomic, strong) MGVideoManager *videoManager;

@property (nonatomic, assign) CGRect detectRect;
@property (nonatomic, assign) CGSize videoSize;

@property (nonatomic, assign) BOOL debug;
@property (nonatomic, assign) BOOL show3D;
@property (nonatomic, assign) BOOL faceInfo;
@property (nonatomic, assign) BOOL faceCompare;

@property (nonatomic, assign) MGFppDetectionMode detectMode;


@property (nonatomic, assign) int pointsNum;
@end
