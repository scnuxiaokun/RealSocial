//
//  UIView+Util.m
//  FortunePlat
//
//  Created by kuncai on 15/11/17.
//  Copyright © 2015年 Tencent. All rights reserved.
//

#import "UIView+Util.h"
#import <objc/runtime.h>


@implementation UIView (Util)
- (UIViewController *)getViewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

+ (id)viewWithNibName:(NSString *)nibName {
    UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
    //    UIView *view = [UIView viewWithNibName:nib];
    NSArray *views = [nib instantiateWithOwner:nil options:nil];
    
    if (views.count > 1) {
        return views[0];
        
    } else {
        return views.lastObject;
    }
}

+ (id)viewWithNib {
    return [self viewWithNibName:[self className]];
}


- (void)corner:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii {
    //圆角
    NSString *layerName = @"__corner_layer__modify_by_jesus";
    CAShapeLayer *maskLayer;
    if (!self.layer.mask || ![layerName isEqualToString:self.layer.mask.name]) {
        maskLayer=[[CAShapeLayer alloc] init];
        self.layer.mask = maskLayer;
    } else {
        maskLayer= (CAShapeLayer*)self.layer.mask;
    }
    UIBezierPath *maskPath=  [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:cornerRadii];
    maskLayer.frame=self.bounds;
    maskLayer.path=maskPath.CGPath;
}

- (void)corner:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii borderColor:(UIColor *)borderColor{
    [self corner:corners cornerRadii:cornerRadii];
    UIBezierPath *maskPath=  [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:cornerRadii];
    
    
    CAShapeLayer *maskLayer=[self borderLayer];
    if (!maskLayer) {
        maskLayer = [CAShapeLayer new];
        [self setBorderLayer:maskLayer];
        [self.layer addSublayer:maskLayer];
        maskLayer.name = @"borderLayer";
    }
    maskLayer.frame=self.bounds;
    maskLayer.path=maskPath.CGPath;
    maskLayer.fillColor = [UIColor clearColor].CGColor;
    maskLayer.strokeColor = borderColor.CGColor;
    
}

-(void) setBorderLayer:(CALayer *) layer{
    objc_setAssociatedObject(self, @"borderLayer", layer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CAShapeLayer *) borderLayer {
    return objc_getAssociatedObject(self, @"borderLayer");
}


- (void)border:(FPBorderType)type borderColor:(UIColor *)borderColor {
    
    CGFloat borderSize = 1 / [UIScreen mainScreen].scale;
    if (type & FPBorderTypeTop) {
        CALayer *borderLayer = [CALayer layer];
        borderLayer.backgroundColor = borderColor.CGColor;
        borderLayer.frame = CGRectMake(0, 0, self.width, borderSize);
        borderLayer.name = @"FPBorderTypeTop";
        [self removeSubLayerByName:borderLayer.name];
        [self.layer addSublayer:borderLayer];
    }
    if (type & FPBorderTypeBottom) {
        CALayer *borderLayer = [CALayer layer];
        borderLayer.backgroundColor = borderColor.CGColor;
        borderLayer.frame = CGRectMake(0, self.height - borderSize, self.width, borderSize);
        borderLayer.name = @"FPBorderTypeBottom";
        [self removeSubLayerByName:borderLayer.name];
        [self.layer addSublayer:borderLayer];
    }
    if (type & FPBorderTypeRight) {
        CALayer *borderLayer = [CALayer layer];
        borderLayer.backgroundColor = borderColor.CGColor;
        borderLayer.frame = CGRectMake(0, 0, borderSize, self.height);
        borderLayer.name = @"FPBorderTypeRight";
        [self removeSubLayerByName:borderLayer.name];
        [self.layer addSublayer:borderLayer];
    }
    if (type & FPBorderTypeLeft) {
        CALayer *borderLayer = [CALayer layer];
        borderLayer.backgroundColor = borderColor.CGColor;
        borderLayer.frame = CGRectMake(self.width - borderSize, 0, borderSize, self.height);
        borderLayer.name = @"FPBorderTypeLeft";
        [self removeSubLayerByName:borderLayer.name];
        [self.layer addSublayer:borderLayer];
    }
    if (type & FPBorderTypeNone) {
        [self removeSubLayerByName:@"FPBorderTypeLeft"];
        [self removeSubLayerByName:@"FPBorderTypeRight"];
        [self removeSubLayerByName:@"FPBorderTypeBottom"];
        [self removeSubLayerByName:@"FPBorderTypeTop"];
    }
}

-(void)removeSubLayerByName:(NSString *)name {
    NSArray *tmpArray = [NSArray arrayWithArray:self.layer.sublayers];
    for (CALayer *layer in tmpArray) {
        if ([layer.name isEqualToString:name]) {
            [layer removeFromSuperlayer];
        }
    }
}

@end
