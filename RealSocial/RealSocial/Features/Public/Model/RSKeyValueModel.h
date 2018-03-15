//
//  RSKeyValueModel.h
//  RealSocial
//
//  Created by kuncai on 2018/3/13.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSModel.h"

@interface RSKeyValueModel : RSModel
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) NSDate *expirDate;
//@property (nonatomic, strong) NSString *uid;
//@property (nonatomic, assign) BOOL isGlobal;

@end
