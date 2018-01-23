//
//  RSViewModel.h
//  RealSocial
//
//  Created by kuncai on 2018/1/23.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSModel.h"
#import "RSNetWorkService.h"
@interface RSViewModel : RSModel
@property (nonatomic, retain, readonly) RACSubject *updateSignal;
@property (nonatomic, retain, readonly) RACSubject *completeSignal;
@property (nonatomic, retain, readonly) RACSubject *errorSignal;
-(void)loadData;
-(void)sendUpdateSignal;
-(void)sendCompleteSignal;
-(void)sendErrorSignal:(NSError *)error;
@end
