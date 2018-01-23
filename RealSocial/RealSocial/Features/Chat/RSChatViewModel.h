//
//  RSChatViewModel.h
//  RealSocial
//
//  Created by kuncai on 2018/1/24.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSViewModel.h"
@interface RSChatItemViewModel : RSViewModel
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *iconUrl;
@property (nonatomic, strong) NSString *text;
@end
@interface RSChatViewModel : RSViewModel
@property (nonatomic, strong) NSArray *listData;
@end
