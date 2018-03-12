//
//  RSReceiverAvatarStackView.h
//  RealSocial
//
//  Created by kuncai on 2018/3/7.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "RSReceiverListViewModel.h"
#import "RSAvatarImageView.h"

@interface RSReceiverAvatarStackView : UIView
-(void)addReceiver:(NSString *)url;
-(void)removeReceiver:(NSString *)url;
-(void)removeAllReceiver;
@end
