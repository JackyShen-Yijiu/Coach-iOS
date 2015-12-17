//
//  StudentHomeCell.m
//  HeiMao_B
//
//  Created by kequ on 15/10/28.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "StudentHomeUserBasicInfoCell.h"
#import "PortraitView.h"

@interface StudentHomeUserBasicInfoCell()
@property(nonatomic,strong)PortraitView * porTraitView;
@property(nonatomic,strong)UILabel * userNameLabel;
@property(nonatomic,strong)UILabel * userIdLabel;
@property(nonatomic,strong)UIView * bottomLine;

@property(nonatomic,strong)NSString *bgImageUrlStr;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *userId;
@end

@implementation StudentHomeUserBasicInfoCell
+ (CGFloat)cellHeigth
{
    return 240.f + 73;
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
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.porTraitView = [[PortraitView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, 240)];
    self.porTraitView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.porTraitView];
    
    self.userNameLabel = [[UILabel alloc] init];
    self.userNameLabel.backgroundColor = [UIColor clearColor];
    self.userNameLabel.font = [UIFont boldSystemFontOfSize:16.f];
    self.userNameLabel.textColor = RGB_Color(0x33, 0x33, 0x33);
    self.userNameLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.userNameLabel];
    
    
    self.userIdLabel = [[UILabel alloc] init];
    self.userIdLabel.backgroundColor = [UIColor clearColor];
    self.userIdLabel.textAlignment = NSTextAlignmentLeft;
    self.userIdLabel.font = [UIFont systemFontOfSize:12];
    self.userIdLabel.textColor = RGB_Color(0x99, 0x99, 0x99);
    [self.contentView addSubview:self.userIdLabel];
    
    self.bottomLine = [self getOnelineView];
    [self.contentView addSubview:self.bottomLine];
    [self updateConstraints];
}

- (void)updateConstraints
{
    [self.porTraitView mas_makeConstraints:^(MASConstraintMaker *make) {


        make.left.equalTo(self.contentView);
        make.width.equalTo(self.contentView);
        make.height.equalTo(@(240));
        make.top.equalTo(@(0));
    }];
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15.f));
        make.top.equalTo(self.porTraitView.mas_bottom).offset(20.f);
        make.right.equalTo(self.contentView).offset(-15);
        make.height.equalTo(@(16.f));
    }];
    
    [self.userIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameLabel);
        make.width.equalTo(self.userNameLabel);
        make.top.equalTo(self.userNameLabel.mas_bottom).offset(7);
        make.height.equalTo(@(12.f));
    }];
    
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameLabel);
        make.width.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-HM_LINE_HEIGHT);
        make.height.equalTo(@(HM_LINE_HEIGHT));
    }];
    [super updateConstraints];
}

- (void)setBgImageUrlStr:(NSString *)bgImageUrlStr userName:(NSString *)userName userId:(NSString *)userId
{
    _bgImageUrlStr = bgImageUrlStr;
    UIImage * defaultImage = [UIImage imageNamed:@"defoult_por"];
    if(_bgImageUrlStr)
        [self.porTraitView.imageView sd_setImageWithURL:[NSURL URLWithString:_bgImageUrlStr] placeholderImage:defaultImage];
    
    self.userNameLabel.text = userName;
    self.userIdLabel.text = [NSString stringWithFormat:@"ID %@",userId];
}

#pragma mark - HightStatu
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
}
#pragma mark - CommonMethod
#pragma mark - Common
- (UIView *)getOnelineView
{
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = HM_LINE_COLOR;
    return view;
}


@end
