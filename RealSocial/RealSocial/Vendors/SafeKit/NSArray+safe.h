//
//  NSArray+NoCrash.h
//  SybPlatform
//
//  Created by kuncai on 15-2-6.
//  Copyright (c) 2015年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (safe)
-(id)safeObjectAtIndex:(NSInteger)index;
@end
