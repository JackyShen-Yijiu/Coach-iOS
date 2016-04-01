//
//  BottomCollectionCell.m
//  HeiMao_B
//
//  Created by ytzhang on 16/3/25.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "BottomCollectionCell.h"

@interface BottomCollectionCell ()




@end

@implementation BottomCollectionCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.imgView];
    [self addSubview:self.titleLabel];
    
}
- (void)layoutSubviews{
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (_isNoShowLabel) {
            make.centerY.mas_equalTo(self.mas_centerY);
        } else {
            make.top.mas_equalTo(self.mas_top).offset(20);
        }
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(@30);
        make.height.mas_equalTo(@24);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgView.mas_bottom).offset(12);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(self.frame.size.width);
        make.height.mas_equalTo(@14);
    }];
    
}

- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] init];
        _imgView.backgroundColor = [UIColor clearColor];
    }
    return _imgView;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"休假";
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = JZ_FONTCOLOR_DRAK;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _titleLabel;
}

@end
