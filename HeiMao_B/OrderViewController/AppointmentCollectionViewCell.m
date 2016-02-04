//
//  AppointmentCollectionViewCell.m
//  BlackCat
//
//  Created by bestseller on 15/10/3.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "AppointmentCollectionViewCell.h"
#import "ToolHeader.h"
#import "AppointmentCoachTimeInfoModel.h"

@interface AppointmentCollectionViewCell ()
@property (strong, nonatomic) UIView *selectedAppView;
@property (strong, nonatomic) UIView *delive;
@end

@implementation AppointmentCollectionViewCell

- (UIView *)selectedAppView {
    if (_selectedAppView == nil) {
        _selectedAppView = [[UIView alloc] init];
        _selectedAppView.layer.borderWidth = 1;
        _selectedAppView.layer.borderColor = RGB_Color(31, 124, 235).CGColor;
    }
    return _selectedAppView;
}
- (UILabel *)startTimeLabel {
    if (_startTimeLabel == nil) {
        _startTimeLabel = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:15]];
        _startTimeLabel.text = @"8:00";
    }
    return _startTimeLabel;
}
- (UILabel *)finalTimeLabel {
    if (_finalTimeLabel == nil) {
        _finalTimeLabel = [WMUITool initWithTextColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:9]];
        _finalTimeLabel.text = @"可约1人已约4人";
    }
    return _finalTimeLabel;
}
- (UILabel *)remainingPersonLabel {
    if (_remainingPersonLabel == nil) {
        _remainingPersonLabel = [WMUITool initWithTextColor:TEXTGRAYCOLOR withFont:[UIFont systemFontOfSize:9]];
        _remainingPersonLabel.text = @"签到4人";
    }
    return _remainingPersonLabel;
}
- (UIView *)delive
{
    if (_delive == nil) {
        _delive = [[UIView alloc] init];
        _delive.backgroundColor = [UIColor lightGrayColor];
        _delive.alpha = 0.3;
    }
    return _delive;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.selectedBackgroundView = self.selectedAppView;
        
        [self.contentView addSubview:self.startTimeLabel];
        
        [self.contentView addSubview:self.finalTimeLabel];
        
        [self.contentView addSubview:self.remainingPersonLabel];
        
        [self.contentView addSubview:self.delive];
        
        [self.startTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.mas_top).offset(10);
        }];
        [self.finalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.startTimeLabel.mas_bottom);
        }];
        [self.remainingPersonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.finalTimeLabel.mas_bottom).offset(0);
        }];
        [self.delive mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@0);
            make.right.mas_equalTo(@0);
            make.height.mas_equalTo(@0.5);
            make.top.mas_equalTo(self.mas_bottom).offset(-0.5);
        }];
        
    }
    return self;
}


- (void)setAppointInfoModel:(AppointmentCoachTimeInfoModel *)appointInfoModel
{
    
    // 时间
    self.startTimeLabel.text = [self dealStringWithTime:_appointInfoModel.coursetime.begintime];
    
    // 14点结束
    self.finalTimeLabel.text = [NSString stringWithFormat:@"%@结束",[self dealStringWithTime:_appointInfoModel.coursetime.endtime]];
    
    // 剩余2个名额
    NSInteger keyueCount = [_appointInfoModel.coursestudentcount integerValue] - [_appointInfoModel.selectedstudentcount integerValue];
    self.remainingPersonLabel.text = [NSString stringWithFormat:@"剩余%ld个名额",(long)keyueCount];
    
    BOOL is_CotainMySelf = NO;
    
    for (NSString *string in _appointInfoModel.courseuser) {
        
        DYNSLog(@"string = %@",string);
        NSString *  userId = [[UserInfoModel defaultUserInfo] userID];

        if ([string isEqualToString:userId]) {
            is_CotainMySelf = YES;
        }
        
    }
    if (is_CotainMySelf){
        
        self.startTimeLabel.textColor = [UIColor blackColor];
        self.finalTimeLabel.textColor = [UIColor blackColor];
        self.remainingPersonLabel.textColor = MAINCOLOR;
        
    }else if (_appointInfoModel.coursestudentcount.intValue - _appointInfoModel.selectedstudentcount.intValue == 0) {
        
        self.startTimeLabel.textColor = TEXTGRAYCOLOR;
        self.finalTimeLabel.textColor = TEXTGRAYCOLOR;
        self.remainingPersonLabel.textColor = TEXTGRAYCOLOR;
        
    }else  {
        
        self.userInteractionEnabled = YES;
        
    }
   
    // 此方法判断当前时间是否大于预约的时间；
    [self isCellCanClick:_appointInfoModel.coursedate startTimeStr:_appointInfoModel.coursetime.begintime];
    
    if (is_CotainMySelf) {
        
        self.remainingPersonLabel.text = @"您已经预约";
        
    }else{
        
        NSInteger shengyuCount = _appointInfoModel.coursestudentcount.intValue - _appointInfoModel.selectedstudentcount.intValue;
        if (shengyuCount>0) {

            self.remainingPersonLabel.textColor = TEXTGRAYCOLOR;
        }else{
            self.userInteractionEnabled = YES;

            self.remainingPersonLabel.textColor = [UIColor blackColor];

        }
        
    }
}


