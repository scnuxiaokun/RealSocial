//
//  RSReceiverCteateGroupFormView.h
//  RealSocial
//
//  Created by kuncai on 2018/3/7.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSReceiverAvatarStackView.h"
@interface RSReceiverCteateGroupFormView : UIView <UITextFieldDelegate>
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) RSReceiverAvatarStackView *avatarContentView;
@property (nonatomic, strong) UILabel *textFieldTitleLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *createButton;
//@property (nonatomic, strong) ;
@end
