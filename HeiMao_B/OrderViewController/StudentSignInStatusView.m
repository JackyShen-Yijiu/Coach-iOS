//
//  StudentSignInStatusView.m
//  HeiMao_B
//
//  Created by 大威 on 16/1/13.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "StudentSignInStatusView.h"
#import "MASonry.h"

#define kDefaultTintColor   RGB_Color(0x28, 0x79, 0xF3)

@implementation StudentSignInStatusView

- (instancetype)initWithFrame:(CGRect)frame
                    imageName:(NSString *)imageName
                      message:(NSString *)message {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backgroundImageView];
        [self addSubview:self.imageView];
        [self addSubview:self.messageLabel];
        [self addSubview:self.okButton];
        _imageView.image = [UIImage imageNamed:imageName];
        _messageLabel.text = message;
        [self configUI];
    }
    return self;
}

#pragma mark configUI
- (void)configUI {
    
    __weak typeof(self) ws = self;
    [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.bottom.with.right.mas_equalTo(0);
    }];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(100);
        make.centerX.mas_equalTo(ws.mas_centerX);
        make.top.mas_equalTo(64 + 120);
    }];
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.imageView.mas_bottom).offset(20);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    [_okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.imageView.mas_bottom).offset(120);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(44);
    }];
    
    _backgroundImageView.alpha = 1;
    _backgroundImageView.backgroundColor = [UIColor whiteColor];
    _okButton.backgroundColor = kDefaultTintColor;
}

#pragma mark - lazy load
- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [UIImageView new];
    }
    return _backgroundImageView;
}
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
    }
    return _imageView;
}
- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [UILabel new];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _messageLabel;
}
- (UIButton *)okButton {
    if (!_okButton) {
        _okButton = [UIButton new];
        [_okButton setTitle:@"返回" forState:UIControlStateNormal];
    }
    return _okButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
