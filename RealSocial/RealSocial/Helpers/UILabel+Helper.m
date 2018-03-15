//
//  UILabel+Helper.m
//  RealSocial
//
//  Created by 蒋陈浩 on 2018/3/14.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "UILabel+Helper.h"

@implementation UILabel (Helper)
+ (UILabel *)lableWithText:(NSString *)text fontSize:(CGFloat)fontSize alpha:(CGFloat)alpha{
    UILabel *lable = [[UILabel alloc] init];
        lable.text = text;
        lable.textColor = RGBA(9, 10, 70, alpha);
        lable.font = [UIFont fontWithName:@"PingFang-SC-Semibold" size:fontSize];
        lable.textAlignment = NSTextAlignmentCenter;
    return lable;
}

+ (UILabel *)lableWithText:(NSString *)text fontSize:(CGFloat)fontSize{
    UILabel *lable = [[UILabel alloc] init];
    lable.text = text;
    lable.textColor = [UIColor main2];
    lable.font = [UIFont fontWithName:@"PingFang-SC-Semibold" size:fontSize];
    lable.textAlignment = NSTextAlignmentCenter;
    return lable;
}
@end
