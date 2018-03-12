//
//  RSAddFriendsViewModel.h
//  RealSocial
//
//  Created by 蒋陈浩 on 2018/3/9.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSViewModel.h"

@interface RSAddFriendsViewModel : RSViewModel

+ (RACSignal *)createToAddFriends:(UIImage *)image isUploadImage:(BOOL)isUpdateImage;
@end
