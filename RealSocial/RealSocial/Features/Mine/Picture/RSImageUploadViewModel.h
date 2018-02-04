//
//  RSImageUploadViewModel.h
//  RealSocial
//
//  Created by kuncai on 2018/2/3.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSViewModel.h"
#import "MGFacepp.h"
@interface RSImageUploadViewModel : RSViewModel
@property (nonatomic, strong) MGFacepp *facepp;
-(BOOL)uploadImage:(UIImage *)image;
+(NSString *)localPicturePathWithPictureId:(NSString *)pictureId;
+(NSString *)localPictureDir;
@end
