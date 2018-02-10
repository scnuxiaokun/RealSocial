//
//  RSAvatarImageView.m
//  RealSocial
//
//  Created by kuncai on 2018/2/10.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSAvatarImageView.h"
#import <UIImageView+WebCache.h>

@implementation RSAvatarImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)setUrl:(NSString *)url {
    _url = url;
    [self sd_setImageWithURL:[NSURL URLWithString:url]];
}

-(void)setType:(RSAvatarImageViewType)type {
    _type = type;
    CGFloat width=0;
    
    switch (type) {
        case RSAvatarImageViewType48:
            width=48;
            break;
        case RSAvatarImageViewType80:
            width=80;
            break;
            
        default:
            break;
    }
    self.width = self.height = width;
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(width);
    }];
    self.layer.cornerRadius = width/2;
    self.layer.masksToBounds = YES;
}
@end
