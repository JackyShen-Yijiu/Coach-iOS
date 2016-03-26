//
//  MyHeaderView.m
//  HeiMao_B
//
//  Created by ytzhang on 16/3/25.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "MyHeaderView.h"

@interface MyHeaderView ()

@end

@implementation MyHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.topImgView];
    [self.bgView addSubview:self.bottomImgView];
    [self.bgView addSubview:self.nameLable];
    [self.bgView addSubview:self.iconView];
    [self.bgView addSubview:self.schoolLabel];
    [self.bgView addSubview:self.yLabel];
    [self.bgView addSubview:self.lineView];
}
- (void)layoutSubviews{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(0);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.bottom.mas_equalTo(self.mas_bottom).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
    }];
    [self.topImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(0);
        make.left.mas_equalTo(self.bgView.mas_left).offset(0);
        make.right.mas_equalTo(self.bgView.mas_right).offset(0);
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(0);
//        make.height.mas_equalTo(@196);
        
    }];
    [self.bottomImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(0);
        make.left.mas_equalTo(self.bgView.mas_left).offset(0);
        make.right.mas_equalTo(self.bgView.mas_right).offset(0);
        make.height.mas_equalTo(@115);
        
    }];
    [self.yLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-16);
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
        make.height.mas_equalTo(@12);
        make.width.mas_equalTo(@200);
        
    }];
    [self.schoolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.yLabel.mas_top).offset(-16);
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
        make.height.mas_equalTo(@12);
        make.width.mas_equalTo(@100);
        
    }];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.schoolLabel.mas_top).offset(-16);
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
        make.height.mas_equalTo(@68);
        make.width.mas_equalTo(@68);
        
    }];

    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.iconView.mas_top).offset(-25);
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
        make.height.mas_equalTo(@14);
         make.width.mas_equalTo(@80);
        
    }];
                [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(0);
        make.left.mas_equalTo(self.bgView.mas_left).offset(0);
        make.right.mas_equalTo(self.bgView.mas_right).offset(0);
        make.width.mas_equalTo(@0.5);
        
    }];



    

}
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
//        _bgView.backgroundColor = [UIColor orangeColor];
    }
    return _bgView;
}
- (UIImageView *)topImgView{
    if (_topImgView == nil) {
        _topImgView = [[UIImageView alloc] init];
        _topImgView.image = [UIImage imageNamed:@"mine_background_My.jpg"];
        
    }
    return _topImgView;
}
- (UIImageView *)bottomImgView{
    if (_bottomImgView == nil) {
        _bottomImgView = [[UIImageView alloc] init];
        _bottomImgView.image = [UIImage imageNamed:@"mine_screen"];
        
    }
    return _bottomImgView;
}
- (UILabel *)nameLable{
    if (_nameLable == nil) {
        _nameLable = [[UILabel alloc] init];
        _nameLable.text = @"王教练";
        _nameLable.font = [UIFont systemFontOfSize:14];
        _nameLable.textColor = [UIColor whiteColor];
        _nameLable.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLable;
}
- (UIImageView *)iconView{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        _iconView.backgroundColor = [UIColor cyanColor];
        _iconView.layer.masksToBounds = YES;
        _iconView.layer.cornerRadius = 34;
        _iconView.image = [UIImage imageNamed:@""];
        
    }
    return _iconView;
}
- (UILabel *)schoolLabel{
    if (_schoolLabel == nil) {
        _schoolLabel = [[UILabel alloc] init];
        _schoolLabel.text = @"北京只有驾校";
        _schoolLabel.font = [UIFont systemFontOfSize:12];
        _schoolLabel.textColor = JZ_FONTCOLOR_DRAK;
        _schoolLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _schoolLabel;
}
- (UILabel *)yLabel{
    if (_yLabel == nil) {
        _yLabel = [[UILabel alloc] init];
        _yLabel.text = @"我的Y码:JAOIKKDIKDK";
        _yLabel.font = [UIFont systemFontOfSize:12];
        _yLabel.textColor = JZ_FONTCOLOR_LIGHT;
        _yLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _yLabel;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = HM_LINE_COLOR;
        
    }
    return _lineView;
}
@end
