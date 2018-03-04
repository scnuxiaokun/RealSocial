//
//  RSSpaceDetailAddCommentViewModel.m
//  RealSocial
//
//  Created by kuncai on 2018/3/4.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSSpaceDetailAddCommentViewModel.h"
#import "RSNetWorkService.h"
#import "RSLoginService.h"
#import "RSRequestFactory.h"
#import "Spcgicomm.pbobjc.h"

@implementation RSSpaceDetailAddCommentViewModel

-(void)updateWithSpace:(RSSpace *)space {
    self.space = space;
}

-(BOOL)addComment:(NSString *)content {
    if ([content length] <= 0) {
        return NO;
    }
    NSArray *starList = [[self.space.starListArray reverseObjectEnumerator] allObjects];
    RSStar *star = [starList objectOrNilAtIndex:self.starIndex];
    if (!star) {
        return NO;
    }
    RSAddCommentReq *req = [RSAddCommentReq new];
    req.starId = star.starId;
    req.spaceId = self.space.spaceId;
    RSComment *comment = [RSComment new];
    comment.commentId = [RSRequestFactory randomPairIdWithKey:@"addComment"];
    comment.fromUser = [RSLoginService shareInstance].loginInfo.uid;
    comment.content = content;
//    req.comment = comment;
    NSLog(@"RSAddCommentReq:%@", req);
    RSRequest *request = [RSRequestFactory requestWithReq:req resp:[RSAddCommentResp class] moke:nil];
    [[RSNetWorkService sendRequest:request] subscribeNext:^(RSAddCommentResp *resp) {
        
    } error:^(NSError * _Nullable error) {
        [self sendErrorSignal:error];
    } completed:^{
        [self sendCompleteSignal];
    }];
    return YES;
}
@end
