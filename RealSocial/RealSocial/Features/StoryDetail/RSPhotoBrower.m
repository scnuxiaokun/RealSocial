//
//  CarouselView2.m
//  RealSocial
//
//  Created by kuncai on 2018/2/10.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSPhotoBrower.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIView+WebCache.h>
#import <SDWebImageManager.h>
#import "RSImageDownloadService.h"

@interface RSPhotoBrower()<UIScrollViewDelegate>
//容器
@property (strong, nonatomic) UIScrollView *scrollView;
//分页控制器
@property (strong, nonatomic) UIPageControl *pageControl;
//定时器
//@property (nonatomic , strong) NSTimer *timer;
//当前显示的imageView
@property (nonatomic, strong) UIImageView *currImageView;
//待显示的imageView
@property (nonatomic, strong) UIImageView *backImageView;

//待显示图片的索引
@property (nonatomic, assign) NSInteger nextIndex;
//是否自动滚动,默认为不自动滚动
@property (assign,nonatomic) BOOL autoScroll;

@end

@implementation RSPhotoBrower

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubView];
    }
    return self;
}

- (void)initSubView {
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
}

- (CGFloat)height {
    return self.scrollView.frame.size.height;
}

- (CGFloat)width {
    return self.scrollView.frame.size.width;
}

#pragma mark 数据源的set方法
-(void)setDataSources:(NSArray *)dataSources
{
    if (!dataSources.count) return;
    
    _dataSources = dataSources;
    
    //设置当前的imageview
    NSString *imgUrl = [self.dataSources objectAtIndex:_currIndex];
//    [self.currImageView sd_setImageWithURL:[[NSURL alloc] initWithString:imgUrl] placeholderImage:nil];
    
    @weakify(self);
    [self.currImageView sd_addActivityIndicator];
    [self.currImageView setImage:[UIImage imageWithColor:[UIColor grayColor]]];
    [RSImageDownloadService downloadImageWithUrl:[NSURL URLWithString:imgUrl] completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        @RSStrongify(self);
        NSString *currentImgUrl = [self.dataSources objectAtIndex:self.currIndex];
        if (!currentImgUrl && !imageURL) {
            [self.currImageView sd_removeActivityIndicator];
            return;
        }
        if ([currentImgUrl isEqualToString:imageURL.absoluteString]) {
            [self.currImageView sd_removeActivityIndicator];
            if (!error) {
                [self.currImageView setImage:image];
            }
        }
    }];
    //设置下一张图片
//    imgUrl = [self.dataSources objectAtIndex:_nextIndex];
//    [self loadBackImageView:imgUrl];
    
    self.pageControl.numberOfPages = _dataSources.count;
    [self layoutSubviews];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    //有导航控制器时，会默认在scrollview上方添加64的内边距，这里强制设置为0
    _scrollView.contentInset = UIEdgeInsetsZero;
    
    _scrollView.frame = self.bounds;
    _pageControl.frame = CGRectMake(20, self.height - 30, self.width - 40, 30);
    [self setScrollViewContentSize];
}

#pragma mark 设置scrollView的contentSize
- (void)setScrollViewContentSize {
    if (_dataSources.count > 1) {
        self.scrollView.scrollEnabled = YES;
        self.scrollView.contentSize = CGSizeMake(self.width * 5, 0);
        self.scrollView.contentOffset = CGPointMake(self.width * 2, 0);
        self.currImageView.frame = CGRectMake(self.width * 2, 0, self.width, self.height);
        if(self.autoScroll)
        {
            [self startTimer];
        }
    } else {
        self.scrollView.scrollEnabled = NO;
        //只要一张图片时，scrollview不可滚动，且关闭定时器
        self.scrollView.contentSize = CGSizeZero;
        self.scrollView.contentOffset = CGPointZero;
        self.currImageView.frame = CGRectMake(0, 0, self.width, self.height);
        [self stopTimer];
    }
}

#pragma mark- --------定时器相关--------
-(void)startAutoScroll
{
    self.autoScroll = YES;
    [self startTimer];
}

- (void)startTimer {
    //如果只有一张图片，则直接返回，不开启定时器
    if (_dataSources.count <= 1) return;
    //如果定时器已开启，先停止再重新开启
//    if (self.timer) [self stopTimer];
//    self.timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
//    [self.timer invalidate];
//    self.timer = nil;
    self.autoScroll = NO;
}

- (void)nextPage {
    [self.scrollView setContentOffset:CGPointMake(self.width * 3, 0) animated:YES];
}

#pragma mark 图片点击代理事件
- (void)imageClick {
    if ([_delegate respondsToSelector:@selector(clickedAtIndex:)]){
        [_delegate clickedAtIndex:self.currIndex];
    }
}

