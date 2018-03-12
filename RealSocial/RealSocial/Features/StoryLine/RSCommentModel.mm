//
//  RSCommentModel.mm
//  RealSocial
//
//  Created by kuncai on 2018/3/10.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSCommentModel+WCTTableCoding.h"
#import "RSCommentModel.h"
#import <WCDB/WCDB.h>
#import "RSDBService.h"

@implementation RSCommentModel

WCDB_IMPLEMENTATION(RSCommentModel)
WCDB_SYNTHESIZE(RSCommentModel, commentId)
WCDB_SYNTHESIZE(RSCommentModel, fromUser)
WCDB_SYNTHESIZE(RSCommentModel, createTime)
WCDB_SYNTHESIZE(RSCommentModel, content)
WCDB_SYNTHESIZE(RSCommentModel, starId)

WCDB_UNIQUE(RSCommentModel, commentId)
WCDB_NOT_NULL(RSCommentModel, commentId)

-(instancetype)init {
    self = [super init];
    if (self) {
        static dispatch_once_t token;
        dispatch_once(&token, ^{
            if ([[RSDBService db] createTableAndIndexesOfName:NSStringFromClass([RSCommentModel class]) withClass:[RSCommentModel class]]) {
                NSLog(@"creat table RSCommentModel success");
            } else {
                NSLog(@"creat table RSCommentModel fail");
            }
        });
    }
    return self;
}

-(instancetype)initWithStar:(RSComment *)comment starId:(NSString *)starId {
    self = [self init];
    if (self) {
        self.starId = starId;
        self.commentId = [NSString stringWithFormat:@"%@_%lld",starId,comment.commentId.svrId];
        self.fromUser = comment.fromUser;
        self.content = comment.content;
        self.createTime = comment.createTime;
    }
    return self; 
}
@end
