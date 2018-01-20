//
//  SYBViewModel.m
//  SybPlatform
//
//  Created by kuncai on 15-2-10.
//  Copyright (c) 2015年 Tencent. All rights reserved.
//

#import "RCViewModel.h"
#import <objc/runtime.h>
#import <YYDispatchQueuePool/YYDispatchQueuePool.h>
#import "QZPropertyInfo.h"

#define BINDED_KEY_PREFIX @"_binded_object_id_"

@implementation RCViewModel {
    BOOL _enabledDefaultCache;
    BOOL _enabledCustomCache;
}

+ (NSSet *)excludedPropertyKeys {
    NSMutableSet *set = [NSMutableSet setWithObjects:NSStringFromSelector(@selector(updateSignal)),NSStringFromSelector(@selector(errorSignal)),NSStringFromSelector(@selector(completeSignal)), nil];
    [set unionSet:[super excludedPropertyKeys]];
    return set;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        [self initPropertyCache];
        _enabledDefaultCache = NO;
        _enabledCustomCache = NO;
        [self resetStatus];
        _updateSignal = [RACReplaySubject subject];
        [_updateSignal sendNext:@(YES)];
        _errorSignal = [RACReplaySubject subject];
        _completeSignal = [RACReplaySubject subject];
        _viewModelStatus = RCViewModelStatusInit;
    }
    return self;
}

-(void)dealloc {
    [_updateSignal sendCompleted];
    [_completeSignal sendCompleted];
    [_errorSignal sendCompleted];
}

-(void)initPropertyCache {
    NSMutableDictionary *tmp = [[NSMutableDictionary alloc] init];
    [[self.class propertyInfos] enumerateObjectsUsingBlock:^(QZPropertyInfo *info, NSUInteger idx, BOOL *stop) {
        [tmp setObject:@(YES) forKey:[NSString stringWithFormat:@"%@_%@",info.name,info.type]];
    }];
    self.propertyCache = [tmp copy];
}

-(BOOL)isPropertyChanged:(NSCoder *)aDecoder {
    id object = [aDecoder decodeObjectForKey:@"propertyCache"];
    if (!object) {
        return NO;
    }
    
    NSDictionary *cache = (NSDictionary *)object;
    
    NSOrderedSet *propertySet = [self.class propertyInfos];
    if (propertySet.count != cache.count) {
        return YES;
    }
    BOOL __block isChanged = NO;
    [propertySet enumerateObjectsUsingBlock:^(QZPropertyInfo *info, NSUInteger idx, BOOL *stop) {
        NSString *key = [NSString stringWithFormat:@"%@_%@",info.name,info.type];
        if (![cache containsObjectForKey:key]) {
            *stop = YES;
            isChanged = YES;
        }
    }];
    return isChanged;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        _updateSignal = [RACReplaySubject subject];
        [_updateSignal sendNext:@(YES)];
        _errorSignal = [RACReplaySubject subject];
        _completeSignal = [RACReplaySubject subject];
        _viewModelStatus = RCViewModelStatusInit;
    }
    
    if ([self isPropertyChanged:aDecoder]) {
        NSDictionary *cache = [aDecoder decodeObjectForKey:@"propertyCache"];
        if (cache) {
            id copyObject = [[self.class alloc] init];
            [[self.class propertyInfos] enumerateObjectsUsingBlock:^(QZPropertyInfo *info, NSUInteger idx, BOOL *stop) {
                NSString *key = [NSString stringWithFormat:@"%@_%@",info.name,info.type];
                if (![cache containsObjectForKey:key]) {
                    //新增加/变更的属性
                    id value = [copyObject valueForKey:info.name];
                    if (info.weak && info.dynamic) {
                        // 对于动态的属性，`setValue:forKey:` 不会调用动态生成的 setter 方法，这样会导致属性为 weak 时没有赋值
                        SEL setter = QZSelectorWithCapitalizedKeyPattern("set", key, ":");
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                        [self performSelector:setter withObject:value];
#pragma clang diagnostic pop
                    } else {
                        [self setValue:value forKey:key];
                    }
                }
            }];
        }
        return self;
    }
    return self;
}


-(instancetype)initWithCache {
//    NSString *cacheKey = [self formatCacheKey:nil];
    return [self initWithCacheBy:nil];
}

-(instancetype)initWithCacheBy:(NSString *)cacheKey {

    cacheKey = [self formatCacheKey:cacheKey];
    if ([cacheKey length] > 0) {
        if (self.cacheDelegate) {
            id data = [self.cacheDelegate getCacheDataWithKey:cacheKey];
            if (data) {
                self = data;
                return self;
            }
        }
    }
    self = [self init];
    if (self) {
        self.cacheKey = cacheKey;
    }
    return self;
}

