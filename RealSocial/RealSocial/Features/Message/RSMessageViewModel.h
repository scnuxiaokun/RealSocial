//
//  RSMessageViewModel.h
//  RealSocial
//
//  Created by kuncai on 2018/1/30.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSViewModel.h"
@interface RSMessageItemViewModel : RSViewModel
@property (nonatomic, strong) NSString *name;
@end
@interface RSMessageViewModel : RSViewModel
@property (nonatomic, strong) NSArray *listData;
@end
