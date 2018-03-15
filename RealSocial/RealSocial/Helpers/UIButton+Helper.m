//
//  UIButton+Helper.m
//  RealSocial
//
//  Created by 蒋陈浩 on 2018/3/14.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "UIButton+Helper.h"

@implementation UIButton (Helper)
+ (UIButton *)buttonWithImage:(NSString *)imageName{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    return btn;
}
+ (UIButton *)buttonWithTitle:(NSString *)title imageName:(NSString *)imageName{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor main2] forState:UIControlStateNormal];
    return btn;
}
@end
