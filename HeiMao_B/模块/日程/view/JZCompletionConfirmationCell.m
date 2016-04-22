//
//  JZCompletionConfirmationCell.m
//  HeiMao_B
//
//  Created by ytzhang on 16/3/30.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZCompletionConfirmationCell.h"
#import "JZData.h"
#import "YBConfimContentView.h"

@interface JZCompletionConfirmationCell ()

@property (nonatomic ,strong) UIView *bgTopView; // 背景
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;


@property (nonatomic,strong) YBConfimContentView *confimContentView;

@end

@implementation JZCompletionConfirmationCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)initUI{
    
    self.backgroundColor = [UIColor clearColor];
    
    // 顶部视图
    [self.contentView addSubview:self.bgTopView];
    [self.bgTopView addSubview:self.iconImageView];
    [self.bgTopView addSubview:self.nameLabel];
    [self.bgTopView addSubview:self.timeLabel];
    [self.bgTopView addSubview:self.arrowImageView];
    
    // 底部视图
    [self.contentView addSubview:self.confimContentView];
    
}

- (YBConfimContentView *)confimContentView
{
    if (_confimContentView==nil) {
        _confimContentView = [[YBConfimContentView alloc] init];
    }
    return _confimContentView;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    // 顶部视图
    [self.bgTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
        make.height.mas_equalTo(@80); // 80
    }];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgTopView.mas_top).offset(16);
        make.left.mas_equalTo(self.bgTopView.mas_left).offset(16);
        make.width.mas_equalTo(@48);
        make.height.mas_equalTo(@48);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgTopView.mas_top).offset(21);
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(16);
        make.width.mas_equalTo(@150);
        make.height.mas_equalTo(@14);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(12);
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.width.mas_equalTo(@200);
        make.height.mas_equalTo(@12);
    }];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bgTopView.mas_centerY);
        make.right.mas_equalTo(self.bgTopView.mas_right).offset(-16);
        make.width.mas_equalTo(@14);
        make.height.mas_equalTo(@8);
    }];
    
    
}

// 顶部视图
- (UIView *)bgTopView{
    if (_bgTopView == nil) {
        _bgTopView = [[UIView alloc] init];
        _bgTopView.backgroundColor = [UIColor whiteColor];
    }
    return _bgTopView;
}
- (UIImageView *)iconImageView{
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.cornerRadius = 24;
        _iconImageView.image = [UIImage imageNamed:@"student_all_on"];
        
    }
    return _iconImageView;
}
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"周家";
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = JZ_FONTCOLOR_LIGHT;
    }
    return _nameLabel;
}
- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"08:00-09:00";
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = JZ_FONTCOLOR_LIGHT;
    }
    return _timeLabel;
}
- (UIImageView *)arrowImageView{
    if (_arrowImageView == nil) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = [UIImage imageNamed:@"JZCoursemore_dwon"];
    }
    return _arrowImageView;
}

- (void)setListModel:(JZData *)listModel
{
    _listModel = listModel;
    
    self.nameLabel.text = _listModel.userid.name;
    
    // 开始时间
    NSString *stareTime = [self getLocalDateFormateUTCDate:_listModel.begintime];
    // 结束数据
    NSString *endTime = [self getLocalDateFormateUTCDate:_listModel.endtime];
    self.timeLabel.text = [NSString stringWithFormat:@"%@-%@",stareTime,endTime];
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_listModel.userid.headportrait.originalpic]] placeholderImage:[UIImage imageNamed:@"student_all_on"]];
    
    self.confimContentView.parentViewController = self.parentViewController;
    self.confimContentView.hidden = !listModel.isOpen;
    CGFloat height = [self.confimContentView confimContentView:_subjectArray model:_listModel];
    NSLog(@"setListModel height:%f",height);
    [self.confimContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.top.mas_equalTo(self.mas_top).offset(90);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(height);
    }];
    
}

+ (CGFloat)cellHeihtWithlistData:(JZData *)data subjectArray:(NSArray *)subjectArray{
    
    JZCompletionConfirmationCell *JZCompletonCell = [[JZCompletionConfirmationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"JZCompletionConfirmationCell"];
    
    [JZCompletonCell layoutIfNeeded]; 
   
    if (data.isOpen) {
        CGFloat height = [JZCompletonCell.confimContentView confimContentView:subjectArray model:data];
        return height + 90;
    }
    return 90;
    
}

// UTC转化
- (NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate {
    //    NSLog(@"utc = %@",utcDate);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
    //输出格式
        [dateFormatter setDateFormat:@"HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}

@end
