//
//  UIButton+Helper.h
//  RealSocial
//
//  Created by 蒋陈浩 on 2018/3/14.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Helper)
+ (UIButton *)buttonWithImage:(NSString *)imageName;
+ (UIButton *)buttonWithTitle:(NSString *)title imageName:(NSString *)imageName;
@end
