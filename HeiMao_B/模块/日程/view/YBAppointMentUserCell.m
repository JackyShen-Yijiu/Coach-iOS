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

@property (nonatomic,strong) UILabel *stateLabel;
@property (nonatomic,strong) UIView *bgView;

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

- (UIImageView *)stateImageView
{
    if (_stateImageView==nil) {
        _stateImageView = [[UIImageView alloc] init];
    }
    return _stateImageView;
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

- (UIView *)alphaView
{
    if (_alphaView==nil) {
        _alphaView = [[UIView alloc] init];
        _alphaView.backgroundColor = [UIColor blackColor];
        _alphaView.alpha = 0.3;
        _alphaView.layer.masksToBounds = YES;
        _alphaView.layer.cornerRadius = 22;
    }
    return _alphaView;
}

- (UIView *)bgView
{
    if (_bgView==nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor clearColor];
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = 22;
    }
    return _bgView;
}

- (UILabel *)stateLabel
{
    if (_stateLabel == nil) {
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.text = @"漏课";
        _stateLabel.textColor = [UIColor whiteColor];
        _stateLabel.font = [UIFont systemFontOfSize:13];
        _stateLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _stateLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.iconImageView];
        
        [self.contentView addSubview:self.nameLabel];
        
        [self.contentView addSubview:self.stateImageView];
        
        [self.iconImageView addSubview:self.alphaView];
        [self.alphaView addSubview:self.bgView];
        [self.alphaView addSubview:self.stateLabel];
        
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
        
        [self.stateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(14);
            make.height.mas_equalTo(14);
            make.right.mas_equalTo(self.contentView.mas_right);
            make.top.mas_equalTo(self.contentView.mas_top).offset(48-14);
        }];
        
        [self.alphaView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@0);
            make.right.mas_equalTo(@0);
            make.width.mas_equalTo(48);
            make.height.mas_equalTo(48);
        }];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@0);
            make.right.mas_equalTo(@0);
            make.width.mas_equalTo(48);
            make.height.mas_equalTo(48);
        }];
        [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.iconImageView.mas_centerY);
        }];
        
    }
    return self;
}


@end
