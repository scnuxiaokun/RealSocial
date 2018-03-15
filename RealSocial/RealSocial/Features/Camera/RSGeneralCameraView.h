//
//  RSGeneralCameraView.h
//  RealSocial
//
//  Created by Kira on 2018/3/13.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSCamera.h"
#import "RSGeneralCameraViewDelegate.h"

@interface RSGeneralCameraView : UIView

@property (nonatomic, assign) RSCameraType cameraType;

@property (nonatomic, assign) RSDevicePosition devicePosition;

@property (nonatomic, assign) BOOL fixPhotoOritentionEnable;

@property (nonatomic, assign) BOOL fixPhotoFrontMirrorEnable;

@property (nonatomic, copy) id<RSGeneralCameraViewDelegate> delegate;

- (void)rotateCamera;


- (void)capturePhoto;

- (void)savePhotoToAlbum;

@end

