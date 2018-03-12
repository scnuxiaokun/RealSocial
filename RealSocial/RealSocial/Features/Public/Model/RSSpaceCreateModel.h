//
//  RSSpaceCreateModel.h
//  RealSocial
//
//  Created by kuncai on 2018/2/11.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSModel.h"
#import "Spcgicommdef.pbobjc.h"
//typedef NS_ENUM(NSInteger, RSSpaceCreateModelType) {
//    RSSpaceCreateModelTypeSignal,////添加Star到Space与创建单人Space
//    RSSpaceCreateModelTypeGruop,////创建多人Space
//    RSSpaceCreateModelTypeAllFriends,
//    RSSpaceCreateModelTypeMemories,
//};

typedef NS_ENUM(NSUInteger ,RSSpaceCreateModelStatus) {
    RSSpaceCreateModelStatusInit,
    RSSpaceCreateModelStatusCreating,
    RSSpaceCreateModelStatusFinish,
    RSSpaceCreateModelStatusFail,
};
@interface RSSpaceCreateModel : RSModel
@property(nonatomic, strong) NSString *mediaId;
@property(nonatomic, assign) RSenReceiverType type;
@property(nonatomic, assign) RSSpaceCreateModelStatus status;
@property(nonatomic, strong) NSArray *users;
@property(nonatomic, strong) NSArray *spaces;
@property(nonatomic, strong) NSDate *createTime;
@property(nonatomic, strong) NSString *creator;
@property(nonatomic, strong) NSString *mediaPath;
@end
