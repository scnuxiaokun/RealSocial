//
//  RSDBService.m
//  RealSocial
//
//  Created by kuncai on 2018/2/1.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSDBService.h"

@implementation RSDBService
+(RSDBService *)shareInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[RSDBService alloc] init];
        
    });
    return sharedInstance;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(WCTDatabase *)db {
    if (_db) {
        return _db;
    }
    //获取沙盒根目录
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 文件路径
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"RSDBService.sqlite"];
    NSLog(@"path = %@",filePath);
    _db = [[WCTDatabase alloc]initWithPath:filePath];
    // 数据库加密
//    NSData *password = [@"MyPassword" dataUsingEncoding:NSASCIIStringEncoding];
//    [_db setCipherKey:password];
    //测试数据库是否能够打开
    if (![_db canOpen]) {
        NSLog(@"RSDBService.sqlite canOpen fail");
        //        // WCDB大量使用延迟初始化（Lazy initialization）的方式管理对象，因此SQLite连接会在第一次被访问时被打开。开发者不需要手动打开数据库。
        //        // 先判断表是不是已经存在
        //        if ([database isOpened]) {
        //
        //            if ([database isTableExists:tableName]) {
        //
        //                NSLog(@"表已经存在");
        //
        //            }else {
        //                [database createTableAndIndexesOfName:tableName withClass:Message.class];
        //            }
        //        }
        [_db createTableAndIndexesOfName:@"" withClass:[NSArray class]];
    }
    return _db;
}

+(WCTDatabase *)db {
   return [RSDBService shareInstance].db;
}
@end
