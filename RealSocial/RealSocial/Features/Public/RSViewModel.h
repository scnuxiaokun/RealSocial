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
-(void)loadData;
-(void)loadDataFromLocal;
-(RACSignal *)loadDataFromServer;
@end
