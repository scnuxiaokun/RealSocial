//
//  SYBTableDataResourse.h
//  SybPlatform
//
//  Created by kuncai on 15/9/15.
//  Copyright (c) 2015年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCTableViewDataResourse : NSObject
@property (nonatomic, assign) NSInteger rowCount;
@property (nonatomic, retain) NSArray *cellClasses;
@property (nonatomic, retain) NSArray *cellViewModels;
@property (nonatomic, assign) Class defaultCellClass;
@property (nonatomic, retain) id defaultCellViewModel;
@property (nonatomic, retain) NSString *groupTitle;
@property (copy) void(^didSelectedCellBlock)(UITableView *tableView, NSIndexPath *indexPath);
@end
