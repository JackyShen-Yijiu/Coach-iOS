//
//  SystemMessageDetailCell.m
//  HeiMao_B
//
//  Created by ytzhang on 16/1/13.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "SystemMessageDetailCell.h"

@interface SystemMessageDetailCell ()
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *detailBackView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *dataLabel;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIView *topLineView;
@property (nonatomic, strong) UILabel *didClickLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UIView *bottomLineView;





@end

@implementation SystemMessageDetailCell

- (void)awakeFromNib {
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
        
    }
    return self;
}
- (void)initUI{
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.detailBackView];
    [self.detailBackView addSubview:self.titleLabel];
    [self.detailBackView addSubview:self.imgView];
    [self.detailBackView addSubview:self.dataLabel];
    [self.detailBackView addSubview:self.detailLabel];
    [self.detailBackView addSubview:self.topLineView];
    [self.detailBackView addSubview:self.didClickLabel];
    [self.detailBackView addSubview:self.arrowImageView];
//    [self.detailBackView addSubview:self.bottomLineView];
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
- (void)layoutSubviews{
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.width.equalTo(@80);
        make.height.equalTo(@20);
        
    }];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_bottom).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        
    }];
    [self.detailBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView.mas_top).offset(10);
        make.left.equalTo(self.backView.mas_left).offset(0);
        make.right.equalTo(self.backView.mas_right).offset(0);
        make.bottom.equalTo(self.backView.mas_bottom).offset(0);
        
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailBackView.mas_top).offset(10);
        make.left.equalTo(self.detailBackView.mas_left).offset(10);
        make.width.equalTo(@200);
        make.height.equalTo(@15);
        
    }];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailBackView.mas_top).offset(10);
        make.right.equalTo(self.detailBackView.mas_right).offset(-10);
        make.width.equalTo(@28);
        make.height.equalTo(@24);
        
    }];
    [self.dataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.left.equalTo(self.detailBackView.mas_left).offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@10);
        
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dataLabel.mas_bottom).offset(0);
        make.left.equalTo(self.detailBackView.mas_left).offset(10);
        make.right.equalTo(self.detailBackView.mas_right).offset(0);
        make.height.equalTo(@30);
        
    }];
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailLabel.mas_bottom).offset(10);
        make.left.equalTo(self.detailBackView.mas_left).offset(0);
        make.right.equalTo(self.detailBackView.mas_right).offset(0);
        make.height.equalTo(@2);
       
        
    }];
    [self.didClickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLineView.mas_bottom).offset(10);
        make.left.equalTo(self.detailBackView.mas_left).offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
        
    }];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLineView.mas_bottom).offset(10);
        make.right.equalTo(self.detailBackView.mas_right).offset(-10);
        make.width.equalTo(@13);
        make.height.equalTo(@22);
        
    }];


    
    
}
#pragma mark --- Lazy 加载
- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[ UILabel alloc] init];
        _timeLabel.backgroundColor = [UIColor grayColor];
        _timeLabel.text = @"昨天  10:00";
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.textAlignment = UITextAlignmentCenter;
         _timeLabel.backgroundColor = RGB_Color(153, 153, 153);
        [_timeLabel.layer setMasksToBounds:YES];
        [_timeLabel.layer setCornerRadius:5];
        _timeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _timeLabel;
}
- (UIView *)backView{
    if (_backView == nil) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = RGB_Color(31, 124, 235);
        [_backView.layer setShadowColor:[UIColor blackColor].CGColor];
        [_backView.layer setShadowOpacity:0.2f];
        [_backView.layer setOpacity:1.f];
        [_backView.layer setShadowOffset:CGSizeMake(0, 1.5)];
    }
    return _backView;
}
- (UIView *)detailBackView{
    if (_detailBackView == nil) {
        _detailBackView = [[UIView alloc] init];
        _detailBackView.backgroundColor = [UIColor whiteColor];
    }
    return _detailBackView;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"金额增加通知";
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        
    }
    return _titleLabel;
    
}
- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] init];
        _imgView.image = [UIImage imageNamed:@""];
    }
    return _imgView;
}
- (UILabel *)dataLabel{
    if (_dataLabel == nil) {
        _dataLabel = [[UILabel alloc] init];
        _dataLabel.text = @"2016-1-1";
        _dataLabel.font = [UIFont systemFontOfSize:12];
    }
    return _dataLabel;
}
- (UILabel *)detailLabel{
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textColor = [UIColor grayColor];
        _detailLabel.numberOfLines = 0;
        _detailLabel.font = [UIFont systemFontOfSize:14];
    }
    return _detailLabel;
}
- (UIView *)topLineView{
    if (_topLineView == nil) {
        _topLineView = [[UIView alloc] init];
        _topLineView.backgroundColor = RGB_Color(230, 230, 230);
    }
    return _topLineView;
}
- (UILabel *)didClickLabel{
    if (_didClickLabel == nil) {
        _didClickLabel = [[UILabel alloc] init];
        _didClickLabel.text = @"立即查看";
        _didClickLabel.font = [UIFont systemFontOfSize:17];
    }
    return _didClickLabel;
}
- (UIImageView *)arrowImageView{
    if (_arrowImageView == nil) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = [UIImage imageNamed:@"arrow"];
    }
    return _arrowImageView;
}

