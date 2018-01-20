//
//  RSLaunchService.m
//  RealSocial
//
//  Created by kuncai on 2018/1/20.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSLaunchService.h"
#import "RSNetWorkService.h"
#import "RSLoginService.h"
@implementation RSLaunchService
+(RSLaunchService *)shareInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[RSLaunchService alloc] init];
    });
    return sharedInstance;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        [[RSLoginService shareInstance].loginSignal subscribeNext:^(id  _Nullable x) {
            self.loginCompleteBlock();
        }];
    }
    return self;
}
-(void)start {
    self.startBlock();
    [[RSNetWorkService sendDebugRequest:[RSRequest new]] subscribeNext:^(id  _Nullable x) {
        
    } error:^(NSError * _Nullable error) {
        self.startErrorBlock();
    } completed:^{
        self.startCompleteBlock();
    }];
}
@end