- (void)setCoachTimeInfo:(AppointmentCoachTimeInfoModel *)coachTimeInfo
{
    _coachTimeInfo = coachTimeInfo;
    
    self.startTimeLabel.text = nil;
    self.finalTimeLabel.text = nil;
    self.remainingPersonLabel.text = nil;
   
    // 时间
    self.startTimeLabel.text = [self dealStringWithTime:_coachTimeInfo.coursetime.begintime];
    
    // 14点结束
    self.finalTimeLabel.text = [NSString stringWithFormat:@"%@结束",[self dealStringWithTime:_coachTimeInfo.coursetime.endtime]];
    
    // 剩余2个名额
    NSInteger keyueCount = [_coachTimeInfo.coursestudentcount integerValue] - [_coachTimeInfo.selectedstudentcount integerValue];
    self.remainingPersonLabel.text = [NSString stringWithFormat:@"剩余%ld个名额",(long)keyueCount];

    
    // 此方法判断当前时间是否大于预约的时间；
//    NSString *dateString = [NSString getHourLocalDateFormateUTCDate:_coachTimeInfo.coursedate];
    NSLog(@"_coachTimeInfo.coursedate:%@",_coachTimeInfo.coursedate);
    NSLog(@"_coachTimeInfo.coursetime.begintime:%@",_coachTimeInfo.coursetime.begintime);
    
    // coachTimeInfo.coursedate:2016-02-04T00:00:00.000Z
//                                2016-02-03T16:00:00.000Z
    // coachTimeInfo.coursetime.begintime:13:00:00
    [self isCellCanClick:_coachTimeInfo.coursedate startTimeStr:_coachTimeInfo.coursetime.begintime];

}

- (void)isCellCanClick:(NSString *)couresebegintimeStr startTimeStr:(NSString *)startTimeStr
{
    
    // 当前时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *datenow = [NSDate date];
    NSString *nowtimeStr = [formatter stringFromDate:datenow];//当前的时间 YYYY-MM-dd HH:mm:ss
    NSRange range = NSMakeRange(0, 10);
    NSString *nowTimeStr = [nowtimeStr substringWithRange:range];//当前的时间 YYYY-MM-dd
    NSString *appointTimeStr = [couresebegintimeStr substringWithRange:range];//预约课程的时间 YYYY-MM-dd
    
    if ([appointTimeStr isEqualToString:nowTimeStr]) {
        
        NSArray *indexArray= [startTimeStr componentsSeparatedByString:@":"];//课程开始的时间 hh:mm
        NSString *indexString = indexArray.firstObject;
        NSInteger startTime = indexString.integerValue;
        NSRange range = NSMakeRange(11,8);
        NSString *subNowTimeStr = [nowtimeStr substringWithRange:range];//现在的时间 HH:mm:ss
        NSArray *nowTimeArray= [subNowTimeStr componentsSeparatedByString:@":"];//课程开始的时间 hh:mm
        NSString *nowTimeStr = nowTimeArray.firstObject;
        NSInteger nowTime = nowTimeStr.integerValue;
        
        if (startTime <= nowTime) {// 开始时间小于当前时间
            
            NSInteger shengyuCount = _coachTimeInfo.coursestudentcount.intValue - _coachTimeInfo.selectedstudentcount.intValue;
            
            if (shengyuCount>0) {// 可预约
                
                self.userInteractionEnabled = YES;
                self.startTimeLabel.textColor = [UIColor blackColor];
                self.finalTimeLabel.textColor = [UIColor blackColor];
                
            }else{// 不可预约
                
                self.userInteractionEnabled = NO;
                self.startTimeLabel.textColor = [UIColor lightGrayColor];
                self.finalTimeLabel.textColor = [UIColor lightGrayColor];
                self.remainingPersonLabel.textColor = [UIColor lightGrayColor];
                
            }
            
        }else{// 开始时间大于当前时间
            
            self.userInteractionEnabled = NO;
            self.startTimeLabel.textColor = [UIColor lightGrayColor];
            self.finalTimeLabel.textColor = [UIColor lightGrayColor];
            self.remainingPersonLabel.textColor = [UIColor lightGrayColor];
            
        }
        
    }else{// 预约时间不等于当前时间
        
        NSLog(@"------------------------");
        self.userInteractionEnabled = NO;
        self.startTimeLabel.textColor = [UIColor lightGrayColor];
        self.finalTimeLabel.textColor = [UIColor lightGrayColor];
        self.remainingPersonLabel.textColor = [UIColor lightGrayColor];
        
    }
}

- (NSString *)dealStringWithTime:(NSString *)value {
    NSUInteger lenth = value.length;
    NSUInteger lastLenth = lenth-3;
    NSString *resultString = [value substringWithRange:NSMakeRange(0, lastLenth)];
    return resultString;
}
@end
