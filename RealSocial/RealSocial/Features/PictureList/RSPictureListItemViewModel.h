//
//  RSPictureListItemViewModel.h
//  RealSocial
//
//  Created by kuncai on 2018/2/4.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSViewModel.h"
#import "RSPictureModel.h"
@interface RSPictureListItemViewModel : RSViewModel
@property (nonatomic, strong) RSPictureModel *pictureModel;
@property (nonatomic, strong) NSString *pictureFilePath;
@property (nonatomic, strong) NSArray *faceInfos;
@property (nonatomic, strong) NSString *pictureInfo;
@property (nonatomic, strong) UIImage *pictureImage;
@end
