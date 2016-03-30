//
//  YBStudentDetailHeadView.m
//  studentDriving
//
//  Created by 大威 on 16/2/20.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBStudentDetailHeadView.h"
#import "YBStudentDetailsRootClass.h"

@interface YBStudentDetailHeadView ()

@property (nonatomic, strong) UIView *centerView;

@end

@implementation YBStudentDetailHeadView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor redColor];
        [self addSubview:self.bgImageView];
        [self addSubview:self.maskView];

        [self addSubview:self.centerView];

        [self addSubview:self.alphaView];

        CGFloat selfWidth = [UIScreen mainScreen].bounds.size.width;

        CGFloat bgImagesViewHeight = selfWidth * 0.4;

        _bgImageView.frame = CGRectMake(0, 0, selfWidth, bgImagesViewHeight);

        _maskView.frame = _bgImageView.frame;

        _alphaView.frame = _bgImageView.frame;

        _centerView.center = CGPointMake(CGRectGetMidX(_bgImageView.frame), CGRectGetMidY(_bgImageView.frame) + 18);
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

+ (CGFloat)defaultHeight {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    return screenWidth * 0.4;
}

- (void)refreshData:(YBStudentDetailsRootClass *)dmData {
   
    
}

- (UIView *)alphaView {
    if (!_alphaView) {
        _alphaView = [UIView new];
    }
    return _alphaView;
}

- (UIImageView *)maskView {
    if (!_maskView) {
        _maskView= [UIImageView new];
        _maskView.image = [UIImage imageNamed:@"coach_header_bg"];
    }
    return _maskView;
}

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [UIImageView new];
        _bgImageView.image = [[UIImage imageNamed:@"bg"] applyBlurWithRadius:10 tintColor:[UIColor clearColor] saturationDeltaFactor:1 maskImage:nil];
    }
    return _bgImageView;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        [_iconImageView.layer setMasksToBounds:YES];
        [_iconImageView.layer setCornerRadius:30];
        _iconImageView.image = [UIImage imageNamed:@"coach_man_default_icon"];
    }
    return _iconImageView;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.text = @"暂无教练名";
    }
    return _nameLabel;
}

- (UIView *)centerView {
    if (!_centerView) {
        _centerView = [UIView new];
        _centerView.frame = CGRectMake(0, 0, 94, 110);
        
        [_centerView addSubview:self.iconImageView];
        [_centerView addSubview:self.nameLabel];
        _iconImageView.frame = CGRectMake((94-60) / 2, 0, 60, 60);
        _nameLabel.frame = CGRectMake(0, 60, 94, 10 + 16 + 10);

    }
    return _centerView;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
