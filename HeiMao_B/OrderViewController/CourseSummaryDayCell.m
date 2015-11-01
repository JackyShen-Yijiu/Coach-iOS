//
//  courseSummaryDayCell.m
//  HeiMao_B
//
//  Created by kequ on 15/10/25.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "CourseSummaryDayCell.h"
#import "PortraitView.h"

@interface CourseSummaryDayCell ()
@property(nonatomic,strong)PortraitView * potraitView;
@property(nonatomic,strong)UILabel * mainTitle;
@property(nonatomic,strong)UILabel * subTitle;
@property(nonatomic,strong)UILabel * courseBeginTime;
@property(nonatomic,strong)UILabel * courseEndTime;
@property(nonatomic,strong)UIView * midLine;
@property(nonatomic,strong)UIView * bottomLine;

@end

@implementation CourseSummaryDayCell
+ (CGFloat)cellHeight
{
    return 92.f;
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
    self.potraitView = [[PortraitView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    self.potraitView.layer.cornerRadius = 1.f;
    self.potraitView.layer.shouldRasterize = YES;
    self.potraitView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.potraitView];
    
    self.mainTitle = [[UILabel alloc] init];
    self.mainTitle.textAlignment = NSTextAlignmentLeft;
    self.mainTitle.font = [UIFont boldSystemFontOfSize:16.f];
    self.mainTitle.textColor = RGB_Color(0x33, 0x33, 0x33);
    self.mainTitle.backgroundColor = [UIColor clearColor];
    self.mainTitle.numberOfLines = 1;
    [self.contentView addSubview:self.mainTitle];
    
    
    self.subTitle = [[UILabel alloc] init];
    self.subTitle.textAlignment = NSTextAlignmentLeft;
    self.subTitle.font = [UIFont systemFontOfSize:14.f];
    self.subTitle.textColor = RGB_Color(0x99, 0x99, 0x99);
    self.subTitle.backgroundColor = [UIColor clearColor];
    self.subTitle.numberOfLines = 1;
    [self.contentView addSubview:self.subTitle];
    
   
    
    self.courseBeginTime = [self getOnePropertyLabel];
    self.courseBeginTime.textColor = RGB_Color(30, 31, 34);
    [self.contentView addSubview:self.courseBeginTime];
    
    self.courseEndTime = [self getOnePropertyLabel];
    self.courseEndTime.textColor = RGB_Color(153, 153, 153);
    [self.contentView addSubview:self.courseEndTime];
    
    
    self.midLine = [self getOnelineView];
    self.midLine.backgroundColor = RGB_Color(40, 121, 243);
    [self.contentView addSubview:self.midLine];
    
    self.bottomLine = [self getOnelineView];
    [self.contentView addSubview:self.bottomLine];
    [self updateConstraints];
}

#pragma mark Layout
- (void)updateConstraints
{
    [super updateConstraints];
    
    [self.courseBeginTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(58, 16));
        make.top.equalTo(@(([[self class] cellHeight] - 16 * 2 - 8)/2.f));
        make.left.equalTo(self.contentView);
    }];
    
    [self.courseEndTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.courseBeginTime);
        make.left.equalTo(self.courseBeginTime);
        make.top.equalTo(self.courseBeginTime.mas_bottom).offset(8);
    }];
    
    [self.potraitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60.f));
        make.left.equalTo(self.courseBeginTime.mas_right).offset(17.f);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.midLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.potraitView);
        make.width.equalTo(@(2));
        make.height.equalTo(self.potraitView);
        make.left.equalTo(self.courseBeginTime.mas_right);
    }];
    
    
    [self.mainTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.potraitView.mas_right).offset(12.f);
        make.height.equalTo(@(16.f));
        make.top.equalTo(@(([[self class] cellHeight] - 16 - 10 - 14)/2.f));
    }];
    
    
    [self.subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainTitle);
        make.width.equalTo(self.mainTitle);
        make.top.equalTo(self.mainTitle.mas_bottom).offset(10.f);
        make.height.equalTo(@(16.f));
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom).offset(-HM_LINE_HEIGHT);
        make.width.equalTo(self);
        make.height.equalTo(@(HM_LINE_HEIGHT));
        make.left.equalTo(self);
    }];
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    self.contentView.backgroundColor = highlighted ? HM_HIGHTCOLOR : [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    self.contentView.backgroundColor = selected ? [UIColor colorWithWhite:0.9 alpha:1]  : [UIColor whiteColor];
}

#pragma mark - Data
- (void)setModel:(HMCourseModel *)model
{
    if (_model == model) {
        return;
    }

    _model = model;
    
    UIImage * defaultImage = [UIImage imageNamed:@"temp"];
    NSString * imageStr = _model.studentInfo.porInfo.originalpic;
    if(imageStr)
        [self.potraitView.imageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:defaultImage];
    
    self.mainTitle.text = _model.studentInfo.userName;
    self.subTitle.text = _model.courseProgress;
    self.courseBeginTime.text = _model.courseBeginTime;
    self.courseEndTime.text = _model.courseEndtime;
}

#pragma mark - Common

- (UIView *)getOnelineView
{
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = HM_LINE_COLOR;
    return view;
}

- (UILabel *)getOnePropertyLabel
{
    UILabel * label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:16.f];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 1;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    return label;
}


@end
