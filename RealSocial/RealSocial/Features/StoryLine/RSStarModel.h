//
//  RSStarModel.h
//  RealSocial
//
//  Created by kuncai on 2018/3/10.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSModel.h"
#import "Spspacecgi.pbobjc.h"
@interface RSStarModel : RSModel
@property (nonatomic, strong) NSString *starId;
@property (nonatomic, strong) NSString *spaceId;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *videoUrl;
-(instancetype)initWithStar:(RSStar *)star spaceId:(NSString *)spaceId;
@end
