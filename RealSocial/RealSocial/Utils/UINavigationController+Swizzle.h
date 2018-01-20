//
//  UINavigationController+Swizzle.h
//  FortunePlat
//
//  Created by aldwinlv on 16/8/19.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UINavigationController(Swizzle)
- (void)popToRootViewControllerAnimated: (BOOL)flag completion: (void (^ __nullable)(void))completion;
@end
