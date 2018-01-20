//
//  NSURL+Util.h
//  FortunePlat
//
//  Created by kuncai on 16/4/28.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (Util)
-(NSDictionary *)query2Dictionary;
-(NSURL *)addParam:(NSString *)param value:(NSString *)value;
-(NSURL *)removeParam:(NSString *)param;
@end
