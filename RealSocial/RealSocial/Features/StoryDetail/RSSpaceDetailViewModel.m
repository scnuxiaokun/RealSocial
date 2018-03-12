//
//  RSStoryDetailViewModel.m
//  RealSocial
//
//  Created by kuncai on 2018/2/9.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSSpaceDetailViewModel.h"
#import "RSContactService.h"
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
    NSArray<RSContactModel *> *authors = [[RSContactService shareInstance] getContactsByUids:space.authorArray];
    NSMutableArray *tmpUrls = [[NSMutableArray alloc] init];
    for (RSContactModel *author in authors) {
        [tmpUrls addObject:author.avatarUrl];
    }
    self.avatarUrls = tmpUrls;
    self.photoUrlArray = [[tmp reverseObjectEnumerator] allObjects];
}
@end
