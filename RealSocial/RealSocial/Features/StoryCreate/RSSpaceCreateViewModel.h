//
//  RSStoryCreateViewModel.h
//  RealSocial
//
//  Created by kuncai on 2018/2/7.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSViewModel.h"
#import "RSSpaceCreateModel.h"

@interface RSSpaceCreateViewModel : RSViewModel
-(RACSignal *)create:(UIImage *)picture toUsers:(NSArray *)users toSpaces:(NSArray *)spaces;
-(RACSignal *)createToAllFriends:(UIImage *)picture;
-(RACSignal *)createToMemories:(UIImage *)picture;
@end
