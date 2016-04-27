//
//  MyHeaderView.m
//  HeiMao_B
//
//  Created by ytzhang on 16/3/25.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "MyHeaderView.h"

@interface MyHeaderView ()

@property (nonatomic, strong) NSString *yNum;

@property (nonatomic, strong) NSString *schoolName;


@end

@implementation MyHeaderView
- (id)initWithFrame:(CGRect)frame
   withUserPortrait:(NSString *)image
   withUserPhoneNum:(NSString *)schoolName
           withYNum:(NSString *)yNum{
    
    if (self = [super initWithFrame:frame]) {
        
        [self initUI];
        if (image) {
            [_iconView sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"littleImage.png"]];
        }
        _schoolLabel.text = schoolName;
        if (yNum == nil || [yNum isEqualToString:@"0"] || [yNum isEqualToString:@""]) {
            _yLabel.text = [NSString stringWithFormat:@"y码:暂无"];
        }else{
            _yLabel.text  = [NSString stringWithFormat:@"y码:%@",yNum];

        }

        
        
    }
    return self;
}
- (void)initUI{
    
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.topImgView];
    [self.bgView addSubview:self.bottomImgView];
//    [self.bgView addSubview:self.nameLable];
    [self.bgView addSubview:self.iconView];
    [self.bgView addSubview:self.schoolLabel];
    [self.bgView addSubview:self.yLabel];
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
    }];
    [self.bottomImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(0);
        make.left.mas_equalTo(self.bgView.mas_left).offset(0);
        make.right.mas_equalTo(self.bgView.mas_right).offset(0);
        make.height.mas_equalTo(115);
    }];
    [self.yLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-16);
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
        if (YBIphone6Plus) {
            
            make.height.mas_equalTo(12 * JZRatio_1_5);
            make.width.mas_equalTo(200);
        }else {
            
            make.height.mas_equalTo(12 * JZRatio_1_5);
            make.width.mas_equalTo(200);
        }
    }];
    [self.schoolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.yLabel.mas_top).offset(-16);
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
        
        if (YBIphone6Plus) {
            
            make.height.mas_equalTo(12 * JZRatio_1_5);
//            make.width.mas_equalTo(100);
        }else {
            make.height.mas_equalTo(12);
            make.width.mas_equalTo(100);
        }
    }];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.schoolLabel.mas_top).offset(-16);
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
        
        if (YBIphone6Plus) {
            make.height.mas_equalTo(68 * JZRatio_1_1_5);
            make.width.mas_equalTo(68 * JZRatio_1_1_5);
   
        }else {
            make.height.mas_equalTo(68);
            make.width.mas_equalTo(68);

        }
        
    }];

}
// 头像设置
- (void)signatureSetUp{
    if (_signtureImageGas) {
        _signtureImageGas();
    }
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
        _topImgView.contentMode = UIViewContentModeScaleAspectFill;
        
    }
    return _topImgView;
}
- (UIImageView *)bottomImgView{
    if (_bottomImgView == nil) {
        _bottomImgView = [[UIImageView alloc] init];
        _bottomImgView.image = [UIImage imageNamed:@"mine_screen"];
        _bottomImgView.contentMode = UIViewContentModeScaleAspectFill;
        
    }
    return _bottomImgView;
}
- (UIImageView *)iconView{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        _iconView.backgroundColor = [UIColor cyanColor];
        _iconView.layer.masksToBounds = YES;
        
        if (YBIphone6Plus) {
        _iconView.layer.cornerRadius = 39.1;
        }else {
           
        _iconView.layer.cornerRadius = 34;

        }
        
        _iconView.image = [UIImage imageNamed:@"littleImage.png"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(signatureSetUp)];
        [_iconView addGestureRecognizer:tap];
        _iconView.userInteractionEnabled = YES;
    }
    return _iconView;
}
- (UILabel *)schoolLabel{
    if (_schoolLabel == nil) {
        _schoolLabel = [[UILabel alloc] init];
        _schoolLabel.text = @"北京只有驾校";
        
        if (YBIphone6Plus) {
            
            _schoolLabel.font = [UIFont systemFontOfSize:14 * JZRatio_1_1_5];
            
        }else {
           
            _schoolLabel.font = [UIFont systemFontOfSize:12];
            
        }
        
        _schoolLabel.textColor = JZ_FONTCOLOR_DRAK;
        _schoolLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _schoolLabel;
}
- (UILabel *)yLabel{
    if (_yLabel == nil) {
        _yLabel = [[UILabel alloc] init];
        _yLabel.text = @"我的Y码:JAOIKKDIKDK";
        
        if (YBIphone6Plus) {
            
            _yLabel.font = [UIFont systemFontOfSize:14 * JZRatio_1_1_5];

        }else {
            
            _yLabel.font = [UIFont systemFontOfSize:12];

        }
        
        _yLabel.textColor = JZ_FONTCOLOR_LIGHT;
        _yLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _yLabel;
}
// 头像手势
- (void)infoMessage{
    
}
@end
