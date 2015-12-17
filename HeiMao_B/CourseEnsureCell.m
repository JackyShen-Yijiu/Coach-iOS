//
//  CourseEnsureCell.m
//  HeiMao_B
//
//  Created by kequ on 15/10/29.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "CourseEnsureCell.h"

@interface CourseEnsureCell()
@property(nonatomic,strong)UILabel * titleLabel;
@end

@implementation CourseEnsureCell

+ (CGFloat)cellHeigthWithTitle:(BOOL)isShowTitle
{
    CGFloat heigth = 0;
    if (isShowTitle) {
        heigth += 20 + 14;
    }
    heigth += 15;
    heigth += 45;
    return heigth;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:14.f];
    self.titleLabel.textColor = RGB_Color(153, 153, 153);
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.titleLabel];
    
    self.ensurebutton = [[HMButton alloc] init];
    [self.ensurebutton setTitle:@"提交" forState:UIControlStateNormal];
    [self.ensurebutton setTitle:@"提交" forState:UIControlStateHighlighted];
    [self.ensurebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.ensurebutton.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [self.ensurebutton setNBackColor:RGB_Color(31, 124, 235)];
    [self.ensurebutton setHBackColor:RGB_Color(0x24, 0x6d, 0xd0)];
    [self.ensurebutton addTarget:self action:@selector(didClickEnsure:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.ensurebutton];
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.titleLabel.text.length) {
        self.titleLabel.frame = CGRectMake(15, 20, self.contentView.width - 30, 14);
        self.ensurebutton.frame = CGRectMake(15, self.titleLabel.bottom + 15.f, self.contentView.width - 30, 45);
    }else{
        self.ensurebutton.frame = CGRectMake(15, 15, self.contentView.width - 30, 45);
    }
}

- (void)didClickEnsure:(UIButton *)button
{
    if ([_delegate respondsToSelector:@selector(courseCellDidEnstureClick:)]) {
        [_delegate courseCellDidEnstureClick:self];
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
}

@end
