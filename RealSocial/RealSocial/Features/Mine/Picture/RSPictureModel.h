//
//  RSPictureListItemViewModel.h
//  RealSocial
//
//  Created by kuncai on 2018/2/1.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSViewModel.h"
typedef NS_ENUM(NSUInteger ,RSPictureStatus) {
    RSPictureStatusInit = 0,
    RSPictureStatusUploading = 1,
    RSPictureStatusUploadFinish = 2
};
@interface RSPictureModel : RSViewModel
@property (nonatomic, strong) NSString *pictureId;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) NSString *info;
@property (nonatomic, assign) RSPictureStatus status;
@end
