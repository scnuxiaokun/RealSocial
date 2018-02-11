//
//  RSAvatarImageView.h
//  RealSocial
//
//  Created by kuncai on 2018/2/10.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, RSAvatarImageViewType) {
    RSAvatarImageViewType48,
    RSAvatarImageViewType80,
};
@interface RSAvatarImageView : UIView
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSArray *urls;//多头像
@property (nonatomic, assign) RSAvatarImageViewType type;
@end
