//
//  CarouselView2.h
//  RealSocial
//
//  Created by kuncai on 2018/2/10.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RSPhotoBrowerDelegate <NSObject>

//点击事件
-(void)clickedAtIndex:(NSInteger)index;
@end

@interface RSPhotoBrower : UIView

//代理
@property(assign,nonatomic) id<RSPhotoBrowerDelegate> delegate;

//数据源
@property (strong,nonatomic) NSArray *dataSources;

//当前显示图片的索引
@property (nonatomic, assign) NSInteger currIndex;

//开启自动滚动
-(void)startAutoScroll;
@end  
