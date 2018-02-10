//
//  RSStoryDetailViewModel.m
//  RealSocial
//
//  Created by kuncai on 2018/2/9.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSSpaceDetailViewModel.h"

@implementation RSSpaceDetailViewModel
-(void)updateWithStory:(RSSpace *)story {
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    for (RSStar *storyItem in story.starListArray) {
        if (storyItem.type == RSenStarType_StarTypeImg) {
            RSStarImg *img = storyItem.img;
            if (img.imgURL) {
                [tmp addObject:img.imgURL];
            }
        }
    }
    self.photoUrlArray = tmp;
}
@end
