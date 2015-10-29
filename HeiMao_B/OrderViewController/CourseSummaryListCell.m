//
//  HeiMao_B
//
//  Created by kequ on 15/10/25.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "CourseSummaryListCell.h"


@interface CourseSummaryListCell()
@property(nonatomic,strong)UIView * bgView;
@property(nonatomic,strong)PortraitView * potraitView;
@property(nonatomic,strong)UILabel * mainTitle;
@property(nonatomic,strong)UILabel * subTitle;
@property(nonatomic,strong)UILabel * statueLabel;

@property(nonatomic,strong)UILabel * courseTimeLabel;
@property(nonatomic,strong)UILabel * courseAddressLabel;
@property(nonatomic,strong)UILabel * pickAddressLabel;

@property(nonatomic,strong)UIView * topLine;
@property(nonatomic,strong)UIView * midLine;
@property(nonatomic,strong)UIView * bottomLine;

@end

@implementation CourseSummaryListCell
+ (CGFloat)cellHeight
{
    return 180 + 10;
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
    self.contentView.backgroundColor  = RGB_Color(247, 249, 251);
    self.potraitView = [[PortraitView alloc] init];
    self.potraitView.layer.cornerRadius = 1.f;
    self.potraitView.layer.shouldRasterize = YES;
    self.potraitView.backgroundColor = [UIColor redColor];
    [self.bgView addSubview:self.potraitView];
    
    self.mainTitle = [[UILabel alloc] init];
    self.mainTitle.textAlignment = NSTextAlignmentLeft;
    self.mainTitle.font = [UIFont boldSystemFontOfSize:16.f];
    self.mainTitle.textColor = RGB_Color(0x33, 0x33, 0x33);
    self.mainTitle.backgroundColor = [UIColor clearColor];
    self.mainTitle.numberOfLines = 1;
    [self.bgView addSubview:self.mainTitle];
    
    
    self.subTitle = [[UILabel alloc] init];
    self.subTitle.textAlignment = NSTextAlignmentLeft;
    self.subTitle.font = [UIFont systemFontOfSize:14.f];
    self.subTitle.textColor = RGB_Color(0x99, 0x99, 0x99);
    self.subTitle.backgroundColor = [UIColor clearColor];
    self.subTitle.numberOfLines = 1;
    [self.bgView addSubview:self.subTitle];
  
    self.statueLabel = [[UILabel alloc] init];
    self.statueLabel.textAlignment = NSTextAlignmentRight;
    self.statueLabel.font = [UIFont systemFontOfSize:14.f];
    self.statueLabel.textColor = RGB_Color(0x99, 0x99, 0x99);
    self.statueLabel.backgroundColor = [UIColor clearColor];
    self.statueLabel.numberOfLines = 1;
    [self.bgView addSubview:self.statueLabel];
    
    self.courseTimeLabel = [self getOnePropertyLabel];
    [self.bgView addSubview:self.courseTimeLabel];
    
    self.courseAddressLabel = [self getOnePropertyLabel];
    [self.bgView addSubview:self.courseAddressLabel];
    
    self.pickAddressLabel = [self getOnePropertyLabel];
    [self.bgView addSubview:self.pickAddressLabel];
    
    self.topLine = [self getOnelineView];
    [self.bgView addSubview:self.topLine];
    
    self.midLine = [self getOnelineView];
    [self.bgView addSubview:self.midLine];
    
    self.bottomLine = [self getOnelineView];
    [self.bgView addSubview:self.bottomLine];
    [self updateConstraints];
}

#pragma mark Layout
- (void)updateConstraints
{
    [super updateConstraints];
    
    CGFloat leftOffsetSpacing = 15.f;
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
        make.width.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-10);
        
    }];
    
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView);
        make.left.equalTo(self.bgView);
        make.width.equalTo(self.bgView);
        make.height.equalTo(@(HM_LINE_HEIGHT));
    }];
    
    [self.potraitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(leftOffsetSpacing);
        make.top.equalTo(self.bgView).offset(15.f);
        make.size.mas_equalTo(CGSizeMake(60.f, 60.f));
    }];
    
    [self.statueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(14.f);
        make.right.equalTo(self.bgView).offset(-leftOffsetSpacing);
        make.left.equalTo(self.mainTitle.mas_right).offset(10);
    }];
    
    [self.mainTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.potraitView.mas_right).offset(12.f);
        make.height.equalTo(@(16.f));
        make.top.equalTo(@((90 - 16 - 10 - 14)/2.f));
    }];
    
    [self.subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainTitle);
        make.width.equalTo(self.mainTitle);
        make.top.equalTo(self.mainTitle.mas_bottom).offset(10.f);
        make.height.equalTo(@(16.f));
    }];
    
    [self.midLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(leftOffsetSpacing);
        make.right.equalTo(self.bgView).offset(-leftOffsetSpacing);
        make.top.equalTo(self.potraitView.mas_bottom).offset(15.f);
        make.height.equalTo(@(HM_LINE_HEIGHT));
    }];
    
    [self.courseTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(leftOffsetSpacing);
        make.right.equalTo(self.bgView).offset(-leftOffsetSpacing);
        make.top.equalTo(self.midLine.mas_top).offset((90 - 14 * 3 - 8 * 2)/2.f);
        make.height.equalTo(@(14));
    }];
    
    [self.courseAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.courseTimeLabel);
        make.top.equalTo(self.courseTimeLabel.mas_bottom).offset(8.f);
        make.centerX.equalTo(self.courseTimeLabel);
    }];
    
    [self.pickAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.courseAddressLabel);
        make.top.equalTo(self.courseAddressLabel.mas_bottom).offset(8.f);
        make.centerX.equalTo(self.courseAddressLabel);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView.mas_bottom).offset(-HM_LINE_HEIGHT);
        make.size.equalTo(self.topLine);
        make.left.equalTo(self.topLine);
        make.height.equalTo(@(HM_LINE_HEIGHT));
    }];
    
}

#pragma mark - Data
- (void)setModel:(HMCourseModel *)model
{
    if (_model == model) {
        return;
    }
    _model = model;
    UIImage * defaultImage = [UIImage imageNamed:@"temp"];
    NSString * imageStr = _model.studentInfo.porInfo.thumbnailpic;
    if(imageStr)
        [self.potraitView.imageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:defaultImage];
    
    self.mainTitle.text = _model.studentInfo.userName;
    self.subTitle.text = _model.courseProgress;
    self.statueLabel.text = [_model getStatueString];

    self.courseTimeLabel.text = _model.courseTime;
    self.courseAddressLabel.text = [NSString stringWithFormat:@"训练场地: %@",_model.courseAddress];
    self.pickAddressLabel.text = [NSString stringWithFormat:@"接送地点: %@",_model.coursePikerAddres];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    self.bgView.backgroundColor = highlighted ? HM_HIGHTCOLOR : [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    self.bgView.backgroundColor = selected ?  HM_HIGHTCOLOR : [UIColor whiteColor];
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
    label.font = [UIFont systemFontOfSize:14.f];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = RGB_Color(0x33, 0x33, 0x33);
    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 1;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    return label;
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bgView];
    }
    return _bgView;
}
@end
