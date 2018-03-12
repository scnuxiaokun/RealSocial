//
//  RSError.h
//  RealSocial
//
//  Created by 蒋陈浩 on 2018/3/11.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, ErrorType) {
    UploadImageToCDNError,
    AddFriendNetError,
    AddFriendImageError,
};
@interface RSError : NSObject
@property (nonatomic, assign) ErrorType errorType;
+ (instancetype)sharedError;
@end
