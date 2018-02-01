//
//  RSPictureListItemViewModel.h
//  RealSocial
//
//  Created by kuncai on 2018/2/1.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSViewModel.h"

@interface RSPictureListItemViewModel : RSViewModel
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@end
