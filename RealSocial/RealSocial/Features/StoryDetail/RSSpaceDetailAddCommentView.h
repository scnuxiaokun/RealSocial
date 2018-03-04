//
//  RSSpaceDetailCommentView.h
//  RealSocial
//
//  Created by kuncai on 2018/3/3.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSpaceDetailAddCommentViewModel.h"
@interface RSSpaceDetailAddCommentView : UIView <UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) RSSpaceDetailAddCommentViewModel *viewModel;
@end
