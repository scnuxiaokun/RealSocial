//
//  RSMediaService.m
//  RealSocial
//
//  Created by kuncai on 2018/2/7.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSMediaService.h"
#import "RSLoginService.h"
#import "RSPictureModel.h"
#import "RSDBService.h"
#import "RSPictureModel+WCTTableCoding.h"
#import <QiniuSDK.h>
//#import <Qiniu/QNResolver.h>
#import <HappyDNS.h>
//#import <Qiniu/QNDnsManager.h>

@implementation RSMediaService
+(NSString *)localPicturePathWithPictureId:(NSString *)pictureId {
    NSString *pictureName = [NSString stringWithFormat:@"picture_%@.jpg", pictureId];
    return [[self localPictureDir] stringByAppendingPathComponent:pictureName];
}
+(NSString *)localPictureDir {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *pictureDir = [docDir stringByAppendingPathComponent:@"pictures"];
    return pictureDir;
}

+(NSString *)pictureIdWithData:(NSData *)data {
    NSString *pictureId = [NSString stringWithFormat:@"%@_%@",[RSLoginService shareInstance].loginInfo.uid, [data md5String]];
    return pictureId;
}

+(BOOL)savePictureLocal:(NSData *)fileData pictureId:(NSString *)pictureId {
    NSString *pictureDir = [RSMediaService localPictureDir];
    NSError *error=nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:pictureDir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:pictureDir withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"%@", error);
            return NO;
        }
    }
    NSString *picturePath = [RSMediaService localPicturePathWithPictureId:pictureId];
    BOOL result = [fileData writeToFile:picturePath atomically:YES];
    if (result) {
        RSPictureModel *pictrueModel = [[RSPictureModel alloc] init];
        UIImage *image = [UIImage imageWithData:fileData];
        pictrueModel.width = image.size.width;
        pictrueModel.height = image.size.height;
        pictrueModel.pictureId = pictureId;
//        pictrueModel.info = [faceInfos yy_modelToJSONString];
        if (![[RSDBService db] insertObject:pictrueModel into:NSStringFromClass([RSPictureModel class])]) {
            //save db fail
            [[NSFileManager defaultManager] removeItemAtPath:picturePath error:nil];
            return NO;
        }
    }
    return result;
}

+(void)uploadPictureCDN:(NSData *)fileData pictureId:(NSString *)pictureId complete:(RSUploadCompletionHandler)completionHandler {
    RSPictureModel *pictrueModel = [[RSPictureModel alloc] init];
    pictrueModel.pictureId = pictureId;
    pictrueModel.status = RSPictureStatusUploading;
    [[RSDBService db] updateAllRowsInTable:NSStringFromClass([RSPictureModel class]) onProperty:RSPictureModel.status withObject:pictrueModel];
    QNConfiguration *config = [QNConfiguration build:^(QNConfigurationBuilder *builder) {
        builder.zone = [QNFixedZone zone2];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [array addObject:[QNResolver systemResolver]];
        QNDnsManager *dns = [[QNDnsManager alloc] init:array networkInfo:[QNNetworkInfo normal]];
        builder.dns = dns;
        //是否选择  https  上传
        builder.useHttps = NO;
        //设置断点续传
//        NSError *error;
//        builder.recorder =  [QNFileRecorder fileRecorderWithFolder:@"保存目录" error:&error];
    }];
    //重用uploadManager。一般地，只需要创建一个uploadManager对象
    NSString * token = @"hf-tV28lhKn3V7DQGssjEJubR6lTN9fn4bH47k_K:lOSt8aGqQgYaPwg8Qd_BJX9-maA=:eyJzY29wZSI6InNreXBsYW4iLCJkZWFkbGluZSI6MTUxODAzODkwMH0=";
    NSString * key = pictureId;
    
    QNUploadManager *uploadManage = [QNUploadManager  sharedInstanceWithConfiguration:config];
//    NSString *filePath = [RSMediaService localPicturePathWithPictureId:pictureId];
//    [uploadManage putFile:filePath key:key token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//        if(info.ok){
//            NSLog(@"请求成功");
//            RSPictureModel *pictrueModel = [[RSPictureModel alloc] init];
//            pictrueModel.pictureId = pictureId;
//            pictrueModel.status = RSPictureStatusUploadFinish;
//            [[RSDBService db] updateAllRowsInTable:NSStringFromClass([RSPictureModel class]) onProperty:RSPictureModel.status withObject:pictrueModel];
//            if (completionHandler) {
//                completionHandler(YES, nil);
//            }
//            //            NSString *hash = [resp objectForKey:@"hash"];
//        }else{
//            NSLog(@"失败");
//            if (completionHandler) {
//                completionHandler(YES, info.error);
//            }
//        }
//    } option:nil];
    [uploadManage putData:fileData key:key token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        if(info.ok){
            NSLog(@"请求成功");
            RSPictureModel *pictrueModel = [[RSPictureModel alloc] init];
            pictrueModel.pictureId = pictureId;
            pictrueModel.status = RSPictureStatusUploadFinish;
            [[RSDBService db] updateAllRowsInTable:NSStringFromClass([RSPictureModel class]) onProperty:RSPictureModel.status withObject:pictrueModel];
            if (completionHandler) {
                completionHandler(YES, nil);
            }
//            NSString *hash = [resp objectForKey:@"hash"];
        }else{
            NSLog(@"失败");
            if (completionHandler) {
                completionHandler(YES, info.error);
            }
        }
    } option:nil];
}
@end
