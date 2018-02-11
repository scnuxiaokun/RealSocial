//
//  RSStoryLineViewModel.h
//  RealSocial
//
//  Created by kuncai on 2018/2/7.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSViewModel.h"
#import "Spspacecgi.pbobjc.h"
#import "Spcgicommdef.pbobjc.h"

@interface RSSpaceLineItemViewModel : RSViewModel
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSString *subTitleString;
@property (nonatomic, strong) NSArray *avatarUrls;
@property (nonatomic, strong) NSString *mediaUrl;
@property (nonatomic, strong) RSSpace *space;
-(void)updateWithSpace:(RSSpace *)space;
@end
@interface RSSpaceLineViewModel : RSViewModel
@property (nonatomic, strong) NSArray *listData;
@end
