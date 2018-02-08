//
//  RSImageUploadViewModel.m
//  RealSocial
//
//  Created by kuncai on 2018/2/3.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSImageUploadViewModel.h"
#import "RSPictureModel+WCTTableCoding.h"
#import "RSDBService.h"
#import <YYModel.h>
#import "RSNetWorkService.h"
#import "Spbasecgi.pbobjc.h"
#import "RSLoginService.h"

@interface RSImageUploadViewModel ()

@end
@implementation RSImageUploadViewModel {
    
}

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
-(instancetype)init {
    self = [super init];
    if (self) {

    }
    return self;
}

-(MGFacepp *)facepp {
    if (_facepp) {
        return _facepp;
    }
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:KMGFACEMODELNAME ofType:@""];
    NSData *modelData = [NSData dataWithContentsOfFile:modelPath];

    int faceSize = 100;
    int internal = 40;
    MGDetectROI detectROI = MGDetectROIMake(0, 0, 0, 0);
    _facepp = [[MGFacepp alloc] initWithModel:modelData
                                               maxFaceCount:10
                                              faceppSetting:^(MGFaceppConfig *config) {
//                                                  config.minFaceSize = faceSize;
//                                                  config.interval = internal;
//                                                  config.orientation = 90;
//                                                  config.detectionMode = MGFppDetectionModeTrackingFast;
//                                                  config.detectROI = detectROI;
//                                                  config.pixelFormatType = PixelFormatTypeRGBA;
                                                  config.orientation = 0;
                                              }];
    return _facepp;
}
-(BOOL)uploadImage:(UIImage *)image {
    NSData *fileData = UIImageJPEGRepresentation(image, 1.0);
    NSString *pictureId = [NSString stringWithFormat:@"%@_%@",[RSLoginService shareInstance].loginInfo.uid, [fileData md5String]]; 
    BOOL result = [self savePictureLocal:fileData pictureId:pictureId];
    if (result) {
        dispatch_async(dispatch_get_global_queue(0, 0),^{
            //进入另一个线程
            RSPictureModel *pictrueModel = [[RSPictureModel alloc] init];
            pictrueModel.pictureId = pictureId;
            pictrueModel.status = RSPictureStatusUploading;
            [[RSDBService db] updateAllRowsInTable:NSStringFromClass([RSPictureModel class]) onProperty:RSPictureModel.status withObject:pictrueModel];
//            [self savePictureNetWork:fileData pictureId:pictureId];
        });
    }
    return result;
}

-(void)savePictureNetWork:(NSData *)fileData pictureId:(NSString *)pictureId{
    RSUpLoadImgReq *req = [RSUpLoadImgReq new];
    req.cliImgId = [NSData dataWithHexString:pictureId];
    req.total = [fileData length];
    [self sendPicture:req data:fileData pictureId:pictureId];
}

-(void)sendPicture:(RSUpLoadImgReq *)req data:(NSData *)fileData pictureId:(NSString *)pictureId{
    NSInteger perBuff = 100000;
    req.buff = [fileData subdataWithRange:NSMakeRange(req.offSet, perBuff)];
    RSRequest *request = [[RSRequest alloc] init];
    request.mokeResponseData = [self moke];
    request.cgiName = @"uploadImage";
    request.data = [req data];
    @weakify(self);
    [[RSNetWorkService sendRequest:request] subscribeCompleted:^{
        @RSStrongify(self);
        NSInteger offSet = req.offSet + perBuff;
        if (offSet + perBuff > req.total) {
            
        }
        NSData *buff = [fileData subdataWithRange:NSMakeRange(offSet, perBuff)];
        if (buff) {
            req.offSet = offSet;
            [self sendPicture:req data:fileData pictureId:pictureId];
        } else {
            //上传完成
            RSPictureModel *pictrueModel = [[RSPictureModel alloc] init];
            pictrueModel.pictureId = pictureId;
            pictrueModel.status = RSPictureStatusUploadFinish;
            [[RSDBService db] updateAllRowsInTable:NSStringFromClass([RSPictureModel class]) onProperty:RSPictureModel.status withObject:pictrueModel];
        }
    }];
}

-(NSData *)moke {
    RSUpLoadImgResp *resp = [RSUpLoadImgResp new];
    return [resp data];
}

-(BOOL)savePictureLocal:(NSData *)fileData pictureId:(NSString *)pictureId {
    UIImage *image = [UIImage imageWithData:fileData];
    NSString *pictureDir = [RSImageUploadViewModel localPictureDir];
    NSError *error=nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:pictureDir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:pictureDir withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"%@", error);
            return NO;
        }
    }
    NSString *picturePath = [RSImageUploadViewModel localPicturePathWithPictureId:pictureId];
    BOOL result = [fileData writeToFile:picturePath atomically:YES];
    if (result) {
        NSLog(@"writeToFile:%@ success",picturePath);
        MGImageData *imageData = [[MGImageData alloc] initWithImage:image];
        [self.facepp beginDetectionFrame];
        NSArray *faceInfos = [self.facepp detectWithImageData:imageData];
        
        for (MGFaceInfo *faceInfo in faceInfos) {
            [self.facepp GetGetLandmark:faceInfo isSmooth:YES pointsNumber:81];
            [self.facepp GetAttribute3D:faceInfo];
            [self.facepp GetAttributeAgeGenderStatus:faceInfo];
            [self.facepp GetAttributeMouseStatus:faceInfo];
            [self.facepp GetAttributeEyeStatus:faceInfo];
            [self.facepp GetMinorityStatus:faceInfo];
            [self.facepp GetBlurnessStatus:faceInfo];
        }
        
        [self.facepp endDetectionFrame];
        RSPictureModel *pictrueModel = [[RSPictureModel alloc] init];
        pictrueModel.width = image.size.width;
        pictrueModel.height = image.size.height;
        pictrueModel.pictureId = pictureId;
        pictrueModel.info = [faceInfos yy_modelToJSONString];
        if (![[RSDBService db] insertObject:pictrueModel into:NSStringFromClass([RSPictureModel class])]) {
            //save db fail
            [[NSFileManager defaultManager] removeItemAtPath:picturePath error:nil];
            return NO;
        }
    } else {
        NSLog(@"writeToFile:%@ fail",picturePath);
        return NO;
    }
    return YES;
}
@end
