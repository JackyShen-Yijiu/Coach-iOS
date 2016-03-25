//
//  StudentHomeUserInfoCell.m
//  HeiMao_B
//
//  Created by kequ on 15/10/28.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "StudentHomeUserCourseInfoCell.h"

@interface StudentHomeUserCourseInfoCell()
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * schoolLabel;
@property(nonatomic,strong)UILabel * carLicenseTypeLabel;
@property(nonatomic,strong)UILabel * courseScheduleLabel;
@property(nonatomic,strong)UILabel * commmonAddressLabel;
@property(nonatomic,strong)UIView * lineView;
@end

@implementation StudentHomeUserCourseInfoCell

+ (CGFloat)cellHeigth
{
    return 121 + 17.f;
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
    self.titleLabel = [self getOnePropertyLabel];
    [self.contentView addSubview:self.titleLabel];
    
    self.schoolLabel = [self getOnePropertyLabel];
    [self.contentView addSubview:self.schoolLabel];
    
    self.carLicenseTypeLabel = [self getOnePropertyLabel];
    [self.contentView addSubview:self.carLicenseTypeLabel];
    
    self.courseScheduleLabel = [self getOnePropertyLabel];
    [self.contentView addSubview:self.courseScheduleLabel];
    
    self.commmonAddressLabel = [self getOnePropertyLabel];
    [self.contentView addSubview:self.commmonAddressLabel];
    
    self.lineView = [self getOnelineView];
    [self.contentView addSubview:self.lineView];
    [self updateConstraints];
}


- (void)updateConstraints
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(17.f);
        make.height.equalTo(@(14.f));
        make.left.equalTo(self.contentView).offset(15.f);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
    [self.schoolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.right.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(13.f);
        make.height.equalTo(self.titleLabel);
    }];
    
    [self.carLicenseTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.right.equalTo(self.titleLabel);
        make.top.equalTo(self.schoolLabel.mas_bottom).offset(7.f);
        make.height.equalTo(self.titleLabel);
    }];
    
    
    [self.courseScheduleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.right.equalTo(self.titleLabel);
        make.top.equalTo(self.carLicenseTypeLabel.mas_bottom).offset(7.f);
        make.height.equalTo(self.titleLabel);
    }];
    
    [self.commmonAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.right.equalTo(self.titleLabel);
        make.top.equalTo(self.courseScheduleLabel.mas_bottom).offset(7.f);
        make.height.equalTo(self.titleLabel);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_bottom).offset(-HM_LINE_HEIGHT);
        make.height.equalTo(@(HM_LINE_HEIGHT));
    }];
    
    
    [super updateConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}
#pragma mark - Data
- (void)setModel:(HMStudentModel *)model
{
    if (_model == model) {
        return;
    }
    _model = model;
    self.titleLabel.text = @"学车信息";
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14.f];
 
    
    self.schoolLabel.text = [NSString stringWithFormat:@"报考驾校：%@",[_model.schoolInfo schoolName]];
    self.carLicenseTypeLabel.text = [NSString stringWithFormat:@"车       型： %@  %@",[_model carLicenseInfo].code, [_model carLicenseInfo].name];
    
    if ([_model courseSchedule] && [_model courseSchedule].length!=0) {
        
        NSString * courseSchedu = [NSString stringWithFormat:@"学车进度： %@",[_model courseSchedule]];
        
        NSDictionary * attru = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:14.f]
                                 };
        NSMutableAttributedString * atr = [[NSMutableAttributedString alloc] initWithString:courseSchedu attributes:attru];
        
        [atr addAttribute:NSForegroundColorAttributeName value:RGB_Color(0x28, 0x79, 0xf3) range:NSMakeRange(6, courseSchedu.length - 6)];
        
        [self.courseScheduleLabel setAttributedText:atr];
        
    }

    if ([_model commmonAddress] && [[_model commmonAddress] length]!=0) {
        self.commmonAddressLabel.text = [NSString stringWithFormat:@"接送地址： %@",[_model commmonAddress]];
    }
    
}

#pragma mark - HightStatu
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
}

#pragma mark - CommonMethod

- (UILabel *)getOnePropertyLabel
{
    UILabel * label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14.f];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 1;
    label.textColor = RGB_Color(0x33, 0x33, 0x33);
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
