//
//  RSAddFriendsViewController.h
//  RealSocial
//
//  Created by 蒋陈浩 on 2018/3/8.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSubUIViewController.h"
#import "RSCameraViewController.h"
@interface RSAddFriendsViewController : RSCameraViewController
@property (copy) void (^triggerAction)(NSString*);
@property (copy) void (^reTry)(void);
- (void)addingFriends;
- (void)succedAddFriends:(NSDictionary *)dic;
- (void)faildAddFriendsWithErrorType:(ErrorType)errorType;

@end

