//
//  UIImage+Util.h
//  RealSocial
//
//  Created by kuncai on 2018/1/24.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import <AVFoundation/AVFoundation.h>
@interface UIImage (Util)
+(UIImage *)imageWithCMSampleBufferRef:(CMSampleBufferRef)sampleBuffer;
@end
