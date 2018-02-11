//
//  RSContactModel.h
//  RealSocial
//
//  Created by kuncai on 2018/2/11.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSModel.h"
#import "Spcgicommdef.pbobjc.h"
@interface RSContactModel : RSModel
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *avatarUrl;
@property (nonatomic, assign) RSenSex sex;

@end
