//
//  SYBTableDataResourse.m
//  SybPlatform
//
//  Created by kuncai on 15/9/15.
//  Copyright (c) 2015年 Tencent. All rights reserved.
//

#import "RCTableViewDataResourse.h"

@implementation RCTableViewDataResourse

-(instancetype)init {
    self = [super init];
    if (self) {
        self.rowCount = 0;
        self.cellClasses = @[];
        self.cellViewModels = @[];
        [self setDidSelectedCellBlock:^(UITableView *a,  NSIndexPath*b) {}];
    }
    return self;
}

-(Class)defaultCellClass {
    if (self.cellClasses.count > 0) {
        return [self.cellClasses firstObject];
    }
    return nil;
}

-(id)defaultCellViewModel {
    if (self.cellViewModels.count > 0) {
        return [self.cellViewModels firstObject];
    }
    return nil;
}

-(void)setCellClasses:(NSArray *)array {
    if (array.count > 0) {
        NSMutableArray *tmp = [[NSMutableArray alloc] initWithCapacity:array.count];
        for (NSString *className in array) {
            [tmp addObject:NSClassFromString(className)];
        }
        _cellClasses = [tmp copy];
    }
}
@end
