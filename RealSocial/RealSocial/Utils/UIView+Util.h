//
//  UIView+Util.h
//  FortunePlat
//
//  Created by kuncai on 15/11/17.
//  Copyright © 2015年 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Util)

typedef NS_ENUM(NSUInteger, FPBorderType){
    FPBorderTypeTop     = 1 << 0,
    FPBorderTypeRight    = 1 << 1,
    FPBorderTypeLeft  = 1 << 2,
    FPBorderTypeBottom = 1 << 3,
    FPBorderTypeNone = 1 << 4,
    FPBorderTypeAll  = ~0UL
};

- (UIViewController *)getViewController;

+ (id)viewWithNibName:(NSString *)nibName;

+ (id)viewWithNib;


/**
局部圆角
*/
- (void)corner:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;
- (void)corner:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii borderColor:(UIColor *)borderColor;
/**
 局部边框
 */
- (void)border:(FPBorderType)type borderColor:(UIColor *)borderColor;


//add by jesus
-(void) setBorderLayer:(CALayer *) layer;
-(CAShapeLayer *) borderLayer;
@end
