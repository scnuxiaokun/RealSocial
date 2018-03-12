//
//  RSReceiverListWithSpaceViewController.h
//  RealSocial
//
//  Created by kuncai on 2018/2/11.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSReceiverListViewController.h"
#import "RSReceiverSpaceView.h"
#import "RSReceiverSpaceViewModel.h"

@class RSReceiverListWithSpaceViewController;
typedef void (^RSReceiverListWithSpaceViewControllerCompletionHandler)(RSReceiverListWithSpaceViewController *ctr, NSArray *toUsers, NSArray *spaceIds, BOOL isSelectedAllFriend,BOOL isSelectedMemories);
@interface RSReceiverListWithSpaceViewController : RSReceiverListViewController
@property (nonatomic, strong) RSReceiverSpaceView *spaceView;
@property (nonatomic, copy) RSReceiverListWithSpaceViewControllerCompletionHandler spaceCompletionHandler;
@end
