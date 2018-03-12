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
#import "RSSpaceModel.h"
#import <YYDispatchQueuePool/YYDispatchQueuePool.h>

@interface RSSpaceLineItemViewModel : RSViewModel
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSString *subTitleString;
@property (nonatomic, strong) NSArray *avatarUrls;
@property (nonatomic, strong) NSString *mediaUrl;
@property (nonatomic, strong) RSSpace *space;
@property (nonatomic, assign) BOOL isReaded;
-(void)updateWithSpace:(RSSpace *)space;
-(void)updateWithSpaceModel:(RSSpaceModel *)spaceModel;
-(void)saveReadedToDB;
@end
@interface RSSpaceLineViewModel : RSViewModel
@property (nonatomic, strong) NSArray *listData;
@end
