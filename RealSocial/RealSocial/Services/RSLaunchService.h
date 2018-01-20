//
//  RSLaunchService.h
//  RealSocial
//
//  Created by kuncai on 2018/1/20.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^NULLBlock)();
@interface RSLaunchService : NSObject
@property(nonatomic, copy) NULLBlock startBlock;
@property(nonatomic, copy) NULLBlock startCompleteBlock;
@property(nonatomic, copy) NULLBlock startErrorBlock;
@property(nonatomic, copy) NULLBlock loginCompleteBlock;
+(RSLaunchService *)shareInstance;
-(void)start;
@end
