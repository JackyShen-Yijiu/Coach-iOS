//
//  StudentHomeRecomendCell.m
//  HeiMao_B
//
//  Created by kequ on 15/10/28.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "StudentHomeRecomendCell.h"
#import "PortraitView.h"

@interface StudentHomeRecomendCell()
@property(nonatomic,strong)PortraitView * porView;
@property(nonatomic,strong)UILabel * userName;
@property(nonatomic,strong)UILabel * recomendData;
@property(nonatomic,strong)UILabel * recomendContent;
@property(nonatomic,strong)UIView * lineView;
@end

@implementation StudentHomeRecomendCell

+ (CGFloat)cellHigthWithModel:(HMRecomendModel *)model
{
    CGFloat heigth = 0;
    heigth += 13.f;
    heigth += 24.f;
    if (model.recomedContent) {
        heigth += 10.f;
        CGRect bounds = [model.recomedContent boundingRectWithSize:
                       CGSizeMake([[UIScreen mainScreen] bounds].size.width - 30, 10000) options:
                       NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]} context:nil];
        
        heigth += bounds.size.height;

    }
    heigth += 15.f;
    return heigth;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.porView = [[PortraitView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    self.porView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.porView];
    
    self.userName = [self getOnePropertyLabel];
    self.userName.font = [UIFont boldSystemFontOfSize:14.f];
    [self.contentView addSubview:self.userName];
    
    self.recomendData = [self getOnePropertyLabel];
    [self.contentView addSubview:self.recomendData];
    
    self.recomendContent = [self getOnePropertyLabel];
    self.recomendContent.numberOfLines = 0;
    self.recomendContent.lineBreakMode = NSLineBreakByCharWrapping;
    [self.contentView addSubview:self.recomendContent];
    
    
    self.lineView = [self getOnelineView];
    [self.contentView addSubview:self.lineView];
    [self updateConstraints];
}

#pragma mark Layout
- (void)updateConstraints
{
    [self.porView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(13.f);
        make.left.equalTo(self.contentView).offset(15.f);
        make.height.equalTo(@(24.f));
        make.width.equalTo(@(24.f));
    }];
    
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.porView.mas_right).offset(10.f);
        make.centerY.equalTo(self.porView);
        make.right.equalTo(self.recomendData.mas_left).offset(-10);
    }];
    
    [self.recomendData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(self.porView);
    }];
    
    [self.recomendContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.porView.mas_bottom).offset(10.f);
        make.bottom.equalTo(self.contentView).offset(-13.f);
        make.left.equalTo(self.userName);
        make.right.equalTo(self.contentView).offset(-15);
        
    }];

    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userName);
        make.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_bottom).offset(-HM_LINE_HEIGHT);
        make.height.equalTo(@(HM_LINE_HEIGHT));
    }];
    
    [super updateConstraints];
}

#pragma mark - Data
- (void)setModel:(HMRecomendModel *)model
{
    if (_model == model) {
        return;
    }
    _model = model;
    UIImage * defaultImage = [UIImage imageNamed:@"temp"];
    if(_model.portrait.originalpic)
        [self.porView.imageView sd_setImageWithURL:[NSURL URLWithString:_model.portrait.originalpic] placeholderImage:defaultImage];
    
    self.userName.text = _model.userName;
    self.recomendData.text = _model.recomendData;
    self.recomendContent.text = _model.recomedContent;
}

#pragma mark - HightStatu
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
}

#pragma mark - CommonUI
- (UILabel *)getOnePropertyLabel
{
    UILabel * label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14.f];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = RGB_Color(0x33, 0x33, 0x33);
    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 1;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    return label;
}

- (UIView *)getOnelineView
{
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = HM_LINE_COLOR;
    return view;
}

@end
