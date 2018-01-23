//
//  RSViewModel.m
//  RealSocial
//
//  Created by kuncai on 2018/1/23.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSViewModel.h"

@implementation RSViewModel

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

//-(RACSignal *)loadData {
//    RACSignal *localSignal = [self loadDataFromLocal];
//    RACSignal *serverSignal =  [self loadDataFromServer];
//    return [RACSignal merge:@[localSignal, serverSignal]];
//}
@end
