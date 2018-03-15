//
//  RSCamera.m
//  RealSocial
//
//  Created by Kira on 2018/3/13.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSCamera.h"

#import "RSUtilMacro.h"

@interface RSCamera() {
    CALayer *_focusLayer; //聚焦层
}
@end

@implementation RSCamera

#pragma mark init

- (instancetype)init {
    self = [super init];
    if (self) {
        self = [super initWithSessionPreset:AVCaptureSessionPresetHigh
                        cameraPosition:AVCaptureDevicePositionBack];
    }
    self.outputImageOrientation = UIInterfaceOrientationPortrait;//设置照片的方向为设备的定向
    self.horizontallyMirrorFrontFacingCamera = YES;//设置前置为镜像
    self.horizontallyMirrorRearFacingCamera = NO;//设置后置为非镜像
    [self setFlashMode:RSCameraFlashModeOff];
    [self startCameraCapture];
    
    AVCaptureDevice *camDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    return self;
}

- (id)initWithCameraPosition:(AVCaptureDevicePosition) cameraPosition{
    return [self initWithSessionPreset:AVCaptureSessionPresetPhoto cameraPosition:cameraPosition];
}

#pragma mark 闪光灯设置

/** 设置闪光灯模式 */
- (void)setFlashMode:(RSCameraFlashMode)flashMode {
    _flashMode = flashMode;
    
    switch (flashMode) {
        case RSCameraFlashModeAuto: {
            [self.inputCamera lockForConfiguration:nil];
            if ([self.inputCamera isFlashModeSupported:AVCaptureFlashModeAuto]) {
                [self.inputCamera setFlashMode:AVCaptureFlashModeAuto];
                if (self.inputCamera.torchMode == AVCaptureTorchModeOn) {
                    [self.inputCamera setTorchMode:AVCaptureTorchModeOff];
                }
            }
            [self.inputCamera unlockForConfiguration];
        }
            break;
        case RSCameraFlashModeOff: {
            [self.inputCamera lockForConfiguration:nil];
            if ([self.inputCamera isFlashModeSupported:AVCaptureFlashModeOff]) {
                [self.inputCamera setFlashMode:AVCaptureFlashModeOff];
                if (self.inputCamera.torchMode == AVCaptureTorchModeOn) {
                    [self.inputCamera setTorchMode:AVCaptureTorchModeOff];
                }
            }
            [self.inputCamera unlockForConfiguration];
        }
            
            break;
        case RSCameraFlashModeOn: {
            [self.inputCamera lockForConfiguration:nil];
            if ([self.inputCamera isFlashModeSupported:AVCaptureFlashModeOff]) {
                [self.inputCamera setFlashMode:AVCaptureFlashModeOn];
                if (self.inputCamera.torchMode == AVCaptureTorchModeOn) {
                    [self.inputCamera setTorchMode:AVCaptureTorchModeOff];
                }
                
            }
            [self.inputCamera unlockForConfiguration];
        }
            break;
        case RSCameraFlashModeOpen:{
            [self.inputCamera lockForConfiguration:nil];
            if ([self.inputCamera isTorchModeSupported:AVCaptureTorchModeOn]) {
                [self.inputCamera setTorchMode:AVCaptureTorchModeOn];
            }
            if ([self.inputCamera isFlashModeSupported:AVCaptureFlashModeOff]) {
                [self.inputCamera setFlashMode:AVCaptureFlashModeOff];
            }
            [self.inputCamera unlockForConfiguration];
        }
        default:
            break;
    }
}

#pragma mark 转置相机
/** 转置相机 */
- (void) rotateCamera{
    [super rotateCamera];
}

@end

