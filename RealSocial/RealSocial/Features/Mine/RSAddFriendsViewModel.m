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
                    RSAddFriendResp* resp = (RSAddFriendResp *)x;
    
                    /*
                     opCode = 0 图像失败-重拍-人脸识别不清晰
                     opCode = 1 等待确认-结束
                     opCode = 2 已是好友
                     opCode = 3 已加好友
                     */
//                    resp.opCode = 2;
                    if (resp.opCode == 0) {
                        RSError* newError = [RSError sharedError];
                        newError.errorType = AddFriendImageError;
                        [signal sendError:nil];
                        
                    }else{
                        NSInteger code = resp.opCode;
                        NSString *codeStr = [NSString stringWithFormat:@"%li",code];
                        if(resp.toAddArray_Count > 0){
                            RSContact *item = resp.toAddArray[resp.toAddArray_Count-1];
                            //                        item.headImgURL = @"http://www.qqzhi.com/uploadpic/2014-09-23/000247589.jpg";
                            //                        item.nickName = @"浩哥不缺钱";
                            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                            
                            [dic setValue:codeStr forKey:@"opCode"];
                            [dic setValue:item.headImgURL forKey:@"friendHeadImageUrl"];
                            [dic setValue:item.nickName forKey:@"friendName"];
                            [signal sendNext:dic];
                        }else{
                            RSError* newError = [RSError sharedError];
                            newError.errorType = AddFriendImageError;
                            [signal sendError:nil];
                        }
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



