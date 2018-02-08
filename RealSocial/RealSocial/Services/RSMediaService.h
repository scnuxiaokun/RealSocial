//
//  RSMediaService.h
//  RealSocial
//
//  Created by kuncai on 2018/2/7.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^RSUploadCompletionHandler)(BOOL isOK, NSError *error);
@interface RSMediaService : NSObject
+(NSString *)localPicturePathWithPictureId:(NSString *)pictureId;
+(NSString *)localPictureDir;
+(NSString *)pictureIdWithData:(NSData *)data;
+(BOOL)savePictureLocal:(NSData *)fileData pictureId:(NSString *)pictureId;
+(void)uploadPictureCDN:(NSData *)fileData pictureId:(NSString *)pictureId complete:(RSUploadCompletionHandler)completionHandler;
+(NSString *)urlWithPictureId:(NSString *)pictureId;
@end
