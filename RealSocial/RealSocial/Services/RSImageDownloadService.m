//
//  RSImageDownloadService.m
//  RealSocial
//
//  Created by kuncai on 2018/2/25.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSImageDownloadService.h"
#import "SDWebImageOperation.h"
@implementation RSImageDownloadOperation
@end
@implementation RSImageDownloadService
+(RSImageDownloadService *)shareInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[RSImageDownloadService alloc] init];
    });
    return sharedInstance;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        self.maxOperation = 20;
        self.downloadOperationQueue = [[NSMutableArray alloc] init];
        self.downloadOperationKeys = [[NSMutableDictionary alloc] init];
    }
    return self;
}

+(void)addOperation:(id)operation {
    @synchronized(self){
        if ([[RSImageDownloadService shareInstance].downloadOperationQueue count] >= [RSImageDownloadService shareInstance].maxOperation) {
            RSImageDownloadOperation *operation = [[RSImageDownloadService shareInstance].downloadOperationQueue firstObject];
            [operation.SDWebImageOperation cancel];
            dispatch_sync_on_main_queue(^{
                if (operation.completionHandler) {
                    operation.completionHandler(nil, nil, [NSError errorWithString:@"image download too much"], 0, NO, operation.url);
                }
            });
            [[RSImageDownloadService shareInstance].downloadOperationQueue removeFirstObject];
        }
        [[RSImageDownloadService shareInstance].downloadOperationQueue addObject:operation];
    }
}

+(void)removeOperation:(id)operation {
    @synchronized(self){
        [[RSImageDownloadService shareInstance].downloadOperationQueue removeObject:operation];
    }
}

+(void)downloadImageWithUrl:(NSURL *)url completed:(SDInternalCompletionBlock)completionHandler {
    NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:url];
    UIImage *cachedImage = [[SDImageCache sharedImageCache] imageFromCacheForKey:key];
    if (cachedImage && completionHandler) {
        completionHandler(cachedImage, nil, nil, 0, YES, url);
        return;
    }
    RSImageDownloadOperation * operation = [RSImageDownloadOperation new];
    operation.completionHandler = completionHandler;
    operation.url = url;
    @weakify(self, operation);
    operation.SDWebImageOperation = [[SDWebImageManager sharedManager] loadImageWithURL:url options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        @RSStrongify(self,operation);
        [self removeOperation:operation];
        dispatch_sync_on_main_queue(^{
            if (completionHandler) {
                completionHandler(image, data, error, cacheType, finished, imageURL);
            }
        });
    }];
    [self addOperation:operation];
}
@end
