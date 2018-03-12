//
//  RSRegisterFaceViewModel.h
//  RealSocial
//
//  Created by kuncai on 2018/3/8.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSViewModel.h"

@interface RSRegisterFaceViewModel : RSViewModel
-(RACSignal *)uploadFaceImage:(UIImage *)image;
@end
