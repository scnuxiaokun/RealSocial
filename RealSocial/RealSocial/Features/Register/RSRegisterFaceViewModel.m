//
//  RSRegisterFaceViewModel.m
//  RealSocial
//
//  Created by kuncai on 2018/3/8.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSRegisterFaceViewModel.h"
#import "Spbasecgi.pbobjc.h"
#import "RSMediaService.h"
#import "RSRequestFactory.h"
#import "Spcgicomm.pbobjc.h"

@implementation RSRegisterFaceViewModel
-(RACSignal *)uploadFaceImage:(UIImage *)image {
    NSData *fileData = UIImageJPEGRepresentation(image, 0.1);
    RSRegisterFaceReq *req = [RSRegisterFaceReq new];
    RSFaceBuffer *faceBuffer = [RSFaceBuffer new];
    faceBuffer.buffer = fileData;
    [req.faceBufferListArray addObject:faceBuffer];
    RSRequest *request = [RSRequestFactory requestWithReq:req resp:[RSRegisterFaceResp class] moke:nil];
    RACSignal *signal = [RSNetWorkService sendRequest:request];
    return signal;
}
@end
