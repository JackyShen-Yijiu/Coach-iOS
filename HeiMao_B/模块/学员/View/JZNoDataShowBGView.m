//
//  JZNoDataShowBGView.m
//  HeiMao_B
//
//  Created by ytzhang on 16/4/7.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZNoDataShowBGView.h"

@interface JZNoDataShowBGView ()

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation JZNoDataShowBGView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.imgView];
    [self.imgView addSubview:self.titleLabel];
    
}
- (void)layoutSubviews{
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(@120);
        make.width.mas_equalTo(@84);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.imgView.mas_centerX);
        make.height.mas_equalTo(@14);
        make.width.mas_equalTo(@100);
        make.bottom.mas_equalTo(self.imgView.mas_bottom).offset(-15);
    }];
}
- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] init];
        _imgView.image = [UIImage imageNamed:@"people_null"];
        _imgView.backgroundColor = [UIColor clearColor];
        
        
    }
    return _imgView;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"暂无数据";
        _titleLabel.textColor = JZ_FONTCOLOR_DRAK;
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
@end
