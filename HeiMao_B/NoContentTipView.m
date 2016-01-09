//
//  NoContentTipView.m
//  HeiMao_B
//
//  Created by kequ on 15/12/19.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "NoContentTipView.h"

@interface NoContentTipView()
@property(nonatomic,strong)UILabel * contentLabel;
@property(nonatomic,strong)UIImageView * imageIcon;
@end

@implementation NoContentTipView

- (instancetype)initWithContetntTip:(NSString *)tip
{
    if (self = [super init]) {
        self.size = CGSizeMake(100, 75);
        [self setUserInteractionEnabled:NO];
        self.contentLabel.text = tip;
    }
    return self;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = RGB_Color(0x9c, 0x9c, 0x9c);
        _contentLabel.font = [UIFont systemFontOfSize:14.f];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (UIImageView *)imageIcon
{
    if (!_imageIcon) {
        _imageIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tip_no_content"]];
        [self addSubview:_imageIcon];
    }
    return _imageIcon;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageIcon.frame = CGRectMake(0, 0, 45, 45);
    self.imageIcon.centerX = self.width/2.f;
    [self.contentLabel sizeToFit];
    self.contentLabel.frame = CGRectMake(0, self.imageIcon.bottom + 15, self.width, 15);
    
}
@end