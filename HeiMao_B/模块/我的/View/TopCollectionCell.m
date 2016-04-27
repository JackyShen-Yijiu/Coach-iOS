//
//  TopCollectionCell.m
//  HeiMao_B
//
//  Created by ytzhang on 16/3/25.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "TopCollectionCell.h"

@interface TopCollectionCell ()



@end

@implementation TopCollectionCell
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
    [self addSubview:self.classTypeLabel];
    [self addSubview:self.contentLabel];
}
- (void)layoutSubviews{
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(44);
        make.centerY.mas_equalTo(self.mas_centerY);
        if (YBIphone6Plus) {
            make.width.mas_equalTo(18 * JZRatio_1_1_5);
            make.height.mas_equalTo(18 * JZRatio_1_1_5);
            
        }else {
            make.width.mas_equalTo(@18);
            make.height.mas_equalTo(@18);
        }
        
        
    }];
    [self.classTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imgView.mas_right).offset(14);
        make.right.mas_equalTo(self.mas_right).offset(0);
        
        if (YBIphone6Plus) {
            
            make.top.mas_equalTo(self.mas_top).offset(20 * JZRatio_1_5);

        }else {
            make.top.mas_equalTo(self.mas_top).offset(20);

        }
        
        
        make.height.mas_equalTo(@14);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.classTypeLabel.mas_left);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.top.mas_equalTo(self.classTypeLabel.mas_bottom).offset(14);
        make.height.mas_equalTo(@12);
    }];

}
- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] init];
        _imgView.backgroundColor = [UIColor clearColor];
    }
    return _imgView;
}
- (UILabel *)classTypeLabel{
    if (_classTypeLabel == nil) {
        _classTypeLabel = [[UILabel alloc] init];
        _classTypeLabel.text = @"授课班型";
        
        if (YBIphone6Plus) {
            
            _classTypeLabel.font = [UIFont systemFontOfSize:14 * JZRatio_1_1_5];
            
        }else {
            _classTypeLabel.font = [UIFont systemFontOfSize:14];
            
        }
        
        
        _classTypeLabel.textColor = JZ_FONTCOLOR_DRAK;
        _classTypeLabel.backgroundColor = [UIColor clearColor];
        
    }
    return _classTypeLabel;
}
- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.text = @"C1泉州办";
        
        if (YBIphone6Plus) {
 
            _contentLabel.font = [UIFont systemFontOfSize:12 * JZRatio_1_1_5];
 
        }else {
            _contentLabel.font = [UIFont systemFontOfSize:12];

        }
        
        
        _contentLabel.textColor = JZ_FONTCOLOR_LIGHT;
        _contentLabel.backgroundColor = [UIColor clearColor];
    }
    return _contentLabel;
}

@end
