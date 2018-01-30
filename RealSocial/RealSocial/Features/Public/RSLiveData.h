//
//  RSLiveData.h
//  RealSocial
//
//  Created by kuncai on 2018/1/30.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSModel.h"
@interface RSLiveData : RSModel
@property (nonatomic, strong) RACSubject *updateSignal;
-(void)setData:(id)data;
@end
