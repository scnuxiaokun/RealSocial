//
//  RSImageDownloadService.h
//  RealSocial
//
//  Created by kuncai on 2018/2/25.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SDWebImageManager.h>
//typedef void(^RSImageDownloadServiceCompletionHandler)(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL);
@interface RSImageDownloadOperation : NSObject
@property (nonatomic, strong) id <SDWebImageOperation> SDWebImageOperation;
@property (nonatomic, copy) SDInternalCompletionBlock completionHandler;
@property (nonatomic, strong) NSURL *url;
@end
@interface RSImageDownloadService : NSObject
@property (nonatomic, strong) NSMutableArray *downloadOperationQueue;
@property (nonatomic, strong) NSMutableDictionary *downloadOperationKeys;
@property (nonatomic, assign) NSInteger maxOperation;
//@property (nonatomic, strong) NSMutableDictionary *imagesDic;
+(RSImageDownloadService *)shareInstance;
//+(UIImage *)imageWithKey:(NSString *)key;
+(void)downloadImageWithUrl:(NSURL *)url completed:(SDInternalCompletionBlock)completionHandler;
@end
