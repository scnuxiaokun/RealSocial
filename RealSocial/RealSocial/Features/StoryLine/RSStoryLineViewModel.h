//
//  RSStoryLineViewModel.h
//  RealSocial
//
//  Created by kuncai on 2018/2/7.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSViewModel.h"
#import "Spstorycgi.pbobjc.h"

@interface RSStoryLineItemViewModel : RSViewModel
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSString *subTitleString;
@property (nonatomic, strong) NSString *avatarUrl;
@property (nonatomic, strong) NSString *mediaUrl;
@property (nonatomic, strong) RSStory *story;
-(void)updateWithStory:(RSStory *)story;
@end
@interface RSStoryLineViewModel : RSViewModel
@property (nonatomic, strong) NSArray *listData;
@end
