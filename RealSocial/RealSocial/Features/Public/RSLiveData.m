//
//  RSLiveData.m
//  RealSocial
//
//  Created by kuncai on 2018/1/30.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSLiveData.h"

@implementation RSLiveData
-(instancetype)init {
    self = [super init];
    if (self) {
        _updateSignal = [RACReplaySubject subject];
    }
    return self;
}
    
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        _updateSignal = [RACReplaySubject subject];
    }
    return self;
}

-(void)setData:(id)data {
    [_updateSignal sendNext:data];
}
@end
