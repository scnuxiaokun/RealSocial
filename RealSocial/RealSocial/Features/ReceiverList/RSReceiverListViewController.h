//
//  RSFriendListViewController.h
//  RealSocial
//
//  Created by kuncai on 2018/1/22.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSUIViewController.h"
@class RSReceiverListViewController;
typedef void (^RSReceiverListCompletionHandler)(RSReceiverListViewController *ctr, NSArray *toUsers);

@interface RSReceiverListViewController : RSUIViewController
@property (nonatomic, strong) NSArray *defaultToUsers;
@property (nonatomic, copy) RSReceiverListCompletionHandler completionHandler;
@end
