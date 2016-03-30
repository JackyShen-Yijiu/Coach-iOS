//
//  YBAppointMentUserCell.m
//  BlackCat
//
//  Created by bestseller on 15/10/3.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "YBAppointMentUserCell.h"

#import "AppointmentCoachTimeInfoModel.h"

@interface YBAppointMentUserCell ()
@end

@implementation YBAppointMentUserCell

- (UIImageView *)iconImageView
{
    if (_iconImageView==nil) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.cornerRadius = 22;
    }
    return _iconImageView;
}

- (UILabel *)nameLabel
{
    if (_nameLabel==nil) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:12.f];
        _nameLabel.textColor = [UIColor lightGrayColor];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.numberOfLines = 1;

    }
    return _nameLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.iconImageView];
        
        [self.contentView addSubview:self.nameLabel];
        
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@0);
            make.right.mas_equalTo(@0);
            make.width.mas_equalTo(48);
            make.height.mas_equalTo(48);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.iconImageView.mas_bottom).offset(8);
        }];
        
        
    }
    return self;
}


@end
