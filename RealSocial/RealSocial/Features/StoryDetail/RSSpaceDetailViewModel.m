//
//  RSStoryDetailViewModel.m
//  RealSocial
//
//  Created by kuncai on 2018/2/9.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSSpaceDetailViewModel.h"

@implementation RSSpaceDetailViewModel
-(void)updateWithStory:(RSStory *)story {
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    for (RSStoryItem *storyItem in story.itemArray) {
        if (storyItem.type == RSenStoryItemType_StoryItemTypeImg) {
            RSStoryImg *img = storyItem.img;
            if (img.imgRl) {
                [tmp addObject:img.imgRl];
            }
        }
    }
    self.photoUrlArray = tmp;
}
@end
