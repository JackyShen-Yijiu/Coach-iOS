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
@property(nonatomic,strong)UIView * rightLine;

@end

@implementation CourseSummaryListCell
+ (CGFloat)cellHeightWithModel:(HMCourseModel *)model
{
    CGFloat hegith =  180 + 10;
    if (!model.coursePikerAddres) {
        hegith -=22;
    }
    return hegith;
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
    self.potraitView = [[PortraitView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    self.potraitView.layer.cornerRadius = 1.f;
    self.potraitView.layer.shouldRasterize = YES;
    self.potraitView.backgroundColor = [UIColor clearColor];
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

    self.rightLine = [[UIView alloc] init];
    [self.bgView addSubview:self.rightLine];
    
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
        make.top.equalTo(self.midLine.mas_top).offset(16.f);
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
    
    [self.rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(1);
        make.bottom.equalTo(self.bgView).offset(-1);
        make.width.equalTo(@(5));
        make.height.equalTo(self.bgView);
    }];
    
}

#pragma mark - Data
- (void)setModel:(HMCourseModel *)model
{
    _model = model;
    UIImage * defaultImage = [UIImage imageNamed:@"defoult_por"];
    self.potraitView.imageView.image = defaultImage;
    NSString * imageStr = _model.studentInfo.porInfo.originalpic;
    if(imageStr)
        [self.potraitView.imageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:defaultImage];
    
    self.mainTitle.text = _model.studentInfo.userName;
    self.subTitle.text = _model.courseProgress;
    
    switch (self.model.courseStatue) {
            
        case  KCourseStatueInvalid :
            break;
        case  KCourseStatueapplying :   // 预约中(新订单)
            self.statueLabel.textColor = RGB_Color(0xff, 0x66, 0x33);

            break;
        case  KCourseStatueapplycancel :// 学生取消（已取消）
            self.statueLabel.textColor = RGB_Color(0x99, 0x99, 0x99);

            break;
        case  KCourseStatueapplyconfirm:  // 已确定(新订单)
            self.statueLabel.textColor = RGB_Color(0xff, 0x66, 0x33);

            break;
        case  KCourseStatueapplyrefuse:      // 教练拒绝或者取消（已取消）
            self.statueLabel.textColor = RGB_Color(0x99, 0x99, 0x99);
            
            break;
        case  KCourseStatueunconfirmfinish: //  待确认完成------------无此状态
            self.statueLabel.textColor = RGB_Color(0xff, 0x93, 0x33);

            break;
        case  KCourseStatueucomments:    // 待评论(待评论)
            self.statueLabel.textColor = RGB_Color(0xff, 0x93, 0x33);

            break;
        case  KCourseStatueOnCommended: // 评论成功（已完成）
            self.statueLabel.textColor = RGB_Color(0x99, 0x99, 0x99);

            break;
        case  KCourseStatuefinish: // 订单完成（已完成）
            
            break;
        case  KCourseStatuesystemcancel: // 系统取消（已取消）
            self.statueLabel.textColor = RGB_Color(0x99, 0x99, 0x99);

            break;
        case  KCourseStatuesignin: // 已签到(新订单)
            self.statueLabel.textColor =  RGB_Color(0x99, 0x99, 0x99);;

            break;
        case  KCourseStatuenosignin: // 未签到(已完成)
            self.statueLabel.textColor = RGB_Color(0x99, 0x99, 0x99);
 
            break;
            
    }
    
    self.rightLine.backgroundColor = self.statueLabel.textColor;
    
    self.statueLabel.text = [_model getStatueString];

    self.courseTimeLabel.text = _model.courseTime;
    self.courseAddressLabel.text = [NSString stringWithFormat:@"训练场地: %@",_model.courseTrainInfo.address];
    if (_model.coursePikerAddres) {
        self.pickAddressLabel.text = [NSString stringWithFormat:@"接送地点: %@",_model.coursePikerAddres];
    }else{
        self.pickAddressLabel.text = nil;
    }

    [self showUnDealStatu:self.model.courseStatue == KCourseStatueapplying];
    
}

- (void)showUnDealStatu:(BOOL)isUnDeal
{
    if (isUnDeal) {
        self.mainTitle.font = [UIFont boldSystemFontOfSize:16.f];
        self.subTitle.font = [UIFont boldSystemFontOfSize:14.f];
        self.courseTimeLabel.font = [UIFont boldSystemFontOfSize:14.f];
        self.courseAddressLabel.font = [UIFont boldSystemFontOfSize:14.f];
        self.pickAddressLabel.font = [UIFont boldSystemFontOfSize:14.f];
    }else{
        self.mainTitle.font = [UIFont boldSystemFontOfSize:16.f];
        self.subTitle.font = [UIFont systemFontOfSize:14.f];
        self.courseTimeLabel.font = [UIFont systemFontOfSize:14.f];
        self.courseAddressLabel.font = [UIFont systemFontOfSize:14.f];
        self.pickAddressLabel.font = [UIFont systemFontOfSize:14.f];
    }
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
