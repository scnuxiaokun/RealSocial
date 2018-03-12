//
//  RSCommentModel.h
//  RealSocial
//
//  Created by kuncai on 2018/3/10.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSModel.h"
#import "Spspacecgi.pbobjc.h"

@interface RSCommentModel : RSModel
@property (nonatomic, strong) NSString *commentId;
@property (nonatomic, strong) NSString *starId;
@property (nonatomic, strong) NSString *fromUser;
@property (nonatomic, assign) uint32_t createTime;
@property (nonatomic, strong) NSString *content;

-(instancetype)initWithComment:(RSComment *)comment starId:(NSString *)starId;
@end
