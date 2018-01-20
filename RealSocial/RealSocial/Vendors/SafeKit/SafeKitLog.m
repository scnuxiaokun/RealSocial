//
//  SafeKitLog.m
//  DurexKitExample
//
//  Created by zhangyu on 14-3-14.
//  Copyright (c) 2014年 zhangyu. All rights reserved.
//

#import "SafeKitLog.h"
#import "NSException+SafeKit.h"

SafeKitLog *SafeKitLogInstance;

@interface SafeKitConsolePrinter : SafeKitPrinter

@end

@implementation SafeKitLog
@synthesize printer = _printer;

- (id)init
{
    self = [super init];
    if (self) {
        self.printer = [[SafeKitConsolePrinter alloc]init];
    }
    return self;
}

- (id)initWithPrinter:(SafeKitPrinter *)printer
{
    self = [super init];
    if (self) {
        self.printer = printer;
    }
    return self;
}

+(SafeKitLog *)shareInstance{
    if (!SafeKitLogInstance) {
        SafeKitLogInstance = [[SafeKitLog alloc]init];
    }
    return SafeKitLogInstance;
}

-(void)log:(NSString *)aString{
    [self.printer print:aString];
}

-(void)logInfo:(NSString *)aString{
//    if ((getSafeKitLogType() & SafeKitLogTypeInfo) != 0) {
        [self log:aString];
//    }
}

-(void)logWarning:(NSString *)aString{
//    if ((getSafeKitLogType() & SafeKitLogTypeWarning) != 0) {
        [self log:aString];
        
        //show stack trace
        @try {
            NSException *e = [NSException exceptionWithName:@"SafeKit" reason:@"WarningStackTrace" userInfo:nil];
            @throw e;
        }
        @catch (NSException *exception) {
            [exception printStackTrace];
//            assert(0);
        }
//    }
}

-(void)logError:(NSString *)aString{
//    if ((getSafeKitLogType() & SafeKitLogTypeError) != 0) {
        [self log:aString];
        
        //show stack trace
        @try {
            NSException *e = [NSException exceptionWithName:@"SafeKit" reason:@"ErrorStackTrace" userInfo:nil];
            @throw e;
        }
        @catch (NSException *exception) {
            [exception printStackTrace];
        }
//    }
}
@end

@implementation SafeKitPrinter
-(void)print:(NSString *)aString{

}
@end


@implementation SafeKitConsolePrinter
-(void)print:(NSString *)aString{
    if (!aString) {
        return;
    }
#if RELEASE
    //发送数据
//    [[SYBFeedBackManager sharedManager] sendFeedBackWithTitle:@"SafeKit Exception Report"
//                                                   andContent:aString];
//    SYBFeedBackRequest* feedBackRequest = [[SYBFeedBackRequest alloc] initWithTitle:@"SafeKit Exception Report" andContent:aString];
//    [feedBackRequest sendWithDelegate:nil];
//    NSString *url = @"http://spt_api.cm.com/cgi-bin/addpost_api?qq=&title=&text=&fid=&yk=&ip=&info=";
////        NSString *url = @"http://10.137.133.176:8080/cgi-bin/addpost_api?qq=&title=&text=&fid=&yk=&ip=&info=";
//    ASIFormDataRequest * request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
//    [request setRequestMethod:@"GET"];
//    [request setPostValue:@"1038" forKey:@"fid"];
//    [request setPostValue:@"1" forKey:@"yk"];
//    [request setPostValue:@"SafeKit Exception Report" forKey:@"title"];
//    [request setPostValue:aString forKey:@"text"];
//    
//    [request setCompletionBlock:^{
//        SYB_LOG(request.responseString);
//    }];
//    [request setFailedBlock:^{
//        
//    }];
//    [request startAsynchronous];
#endif
    NSLog(@"%@",aString);
    assert(0);
}
@end
