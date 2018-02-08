//
//  RSFriendListViewController.h
//  RealSocial
//
//  Created by kuncai on 2018/1/22.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSUIViewController.h"
@class RSContactListViewController;
typedef void (^RSContactListCompletionHandler)(RSContactListViewController *ctr, NSArray *toUsers);

@interface RSContactListViewController : RSUIViewController
@property (nonatomic, strong) NSArray *defaultToUsers;
@property (nonatomic, copy) RSContactListCompletionHandler completionHandler;
@end
