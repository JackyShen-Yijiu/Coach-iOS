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
    [self addSubview:self.badegLabel];

    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.badegLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-1);
        make.top.mas_equalTo(self).offset(1);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    
    
    if (YBIphone6Plus) {
        
        NSLog(@"_isNoShowLabel:%d",_isNoShowLabel);
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(30 * JZRatio_1_1_5);
            make.height.mas_equalTo(24 * JZRatio_1_1_5);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.mas_top).offset(20 * JZRatio_1_1_5);

//            if (_isNoShowLabel) {
//                make.centerY.mas_equalTo(self.mas_centerY);
//            }

        }];
        
        
    }else {
       
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(@30);
            make.height.mas_equalTo(@24);
            make.top.mas_equalTo(self.mas_top).offset(20);
            make.centerX.mas_equalTo(self.mas_centerX);
//            if (_isNoShowLabel) {
//                make.centerY.mas_equalTo(self.mas_centerY);
//            }
  
        }];
        
    }
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgView.mas_bottom).offset(12);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(self.frame.size.width);
        make.height.mas_equalTo(@14);
    }];
    
    self.badegLabel.layer.masksToBounds = YES;
    self.badegLabel.layer.cornerRadius = 15/2;
}
- (UILabel *)badegLabel
{
    if (_badegLabel==nil) {
        
        _badegLabel = [[UILabel alloc] init];
        _badegLabel.text = @"1";
        _badegLabel.textColor = [UIColor whiteColor];
        _badegLabel.backgroundColor = [UIColor redColor];
        _badegLabel.textAlignment = NSTextAlignmentCenter;
        _badegLabel.font = [UIFont systemFontOfSize:8];
        
        if (YBIphone6Plus) {
            _badegLabel.font = [UIFont systemFontOfSize:8 * JZRatio_1_1_5];
            
        }else {
            _badegLabel.font = [UIFont systemFontOfSize:8];
            
        }
        
//        _badegLabel.frame = CGRectMake(self.width-16, 1, 15, 15);
        
    }
    return _badegLabel;
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
        
        if (YBIphone6Plus) {
            _titleLabel.font = [UIFont systemFontOfSize:12 * JZRatio_1_1_5];

        }else {
            _titleLabel.font = [UIFont systemFontOfSize:12];

        }
        
        _titleLabel.textColor = JZ_FONTCOLOR_DRAK;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _titleLabel;
}

@end
