//
//  UIViewController+Swizzle.h
//  FortunePlat
//
//  Created by aldwinlv on 16/8/19.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIViewController (Swizzle)

@property (nonatomic, assign) BOOL animating;
@property (nonatomic, weak) UIViewController *hk_parent;
@property (nonatomic, weak) UIViewController *push_ctr;



@end
