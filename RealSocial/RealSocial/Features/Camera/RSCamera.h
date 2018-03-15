//
//  RSCamera.h
//  RealSocial
//
//  Created by Kira on 2018/3/13.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "GPUImageStillCamera.h"

/**
 * 相机类型
 */
typedef NS_ENUM(NSInteger, RSCameraType) {
    RSCameraTypeStillCamera,    //拍照
    RSCameraTypeVideoCamera     //摄像
};

/**
 * 相机闪光灯模式
 */
typedef NS_ENUM(NSInteger, RSCameraFlashMode) {
    
    RSCameraFlashModeAuto,  /**< 自动模式 */
    
    RSCameraFlashModeOff,  /**< 闪光灯关闭模式 */
    
    RSCameraFlashModeOn,  /**< 闪光灯打开模式 */
    
    RSCameraFlashModeOpen  /**< 闪光灯常亮模式 */
};

/**
 * 相机前后置
 */
typedef NS_ENUM(NSInteger,RSDevicePosition) {
    RSDevicePositionFront,  //前置
    RSDevicePositionBack    //后置
};

@interface RSCamera : GPUImageStillCamera

@property (strong ,nonatomic) UIView *preview;//预览视图

@property AVCaptureStillImageOutput *photoOutput;

@property (nonatomic , assign) RSCameraFlashMode flashMode;

/**
 *   初始化相机
 *   默认初始化相机为后置
 *   默认闪光灯为关闭闪光模式
 *   默认聚焦状态为自动聚焦
 *   @param     cameraPosition  相机位置
 *
 *   @return  id 相机实例
 */
- (id)initWithCameraPosition:(AVCaptureDevicePosition) cameraPosition;

/**
 *   设置闪光灯模式功能
 *
 *   @param     flashMode  闪光灯模式
 *
 *   @return  void
 */
- (void)setFlashMode:(RSCameraFlashMode)flashMode;


/**
 *   转置相机
 */
- (void) rotateCamera;

@end


@interface RSCameraPhoto: NSObject

@property (nonatomic, strong) UIImage *photoImage;

@end
