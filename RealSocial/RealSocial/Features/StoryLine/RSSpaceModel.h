//
//  RSSpaceModel.h
//  RealSocial
//
//  Created by kuncai on 2018/3/10.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSModel.h"
#import "Spspacecgi.pbobjc.h"

@interface RSSpaceModel : RSModel
@property (nonatomic, strong) NSString *spaceId;
//@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) uint32_t updateTime;
//@property (nonatomic, strong) NSArray *authorArray;
//@property (nonatomic, strong) NSString *creator;
//@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) BOOL isReaded;
@property (nonatomic, strong) NSData *spaceData;
//@property (nonatomic, strong) NSString *faceUrl;
-(instancetype)initWithSpace:(RSSpace *)space;
-(void)updateWithSpace:(RSSpace *)space;
-(RSSpace *)toSpace;
@end
