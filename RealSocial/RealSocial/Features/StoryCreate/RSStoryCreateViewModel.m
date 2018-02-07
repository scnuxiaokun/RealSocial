//
//  RSStoryCreateViewModel.m
//  RealSocial
//
//  Created by kuncai on 2018/2/7.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSStoryCreateViewModel.h"
#import "RSMediaService.h"

@implementation RSStoryCreateViewModel
-(RACSignal *)create:(UIImage *)picture toUsers:(NSArray *)users {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSData *fileData = UIImageJPEGRepresentation(picture, 0.1);
        NSString *pictureId = [RSMediaService pictureIdWithData:fileData];
        BOOL result = [RSMediaService savePictureLocal:fileData pictureId:pictureId];
        if (result) {
            [RSMediaService uploadPictureCDN:fileData pictureId:pictureId complete:^(BOOL isOK, NSError *error) {
                if (isOK) {
                    [subscriber sendCompleted];
                } else {
                    [subscriber sendError:error];
                }
            }];
        } else {
            [subscriber sendError:[NSError errorWithString:@"照片本地保存失败"]];
        }
//        dispatch_async(YYDispatchQueueGetForQOS(NSQualityOfServiceBackground), ^{
//            [NSThread sleepForTimeInterval:3];
//            [subscriber sendCompleted];
//        });
        return nil;
    }];
}
@end
