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

// 官方24课时
@property(nonatomic,strong)UILabel * guanfangLabel;

// 已约多少课时
@property(nonatomic,strong)UILabel * yiyueLabel;
// 剩余23课时
@property(nonatomic,strong)UILabel * shengyuLabel;
// 漏课
@property(nonatomic,strong)UILabel * loukeLabel;

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
    self.mainTitle.font = [UIFont boldSystemFontOfSize:15.f];
    self.mainTitle.textColor = RGB_Color(0x33, 0x33, 0x33);
    self.mainTitle.backgroundColor = [UIColor clearColor];
    self.mainTitle.numberOfLines = 1;
    self.mainTitle.text = @"姓名";
    [self.contentView addSubview:self.mainTitle];
    
    self.subTitle = [[UILabel alloc] init];
    self.subTitle.textAlignment = NSTextAlignmentLeft;
    self.subTitle.font = [UIFont systemFontOfSize:12.f];
    self.subTitle.textColor = [UIColor lightGrayColor];
    self.subTitle.backgroundColor = [UIColor clearColor];
    self.subTitle.numberOfLines = 1;
    self.subTitle.text = @"subTitle";
    [self.contentView addSubview:self.subTitle];
    
    self.guanfangLabel = [[UILabel alloc] init];
    self.guanfangLabel.textAlignment = NSTextAlignmentLeft;
    self.guanfangLabel.font = [UIFont systemFontOfSize:12.f];
    self.guanfangLabel.textColor = [UIColor lightGrayColor];
    self.guanfangLabel.backgroundColor = [UIColor clearColor];
    self.guanfangLabel.numberOfLines = 1;
    self.guanfangLabel.text = @"guanfangLabel";
    [self.contentView addSubview:self.guanfangLabel];
    
    self.yiyueLabel = [[UILabel alloc] init];
    self.yiyueLabel.textAlignment = NSTextAlignmentLeft;
    self.yiyueLabel.font = [UIFont systemFontOfSize:10.f];
    self.yiyueLabel.textColor = RGB_Color(0x99, 0x99, 0x99);
    self.yiyueLabel.backgroundColor = [UIColor clearColor];
    self.yiyueLabel.numberOfLines = 1;
    self.yiyueLabel.text = @"yiyueLabel";
    [self.contentView addSubview:self.yiyueLabel];
    
    self.shengyuLabel = [[UILabel alloc] init];
    self.shengyuLabel.textAlignment = NSTextAlignmentLeft;
    self.shengyuLabel.font = [UIFont systemFontOfSize:10.f];
    self.shengyuLabel.textColor = RGB_Color(0x99, 0x99, 0x99);
    self.shengyuLabel.backgroundColor = [UIColor clearColor];
    self.shengyuLabel.numberOfLines = 1;
    self.shengyuLabel.text = @"shengyuLabel";
    [self.contentView addSubview:self.shengyuLabel];
    
    self.loukeLabel = [[UILabel alloc] init];
    self.loukeLabel.textAlignment = NSTextAlignmentLeft;
    self.loukeLabel.font = [UIFont systemFontOfSize:10.f];
    self.loukeLabel.textColor = RGB_Color(0x99, 0x99, 0x99);
    self.loukeLabel.backgroundColor = [UIColor clearColor];
    self.loukeLabel.numberOfLines = 1;
    self.loukeLabel.text = @"loukeLabel";
    [self.contentView addSubview:self.loukeLabel];
    
    self.courseBeginTime = [self getOnePropertyLabel];
    self.courseBeginTime.textColor = RGB_Color(30, 31, 34);
    self.courseBeginTime.text = @"开始时间";
    [self.contentView addSubview:self.courseBeginTime];
    
    self.courseEndTime = [self getOnePropertyLabel];
    self.courseEndTime.textColor = RGB_Color(153, 153, 153);
    self.courseEndTime.text = @"courseEndTime";
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
        make.top.equalTo(self.potraitView.mas_top);
    }];
    
    [self.subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainTitle);
        make.width.equalTo(@200);
        make.top.equalTo(self.mainTitle.mas_bottom).offset(5.f);
        make.height.equalTo(@(16.f));
    }];
    
    [self.guanfangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainTitle);
        make.width.equalTo(@200);
        make.top.equalTo(self.subTitle.mas_bottom).offset(5.f);
        make.height.equalTo(@(16.f));
    }];
    
    // 已约
    [self.yiyueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.height.equalTo(@(16.f));
        make.right.equalTo(@(-10));
    }];
    // 剩余
    [self.shengyuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.yiyueLabel.mas_bottom).offset(10);
        make.height.equalTo(@(16.f));
        make.right.equalTo(@(-10));
    }];
    // 漏课
    [self.loukeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shengyuLabel.mas_bottom).offset(10);
        make.height.equalTo(@(16.f));
        make.right.equalTo(@(-10));
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
    
    UIImage * defaultImage = [UIImage imageNamed:@"defoult_por"];
    self.potraitView.imageView.image = defaultImage;
    NSString * imageStr = _model.studentInfo.porInfo.originalpic;
    if(imageStr)
        [self.potraitView.imageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:defaultImage];
    
    // 时间
    self.courseBeginTime.text = _model.courseBeginTime;
    self.courseEndTime.text = _model.courseEndtime;
    
    // 姓名
    self.mainTitle.text = _model.studentInfo.userName;
    
    // 学习内容
    self.subTitle.text = _model.courseprocessdesc;

    // 官方24课时
    self.guanfangLabel.text = @"运管处登记学时:暂无";
    if (_model.officialDesc&&[_model.officialDesc length]!=0) {
        self.guanfangLabel.text = _model.officialDesc;
    }
    
    // 已约
    NSInteger totleYiyueCount = model.subjectthree.finishcourse+model.subjectthree.reservation;
    self.yiyueLabel.text = [NSString stringWithFormat:@"已约%ld课时",totleYiyueCount];
    
    // 剩余
    self.shengyuLabel.text = [NSString stringWithFormat:@"剩余%ld课时",(long)model.leavecoursecount];
    
    // 漏课
    self.loukeLabel.text = [NSString stringWithFormat:@"漏%ld课时",(long)model.missingcoursecount];
    
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
