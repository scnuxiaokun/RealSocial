//
//  RSAddFriendsViewModel.m
//  RealSocial
//
//  Created by 蒋陈浩 on 2018/3/9.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSAddFriendsViewModel.h"
#import "RSMediaService.h"
#import "RSRequest.h"
#import "RSNetWorkService.h"
#import "RSRequestFactory.h"
#import "Spbasecgi.pbobjc.h"
#import "RSContactService.h"
#import "Spcgicomm.pbobjc.h"

@implementation RSAddFriendsViewModel

+ (RACSignal *)createToAddFriends:(UIImage *)image isUploadImage:(BOOL)isUploadImage{
    @weakify(self);
    RACReplaySubject *signal = [RACReplaySubject subject];
    NSData *fileData = UIImageJPEGRepresentation(image, 0.1);
    NSString *pictureId = [RSMediaService pictureIdWithData:fileData];
    if (isUploadImage) {
        [self addFriendsWithPictureId:pictureId withSignal:signal];
    }else{
        [RSMediaService uploadPictureCDN:fileData pictureId:pictureId complete:^(BOOL isOK, NSError *error) {
            if (error) {
                RSError* newError = [RSError sharedError];
                newError.errorType = UploadImageToCDNError;
                [signal sendError:error];
               
            }
            if (isOK) {
                [self addFriendsWithPictureId:pictureId withSignal:signal];
            }
        }];
    }
    return signal;
}

+ (void)addFriendsWithPictureId:(NSString *)pictureId withSignal:(RACReplaySubject *)signal{
    NSError *error;
    NSString *imgURL = [RSMediaService urlWithPictureId:pictureId];
                RSAddFriendReq *req = [RSAddFriendReq new];
                req.imgurl = imgURL;
                RSRequest *request = [RSRequestFactory requestWithReq:req resp:[RSAddFriendResp class] moke:nil];
                [[RSNetWorkService sendRequest:request] subscribeNext:^(id  _Nullable x) {
                    RSAddFriendResp* data = (RSAddFriendResp *)x;
    
                    if (!data.toAddArray[0]) {
                        RSError* newError = [RSError sharedError];
                        newError.errorType = AddFriendImageError;
                        [signal sendError:nil];
                        
                    }else{
                        NSDictionary *dic ;
                        RSContact *item = (RSContact *)data.toAddArray[0];;
                        RSContact *item2 = (RSContact *)data.toAddArray[1];
                        [dic setValue:item.headImgURL forKey:@"headImageOne"];
                        [dic setValue:item2.headImgURL forKey:@"headImageTwo"];
                        [dic setValue:item2.userName forKey:@"friendName"];
                        [signal sendNext:dic];
                    }
                    //
                } error:^(NSError * _Nullable error) {
                    RSError* newError = [RSError sharedError];
                    newError.errorType = AddFriendNetError;
                    
                    [signal sendError:error];
                } completed:^{
                    //[signal sendCompleted];
                }];
}
@end



