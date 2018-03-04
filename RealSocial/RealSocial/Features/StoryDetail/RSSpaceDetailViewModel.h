//
//  RSStoryDetailViewModel.h
//  RealSocial
//
//  Created by kuncai on 2018/2/9.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSViewModel.h"
#import "Spspacecgi.pbobjc.h"
#import "Spcgicommdef.pbobjc.h"
@interface RSSpaceDetailViewModel : RSViewModel
@property (nonatomic, strong) NSArray *photoUrlArray;
-(void)updateWithSpace:(RSSpace *)space;
@end
