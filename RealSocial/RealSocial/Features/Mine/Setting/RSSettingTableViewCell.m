//
//  RSSettingTableViewCell.m
//  RealSocial
//
//  Created by 蒋陈浩 on 2018/3/12.
//  Copyright © 2018年 scnukuncai. All rights reserved.
//

#import "RSSettingTableViewCell.h"

@implementation RSSettingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.textLabel setTextColor:[UIColor main2]];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.next];
        [self addSubview:self.line];
        [self addSubview:self.describe];
        [self.next mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(self.mas_right).mas_offset(-22);
            make.height.mas_equalTo(9);
            make.width.mas_equalTo(7);
        }];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-1);
            make.left.mas_equalTo(self.mas_left).mas_offset(12);
            make.right.mas_equalTo(self.mas_right).mas_offset(-12);
            make.height.mas_equalTo(1);
        }];
        [self.describe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(self.next.mas_right).mas_offset(-20);
        }];
    }
    return self;
}


-(UIImageView *)next{
    if (!_next) {
        _next = [[UIImageView alloc] init];
        [_next setImage:[UIImage imageNamed:@"btn-common-disclosure"]];
    }
    return _next;
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = RGB(237, 237, 237);
    }
    return _line;
}

- (UILabel *)describe{
    if (!_describe) {
        _describe = [[UILabel alloc] init];
        _describe.text=@"";
        [_describe setTextColor:RGBA(9, 10, 70,.4f)];
        _describe.font = [UIFont systemFontOfSize:14];
    }
    return _describe;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
