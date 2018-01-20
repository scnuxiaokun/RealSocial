//
//  NSURL+Util.m
//  FortunePlat
//
//  Created by kuncai on 16/4/28.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import "NSURL+Util.h"
static NSString *const kQuerySeparator      = @"&";
static NSString *const kQueryDivider        = @"=";
static NSString *const kQueryBegin          = @"?";
static NSString *const kFragmentBegin       = @"#";
@implementation NSURL (Util)
-(NSDictionary *)query2Dictionary {
    NSString *query = self.query;
    NSMutableDictionary *mute = @{}.mutableCopy;
    
    for (NSString *queryItem in [query componentsSeparatedByString:kQuerySeparator]) {
        NSArray *components = [queryItem componentsSeparatedByString:kQueryDivider];
        if (components.count == 0) {
            continue;
        }
        NSString *key = [components[0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        id value = nil;
        if (components.count == 1) {
            // key with no value
            value = [NSNull null];
        }
        if (components.count == 2) {
            value = [components[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            // cover case where there is a separator, but no actual value
            value = [value length] ? value : [NSNull null];
        }
        if (components.count > 2) {
            // invalid - ignore this pair. is this best, though?
            continue;
        }
        mute[key] = value ?: [NSNull null];
    }
    return mute.count ? mute.copy : nil;
}

-(NSURL *)addParam:(NSString *)param value:(NSString *)value {
    NSDictionary *query = [self query2Dictionary];
    if ([query containsObjectForKey:param]) {
        return self;
    }
    NSString *url = [NSString stringWithFormat:@"%@://", self.scheme];
    if (self.host) {
        url = [url stringByAppendingString:self.host];
    }
    if (self.path) {
        url = [url stringByAppendingString:self.path];
    }
    if (self.query > 0) {
        NSString *queryString = [self.query stringByAppendingString:[NSString stringWithFormat:@"&%@=%@", param, value]];
        url = [url stringByAppendingString:[NSString stringWithFormat:@"?%@", queryString]];
    } else {
        url = [url stringByAppendingString:[NSString stringWithFormat:@"?%@=%@", param, value]];
    }
    if (self.fragment) {
        url = [url stringByAppendingString:[NSString stringWithFormat:@"#%@", self.fragment]];
    }
//    url = [FPUtils urlEncode:url];
    return [NSURL URLWithString:url];
}
-(NSURL *)removeParam:(NSString *)param {
    NSDictionary *query = [self query2Dictionary];
    if (![query containsObjectForKey:param]) {
        return self;
    }
    NSString *paramString;
    NSString *value = [query objectForKey:param];
    NSString *url = self.absoluteString;
    if ([query count] > 1) {
        paramString = [NSString stringWithFormat:@"&%@=%@", param, value];
        url = [url stringByReplacingOccurrencesOfString:paramString withString:@""];
        paramString = [NSString stringWithFormat:@"%@=%@&", param, value];
        url = [url stringByReplacingOccurrencesOfString:paramString withString:@""];
    } else {
        paramString = [NSString stringWithFormat:@"?%@=%@", param, value];
        url = [url stringByReplacingOccurrencesOfString:paramString withString:@""];
    }
    
//    url = [FPUtils urlEncode:url];
    return [NSURL URLWithString:url];
}
@end