-(NSString *)formatCacheKey:(NSString *)cacheKey {
    return [NSString stringWithFormat:@"%@_%@",NSStringFromClass([self class]), cacheKey];
}

-(void)resetStatus {
//    [_statusSignal sendNext:@(SYBViewModelStatusInit)];
}

-(void)loadData {
    [self setStatusLoading];
    _viewModelStatus = RCViewModelStatusLoading;
}
-(void)reloadData {
    [self loadData];
    _viewModelStatus = RCViewModelStatusLoading;
}
-(void)loadMoreData {
    [self loadData];
    _viewModelStatus = RCViewModelStatusLoading;
}
//-(void)finishLoadData {
//    [self setCompleted];
//}

-(void)setStatusLoading {
    _viewModelStatus = RCViewModelStatusLoading;
}
-(void)setCompleted {
    [self saveData];
    
    _viewModelStatus = RCViewModelStatusFinish;
    [_updateSignal sendNext:@(NO)];
    [_completeSignal sendNext:@(YES)];
}

-(void)sendUpdateSignal {
    [_updateSignal sendNext:@(YES)];
}

-(void)saveData {
    if (self.cacheDelegate && self.cacheKey.length > 0) {
        RCViewModel * obj = [self copy];
        NSString *key = [self.cacheKey copy];
        @weakify(self);
        dispatch_async(YYDispatchQueueGetForQOS(NSQualityOfServiceBackground), ^{
            @FPStrongify(self);
            if (self.cacheDelegate && [key length] > 0) {
                [self.cacheDelegate cacheData:obj withKey:key];
            }
        });
    }
}

-(void)setErrorCode:(NSInteger)code {
        [self setErrorString:@"" errorCode:code];
}
-(void)setErrorString:(NSString *)msg {
    [self setErrorString:msg errorCode:0];
}
-(void)setErrorString:(NSString *)msg errorCode:(NSInteger)code {
    NSError *error = [NSError errorWithDomain:@"" code:code userInfo:@{NSLocalizedDescriptionKey:msg}];
    [self setError:error];
}
-(void)setError:(NSError *)error {
    _viewModelStatus = RCViewModelStatusFinish;
    [self.errorSignal sendNext:error];
}

-(NSDictionary *)getPropertyListWithClass:(Class)clazz {
    u_int count;
    objc_property_t * propertyArray = class_copyPropertyList(clazz, &count);
    NSMutableArray *tmpName = [[NSMutableArray alloc] initWithCapacity:count];
    NSMutableArray *tmpAttr = [[NSMutableArray alloc] initWithCapacity:count];
    for (int i = 0; i < count; i++) {
        const char* cPropertyName = property_getName(propertyArray[i]);
        NSString *propertyName = [NSString stringWithCString:cPropertyName encoding:NSUTF8StringEncoding];
        [tmpName addObject:propertyName];
        const char* attribute = property_getAttributes(propertyArray[i]);
        NSString *attributeString = [NSString stringWithCString:attribute encoding:NSUTF8StringEncoding];
        [tmpAttr addObject:attributeString];
    }
    free(propertyArray);
    return @{@"names":tmpName, @"attrs":tmpAttr};
}

-(NSDictionary *)getAllPropertyListWithClass:(Class)clazz {
    NSInteger maxDepth = 5;
    NSInteger depth = 0;
    NSMutableArray *tmpName = [[NSMutableArray alloc] init];
    NSMutableArray *tmpAttr = [[NSMutableArray alloc] init];
    Class topClass = [SYBManagedObject class];
    while (clazz != topClass) {
        if (depth++ >= maxDepth) {
            break;
        }
        NSDictionary *dic = [self getPropertyListWithClass:clazz];
        [tmpName addObjectsFromArray:[dic objectForKey:@"names"]];
        [tmpAttr addObjectsFromArray:[dic objectForKey:@"attrs"]];
        clazz = class_getSuperclass(clazz);
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSMutableArray *tmpNameUnique = [[NSMutableArray alloc] init];
    NSMutableArray *tmpAttrUnique = [[NSMutableArray alloc] init];
    for (NSInteger i=tmpName.count-1;i >= 0 ; i--) {
        //    for (int i=0; i<tmpName.count; i++) {
        if (![dic objectForKey:tmpName[i]]) {
            [dic setObject:@(YES) forKey:tmpName[i]];
            [tmpNameUnique addObject:tmpName[i]];
            [tmpAttrUnique addObject:tmpAttr[i]];
        }
    }
    return @{@"names":tmpNameUnique, @"attrs":tmpAttrUnique};
}

@end
