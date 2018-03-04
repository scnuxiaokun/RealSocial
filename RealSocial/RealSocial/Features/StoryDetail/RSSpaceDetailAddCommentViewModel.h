//
//  RSSpaceDetailAddCommentViewModel.h
//  RealSocial
//
//  Created by kuncai on 2018/3/4.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSViewModel.h"
#import "Spspacecgi.pbobjc.h"
#import "Spcgicommdef.pbobjc.h"
@interface RSSpaceDetailAddCommentViewModel : RSViewModel
@property (nonatomic, strong) RSSpace *space;
@property (nonatomic, assign) NSInteger starIndex;
-(BOOL)addComment:(NSString *)content;
-(void)updateWithSpace:(RSSpace *)space;
@end
