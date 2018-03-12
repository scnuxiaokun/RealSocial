//
//  RSSpaceDetailTouchAddCommentView.h
//  RealSocial
//
//  Created by kuncai on 2018/3/10.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSAvatarImageView.h"
#import "RSSpaceDetailAddCommentViewModel.h"
@interface RSSpaceDetailTouchAddCommentView : UIView<UITextFieldDelegate>
@property (nonatomic, strong) RSSpaceDetailAddCommentViewModel *viewModel;
@property (nonatomic, strong) RSAvatarImageView *avatarImageView;
@property (nonatomic, strong) UITextField *textField;
@end
