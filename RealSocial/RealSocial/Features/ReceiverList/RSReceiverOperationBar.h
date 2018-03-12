//
//  RSReceiverOperationBar.h
//  RealSocial
//
//  Created by kuncai on 2018/3/6.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSReceiverListViewModel.h"
#import "RSAvatarImageView.h"
#import "RSReceiverAvatarStackView.h"
@interface RSReceiverOperationBar : UIView
@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) RSReceiverAvatarStackView *avatarContentView;
//-(void)addReceiver:(RSReceiverListItemViewModel *)item;
//-(void)removeReceiver:(RSReceiverListItemViewModel *)item;
//-(void)removeAllReceiver;
@end
