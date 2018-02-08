//
//  RSPictureListItemViewModel.m
//  RealSocial
//
//  Created by kuncai on 2018/2/4.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSPictureListItemViewModel.h"
#import "RSImageUploadViewModel.h"
#import "MGFaceInfo.h"
@implementation RSPictureListItemViewModel
-(NSString *)pictureFilePath {
    if (_pictureFilePath) {
        return _pictureFilePath;
    }
    _pictureFilePath = [RSImageUploadViewModel localPicturePathWithPictureId:self.pictureModel.pictureId];
    
    return _pictureFilePath;
}

-(NSString *)pictureInfo {
    if (_pictureInfo) {
        return _pictureInfo;
    }
    _pictureInfo = @"";
    switch (self.pictureModel.status) {
        case RSPictureStatusUploadFail:
            _pictureInfo = @"上传失败\n";
            break;
        case RSPictureStatusUploadFinish:
            _pictureInfo = @"已上传\n";
            break;
        case RSPictureStatusUploading:
            _pictureInfo = @"上传中\n";
            break;
        case RSPictureStatusInit:
            _pictureInfo = @"未上传\n";
            break;
        default:
            break;
    }
    for (MGFaceInfo *info in self.faceInfos) {
        NSMutableDictionary *tmp = [[NSMutableDictionary alloc] init];
        [tmp setValue:NSStringFromCGRect(info.rect) forKey:@"rect"];
        [tmp setValue:@(info.confidence) forKey:@"质量"];
        [tmp setValue:[NSString stringWithFormat:@"%f %f %f", info.pitch, info.yaw, info.roll] forKey:@"3D info"];
        [tmp setValue:@(info.age) forKey:@"年龄"];
        [tmp setValue:(info.gender == MGFemale) ? @"Female" : @"Male" forKey:@"性别"];
        [tmp setValue:@(info.blurness) forKey:@"blurness"];
        [tmp setValue:@(info.minority) forKey:@"minority"];
        [tmp setValue:[self eyeStatus:info.leftEyesStatus] forKey:@"左眼状态"];
        [tmp setValue:[self eyeStatus:info.rightEyesStatus] forKey:@"右眼状态"];
        [tmp setValue:[self mouseStatus:info.mouseStatus] forKey:@"嘴状态"];
        for (NSString *key in tmp) {
            NSString *value = [NSString stringWithFormat:@"%@",[tmp objectForKey:key]];
            _pictureInfo = [_pictureInfo stringByAppendingString:[NSString stringWithFormat:@"%@:%@\n",key,value]];
        }
        _pictureInfo = [_pictureInfo stringByAppendingString:@"/*********************************/\n"];
    }
    return _pictureInfo;
}

-(UIImage *)pictureImage {
    if (_pictureImage) {
        return _pictureImage;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:self.pictureFilePath]) {
        _pictureImage = [UIImage imageWithContentsOfFile:self.pictureFilePath];
    }
    return _pictureImage;
}

-(NSString *)eyeStatus:(MGEyeStatus)status {
    switch (status) {
        case MGEyeStatusNoGlassesOpen:
            return @"无眼镜睁眼";
            break;
        case MGEyeStatusNoGlassesClose:
            return @"无眼镜眼";
            break;
        case MGEyeStatusNormalGlassesOpen:
            return @"无眼镜睁眼";
            break;
        case MGEyeStatusNormalGlassesClose:
            return @"普通眼镜闭眼";
            break;
        case MGEyeStatuoDarkGlasses:
            return @"太阳眼镜";
            break;
        case MGEyeStatusOtherOcclusion:
            return @"其他情况";
            break;
        default:
            break;
    }
    return @"";
}

-(NSString *)mouseStatus:(MGMouthStatus)status {
    switch (status) {
        case MGMouthStatusOpen:
            return @"张开";
            break;
        case MGMouthStatusClose:
            return @"闭合";
            break;
        case MGMouthStatusMaskOrRespopator:
            return @"带口罩";
            break;
        case MGMouthStatusOtherOcclusion:
            return @"嘴被档住";
            break;
        default:
            break;
    }
    return @"";
}

-(NSString *)stringWithKey:(NSString *)key Value:(NSString *)value {
    return [NSString stringWithFormat:@"%@: %@",key,value];
}
@end