- (UIView *)bottomLineView{
    if (_bottomLineView == nil) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = [UIColor grayColor];
    }
    return _bottomLineView;
}
- (void)setSystemModel:(SystemMessageModel *)systemModel{
    self.titleLabel.text = systemModel.title;
    self.imgView.image = [UIImage imageNamed:@"money"];
    self.detailLabel.text = systemModel.detial;
    NSString *formatYYYYMM = @"yyyy-MM";
    NSString *todayYYYYMM = [self dateFromLocalWithFormatString:formatYYYYMM];
    
    NSString *testYYYYMM = [self getLocalDateFormateUTCDate:systemModel.createtime format:formatYYYYMM];
    
    // 比较年和月是否一样
    if ([todayYYYYMM isEqualToString:testYYYYMM]) {
        // 判断天数
        NSString *formatDD = @"dd";
        NSString *today = [self dateFromLocalWithFormatString:formatDD];
        NSString *testDay = [self getLocalDateFormateUTCDate:systemModel.createtime format:formatDD];
        
        if (1 == [today integerValue] - [testDay integerValue]) {
            NSString *formatHHMM = @"HH:mm";
            NSString *testHHMM = [self getLocalDateFormateUTCDate:systemModel.createtime format:formatHHMM];
            self.timeLabel.text = [NSString stringWithFormat:@"昨天 %@",testHHMM];
            
        }else if (0 == [today integerValue] - [testDay integerValue]){
            NSString *formatHHMM = @"HH:mm";
            NSString *testHHMM = [self getLocalDateFormateUTCDate:systemModel.createtime format:formatHHMM];
            self.timeLabel.text = [NSString stringWithFormat:@"今天 %@",testHHMM];

        }
    }
    // 显示日期
    NSString *formatyyyyMMdd = @"yyyy-MM-dd";
    NSString *testyyyyMMdd = [self getLocalDateFormateUTCDate:systemModel.createtime format:formatyyyyMMdd];
    self.dataLabel.text = testyyyyMMdd;
    
    
}
- (NSString *)dateFromLocalWithFormatString:(NSString *)formatString {
    
    NSDate *localDate = [NSDate new];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:formatString];
    return [dateFormatter stringFromDate:localDate];
}

//将UTC日期字符串转为本地时间字符串
//输入的UTC日期格式2013-08-03T04:53:51+0000
- (NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate format:(NSString *)formatString {
    //    NSLog(@"utc = %@",utcDate);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
    //输出格式
    [dateFormatter setDateFormat:formatString];
    //    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}

@end
