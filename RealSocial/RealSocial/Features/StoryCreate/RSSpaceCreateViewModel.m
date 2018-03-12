//
//  RSStoryCreateViewModel.m
//  RealSocial
//
//  Created by kuncai on 2018/2/7.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSSpaceCreateViewModel.h"
#import "RSMediaService.h"
//#import "RSNetWorkService.h"
//#import "Spspacecgi.pbobjc.h"
#import "Spcgicommdef.pbobjc.h"
//#import "RSRequestFactory.h"
//#import "RSLoginService.h"
//#import "RSSpaceCreateModel+WCTTableCoding.h"
//#import "RSDBService.h"
#import "RSSpaceService.h"

@implementation RSSpaceCreateViewModel

-(RACSignal *)create:(UIImage *)picture toUsers:(NSArray *)users toSpaces:(NSArray *)spaces{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self);
        if (!picture) {
            [subscriber sendError:[NSError errorWithString:@"发送内容不能为空"]];
            return nil;
        }
        if ([users count]<=0 && [spaces count]<=0) {
            [subscriber sendError:[NSError errorWithString:@"发送对象不能为空"]];
            return nil;
        }
        NSData *fileData = UIImageJPEGRepresentation(picture, 0.1);
        NSString *pictureId = [RSMediaService pictureIdWithData:fileData];
        BOOL result = [RSMediaService savePictureLocal:fileData pictureId:pictureId];
        if (result == NO) {
            [subscriber sendError:[NSError errorWithString:@"照片本地保存失败"]];
            return nil;
        }
        [[RSSpaceService shareInstance] create:fileData mediaId:pictureId toUsers:users toSpaces:spaces];
        [subscriber sendCompleted];
        return nil;
    }];
}

-(RACSignal *)createToAllFriends:(UIImage *)picture {
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self);
        if (!picture) {
            [subscriber sendError:[NSError errorWithString:@"发送内容不能为空"]];
            return nil;
        }
        NSData *fileData = UIImageJPEGRepresentation(picture, 0.1);
        NSString *pictureId = [RSMediaService pictureIdWithData:fileData];
        BOOL result = [RSMediaService savePictureLocal:fileData pictureId:pictureId];
        if (result == NO) {
            [subscriber sendError:[NSError errorWithString:@"照片本地保存失败"]];
            return nil;
        }
        [[RSSpaceService shareInstance] createToAllFriends:fileData mediaId:pictureId];
        [subscriber sendCompleted];
        return nil;
    }];
}
-(RACSignal *)createToMemories:(UIImage *)picture {
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self);
        if (!picture) {
            [subscriber sendError:[NSError errorWithString:@"发送内容不能为空"]];
            return nil;
        }
        NSData *fileData = UIImageJPEGRepresentation(picture, 0.1);
        NSString *pictureId = [RSMediaService pictureIdWithData:fileData];
        BOOL result = [RSMediaService savePictureLocal:fileData pictureId:pictureId];
        if (result == NO) {
            [subscriber sendError:[NSError errorWithString:@"照片本地保存失败"]];
            return nil;
        }
        [[RSSpaceService shareInstance] createToMemories:fileData mediaId:pictureId];
        [subscriber sendCompleted];
        return nil;
    }];
}
@end
