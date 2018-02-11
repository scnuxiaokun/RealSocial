//
//  RSMessageModel.h
//  RealSocial
//
//  Created by kuncai on 2018/2/4.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSViewModel.h"
@interface RSMessageModel : RSViewModel

@property(nonatomic, retain) NSString *messageId;
@property(nonatomic, assign) NSInteger type;
@property(nonatomic, strong) NSData *content;
@property(nonatomic, strong) NSDate *createTime;
@property(nonatomic, strong) NSData *nextSyncBuff;

@end
