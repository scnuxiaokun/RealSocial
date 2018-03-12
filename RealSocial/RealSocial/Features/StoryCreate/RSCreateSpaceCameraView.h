//
//  RSCreateSpaceCameraView.h
//  RealSocial
//
//  Created by kuncai on 2018/3/9.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "DBCameraView.h"

@interface RSCreateSpaceCameraView : DBCameraView
@property (nonatomic, strong) UIButton *takeButton;
- (void) triggerAction;
-(void)buildInterface;
@end
