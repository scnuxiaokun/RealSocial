//
//  RSReceiverListWithCreateGroupViewController.h
//  RealSocial
//
//  Created by kuncai on 2018/2/12.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSReceiverListViewController.h"
@class RSReceiverListWithCreateGroupViewController;
typedef void (^RSReceiverListWithCreateGroupViewControllerCompletionHandler)(RSReceiverListWithCreateGroupViewController *ctr, UITextField *textField, NSArray *toUsers);
@interface RSReceiverListWithCreateGroupViewController : RSReceiverListViewController <UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, copy) RSReceiverListWithCreateGroupViewControllerCompletionHandler createGroupCompletionHandler;
@end
