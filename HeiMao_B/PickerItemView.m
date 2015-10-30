//
//  PickerItemView.m
//  HeiMao_B
//
//  Created by kequ on 15/10/28.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "PickerItemView.h"


@interface PickerItemView()
@property(nonatomic,strong)UIButton * seletedButton;
@property(nonatomic,strong)UILabel * contentLabel;
@end

@implementation PickerItemModel
@end

@implementation PickerItemView


- (void)updateConstraints
{
    [super updateConstraints];
    [self.seletedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.left.equalTo(self).offset(0);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.seletedButton.mas_right).offset(15.f);
        make.right.equalTo(self).offset(0);
    }];
}

#pragma mark - 
- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:14.f];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.textColor = RGB_Color(0x33, 0x33, 0x33);
        [self addSubview:_contentLabel];
    }
    return _contentLabel;
}

#pragma mark - Button
- (UIButton *)seletedButton
{
    if (!_seletedButton) {
        _seletedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_seletedButton setTitle:@"S" forState:UIControlStateNormal];
        _seletedButton.backgroundColor = [UIColor redColor];
        [_seletedButton setTitle:@"U" forState:UIControlStateSelected];
        [_seletedButton addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_seletedButton];
    }
    return _seletedButton;
}

#pragma mark Data
- (void)setModel:(PickerItemModel *)model
{
    _model = model;
    [self.seletedButton setSelected:_model.isSeleted];
    self.contentLabel.text = _model.title;
}

- (void)buttonDidClick:(UIButton *)button
{
    button.selected = !button.selected;
    [self setSeleted:button.selected];
}

- (void)setSeleted:(BOOL)seleted
{
    self.model.seleted = seleted;
    if ([_delegate respondsToSelector:@selector(pickerItemDidValueChange:)]) {
        [_delegate pickerItemDidValueChange:self];
    }
}


@end