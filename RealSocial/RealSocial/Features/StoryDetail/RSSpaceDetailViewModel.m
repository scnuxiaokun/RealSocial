//
//  RSStoryDetailViewModel.m
//  RealSocial
//
//  Created by kuncai on 2018/2/9.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSSpaceDetailViewModel.h"

@implementation RSSpaceDetailViewModel
-(void)updateWithSpace:(RSSpace *)space {
    [self sendUpdateData:space];
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    for (RSStar *star in space.starListArray) {
        if (star.type == RSenStarType_StarTypeImg) {
            RSStarImg *img = star.img;
            if (img.imgURL) {
                [tmp addObject:img.imgURL];
            }
        }
    }
    self.photoUrlArray = [[tmp reverseObjectEnumerator] allObjects];
}
@end
