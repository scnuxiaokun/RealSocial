//
//  RSReceiverTitleView.m
//  RealSocial
//
//  Created by kuncai on 2018/2/10.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSReceiverTitleView.h"

@implementation RSReceiverTitleView

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
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.centerY.equalTo(self);
        }];
    }
    return self;
}

-(UILabel *)label {
    if (_label) {
        return _label;
    }
    _label = [[UILabel alloc] init];
    _label.font = [UIFont systemFontOfSize:18];
    _label.textColor = [UIColor blackColor];
    return _label;
}
@end