- (void)changeCurrentPageWithOffset:(CGFloat)offsetX {
    if (offsetX < self.width * 1.5) {
        NSInteger index = self.currIndex - 1;
        if (index < 0) index = self.dataSources.count - 1;
        _pageControl.currentPage = index;
    } else if (offsetX > self.width * 2.5){
        _pageControl.currentPage = (self.currIndex + 1) % self.dataSources.count;
    } else {
        _pageControl.currentPage = self.currIndex;
    }
}

#pragma mark- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (CGSizeEqualToSize(CGSizeZero, scrollView.contentSize)) return;
    CGFloat offsetX = scrollView.contentOffset.x;
    NSLog(@"scrollViewDidScroll:%f", offsetX);
    //滚动过程中改变pageControl的当前页码
    [self changeCurrentPageWithOffset:offsetX];
    //向右滚动
    if (offsetX < self.width * 2) {
        self.backImageView.frame = CGRectMake(self.width, 0, self.width, self.height);
        
        self.nextIndex = self.currIndex - 1;
        if (self.nextIndex < 0) self.nextIndex = self.dataSources.count - 1;
        NSString *imgUrl = [self.dataSources objectAtIndex:self.nextIndex];
        [self loadBackImageView:imgUrl];
        if (offsetX <= self.width) {
            NSLog(@"scrollViewDidScroll:changeToNext向左");
            [self changeToNext];
        }
        
        //向左滚动
    } else if (offsetX > self.width * 2){
        self.backImageView.frame = CGRectMake(CGRectGetMaxX(_currImageView.frame), 0, self.width, self.height);
        
        self.nextIndex = (self.currIndex + 1) % self.dataSources.count;
        NSString *imgUrl = [self.dataSources objectAtIndex:self.nextIndex];
        [self loadBackImageView:imgUrl];
        if (offsetX >= self.width * 3) {
            NSLog(@"scrollViewDidScroll:changeToNext向右");
            [self changeToNext];
        }
    }
}

-(void)loadBackImageView:(NSString *)imgUrl {
    [self.backImageView sd_addActivityIndicator];
    [self.backImageView setImage:[UIImage imageWithColor:[UIColor grayColor]]];
    @weakify(self);
    [RSImageDownloadService downloadImageWithUrl:[NSURL URLWithString:imgUrl] completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        @RSStrongify(self);
        NSString *currentImgUrl = [self.dataSources objectAtIndex:self.nextIndex];
        if (!currentImgUrl && !imageURL) {
            [self.backImageView sd_removeActivityIndicator];
            return;
        }
        
        if ([currentImgUrl isEqualToString:imageURL.absoluteString]) {
            [self.backImageView sd_removeActivityIndicator];
            if (!error) {
                [self.backImageView setImage:image];
                if (self.currIndex == self.nextIndex) {
                    self.currImageView.image = self.backImageView.image;
                }
            }
        }
    }];
}

- (void)changeToNext {
    //切换到下一张图片
    self.currImageView.image = self.backImageView.image;
    self.scrollView.contentOffset = CGPointMake(self.width * 2, 0);
    [self.scrollView layoutSubviews];
    self.currIndex = self.nextIndex;
    self.pageControl.currentPage = self.currIndex;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.autoScroll) {
        [self stopTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(self.autoScroll)
    {
        [self startTimer];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint currPointInSelf = [_scrollView convertPoint:_currImageView.frame.origin toView:self];
    if (currPointInSelf.x >= -self.width / 2 && currPointInSelf.x <= self.width / 2) {
        NSLog(@"scrollViewDidEndDecelerating:setContentOffset");
        [self.scrollView setContentOffset:CGPointMake(self.width * 2, 0) animated:YES];
    } else {
        NSLog(@"scrollViewDidEndDecelerating:changeToNext");
        [self changeToNext];
    }
}

#pragma mark- 懒加载
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.scrollsToTop = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        //添加手势监听图片的点击
        [_scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)]];
        _currImageView = [[UIImageView alloc] init];
        _currImageView.contentMode = UIViewContentModeScaleAspectFill;
        _currImageView.clipsToBounds = YES;
        [_currImageView sd_setIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [_currImageView setImage:[UIImage imageWithColor:[UIColor grayColor]]];
        [_scrollView addSubview:_currImageView];
        _backImageView = [[UIImageView alloc] init];
        _backImageView.contentMode = UIViewContentModeScaleAspectFill;
        _backImageView.clipsToBounds = YES;
        [_backImageView sd_setIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [_backImageView setImage:[UIImage imageWithColor:[UIColor grayColor]]];
        [_scrollView addSubview:_backImageView];
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    }
    return _pageControl;
}

@end 
