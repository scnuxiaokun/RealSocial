//
//  SYBViewModel.h
//  SybPlatform
//
//  Created by kuncai on 15-2-10.
//  Copyright (c) 2015年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYCache.h"
#import "QZModelObject.h"

//#import "SYBDatabaseContext.h"

@class RCViewModel;

@protocol RCTableViewCellProtocol <NSObject>

@required
+ (NSString *)identifier;
+ (CGFloat)heightForItem:(RCViewModel *)viewModel;
@property(nonatomic, strong)RCViewModel *viewModel;
@property(nonatomic, strong)NSIndexPath *indexPath;
@property(nonatomic, weak) id delegate;
@optional
@end

@protocol RCTableViewViewModelProtocol <NSObject>
@property(nonatomic, assign) NSInteger count;
@property(nonatomic, assign) NSInteger currentIndex;
@end

@protocol FPViewModelCacheProtocol <NSObject>
-(void)cacheData:(id)data withKey:(NSString *)key;
-(id)getCacheDataWithKey:(NSString *)key;
@end
/**
 viewModel的自动缓存方式3种：
 1、默认以sybId为cache key缓存当前viewmodel。
    使用：
         需要如加入如下代码到子类的头文件中
         BIND_OBJECT_ID(sybId)
         @property (nonatomic, assign) JceInt64 sybId;
         viewModel,数据加载完成时需要setCompleted,此时触发保存缓存逻辑
         初始化viewModel时使用initWithCache方法,返回用缓存初始好的viewModel对象
 2、自定义缓存的key，(可以是NSInteger/NSString)。
    使用：
         需要如加入如下代码到子类的头文件中
         BIND_OBJECT_ID(xxID)
         @property (nonatomic, assign) NSInteger xxID;
         viewModel,数据加载完成时需要setCompleted,此时触发保存缓存逻辑，需要保证当前xxID非空
         初始化viewModel时使用initWithCacheKey:方法，参数是xxID,返回用缓存初始好的viewModel对象,
 3、自定义缓存逻辑
    使用：
        重载initWithCache或initWithCacheKey:方法，返回用缓存初始好的viewModel对象
        重载saveData方法，保存viewmodel，此方法在setCompleted时自动调用
 */

@interface RCViewModel : QZModelObject
typedef enum
{
    RCViewModelStatusInit,
    RCViewModelStatusLoading,
    RCViewModelStatusFinish
} RCViewModelStatus;

@property (nonatomic, retain) NSDictionary * propertyCache;
/**
 *  默认使用手游宝ID为key，保存viewmodel数据
    子类如果需要缓存数据，需要如加入如下代码到子类的头文件中
     BIND_OBJECT_ID(sybId)
     @property (nonatomic, assign) JceInt64 sybId;
 */
//@property (nonatomic, assign) JceInt64 sybId;
/**
 *  viewmodel状态
 */
@property (nonatomic, assign) RCViewModelStatus viewModelStatus;
/**
 *  默认保存数据的数据库对象,子类可以直接使用
 */
//@property (nonatomic, retain) SYBDatabaseContext *defaultContext;
/**
 *  viewmodel状态信号，订阅后可以获取viewmodel状态的变更
     [[self.viewModel.statusSignal deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(NSNumber *x) {
         if ([x intValue] == SYBViewModelStatusFinish) {
         @SYBStrongify(self);
             [self->_tableView reloadData];
         }
     }];
 */

//@property (nonatomic, retain) RACSubject *statusSignal;
/**
 *  viewmodel错误信号，订阅后可以获取viewmodel状态的变更
 [[self.viewModel.errorSignal deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(NSNumber *x) {
 if ([x intValue] == SYBViewModelStatusFinish) {
 @SYBStrongify(self);
 }];
 */
@property (nonatomic, retain, readonly) RACSubject *errorSignal;
@property (nonatomic, retain, readonly) RACSubject *completeSignal;
@property (nonatomic, retain, readonly) RACSubject *updateSignal;
@property (nonatomic, weak) id<FPViewModelCacheProtocol> cacheDelegate;
@property (nonatomic, retain) NSString *cacheKey;
/**
 *  加载数据需要继承的接口,加载开始和加载完成需要子类调用setStatusLoading和setCompleted来维护viewmode状态
 */
-(void)loadData;
/**
 *  刷新数据，默认调用loadData
 */
-(void)reloadData;
/**
 *  加载更多数据,默认调用loadData
 */
-(void)loadMoreData;
/**
 *  此方法弃用
 */
//-(void)finishLoadData;
/**
 *  保存数据，需要自定义缓存逻辑的继承此方法
 */

-(void)saveData;
/**
 *  重置viewmodel状态
 */
-(void)resetStatus;
/**
 *  设置viewmodwl状态为加载中，statusSignal会发出加载中信号
 */
-(void)setStatusLoading;
/**
 *  设置viewmodel状态为加载完成，statusSignal会发出完成信号
 */
-(void)setCompleted;

-(void)sendUpdateSignal;
/**
 *  使用缓存初始化viewmodel，默认使用sybid来缓存数据,加载完成数据需要设置setCompleted,子类实现需要设置属性
 *  
    BIND_OBJECT_ID(sybId)
     @property (nonatomic, assign) JceInt64 sybId;
 
    如果需要自定义缓存，需要实现此方法
 
 *  @return SYBViewModel
 */
-(instancetype)initWithCache;
/**
 *  使用缓存初始化viewmodel，使用cacheKey来缓存数据,加载完成数据需要设置setCompleted,子类实现需要设置属性
 *  BIND_OBJECT_ID(cacheKey)
     @property (nonatomic, copy) NSString cacheKey;
 *
 *  @param cacheKey 
 *
 *  @return SYBViewModel
 */
-(instancetype)initWithCacheBy:(NSString *)cacheKey;
-(NSString *)formatCacheKey:(NSString *)cacheKey;
-(void)setErrorCode:(NSInteger)code;
-(void)setErrorString:(NSString *)msg;
-(void)setErrorString:(NSString *)msg errorCode:(NSInteger)code;
-(void)setError:(NSError *)error;
@end
