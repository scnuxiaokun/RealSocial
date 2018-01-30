//
//  RSViewModel.h
//  RealSocial
//
//  Created by kuncai on 2018/1/23.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSModel.h"
#import "RSNetWorkService.h"
#import "RSLiveData.h"
@interface RSViewModel : RSModel
//@property (nonatomic, strong) RSLiveData *liveData;
@property (nonatomic, retain, readonly) RACSubject *updateSignal;
@property (nonatomic, retain, readonly) RACSubject *completeSignal;
@property (nonatomic, retain, readonly) RACSubject *errorSignal;
-(void)loadData;
-(void)sendUpdateData:(id)data;
-(void)sendCompleteSignal;
-(void)sendErrorSignal:(NSError *)error;
@end
