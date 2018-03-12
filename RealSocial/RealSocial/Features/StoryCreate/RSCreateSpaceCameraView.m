//
//  RSCreateSpaceCameraView.m
//  RealSocial
//
//  Created by kuncai on 2018/3/9.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSCreateSpaceCameraView.h"

@implementation RSCreateSpaceCameraView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)buildInterface {
    [self addSubview:self.takeButton];
    [self.takeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_bottom);
        make.centerX.equalTo(self);
    }];
}

-(UIButton *)takeButton {
    if (_takeButton) {
        return _takeButton;
    }
    _takeButton = [[UIButton alloc] init];
    [_takeButton setImage:[UIImage imageNamed:@"btn-camera"] forState:UIControlStateNormal];
    [_takeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(80);
    }];
    [_takeButton setBackgroundColor:[UIColor whiteColor]];
    _takeButton.layer.cornerRadius = 80/2;
    [_takeButton addTarget:self action:@selector(triggerAction:) forControlEvents:UIControlEventTouchUpInside];
    return _takeButton;
}

- (void) triggerAction:(UIButton *)button
{
    if ( [self.delegate respondsToSelector:@selector(cameraViewStartRecording)] )
        [self.delegate cameraViewStartRecording];
}
@end
