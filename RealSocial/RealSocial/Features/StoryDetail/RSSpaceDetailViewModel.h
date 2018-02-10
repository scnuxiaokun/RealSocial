//
//  RSStoryDetailViewModel.h
//  RealSocial
//
//  Created by kuncai on 2018/2/9.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSViewModel.h"
#import "Spstorycgi.pbobjc.h"
@interface RSSpaceDetailViewModel : RSViewModel
@property (nonatomic, strong) NSArray *photoUrlArray;
-(void)updateWithStory:(RSStory *)story;
@end
