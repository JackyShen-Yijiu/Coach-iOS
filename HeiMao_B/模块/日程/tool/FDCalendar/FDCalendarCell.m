//
//  FDCalendarCell.m
//  HeiMao_B
//
//  Created by JiangangYang on 16/3/26.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "FDCalendarCell.h"

@interface FDCalendarCell ()

@end

@implementation FDCalendarCell

{
    UIView *_selectView;
    UILabel *_dayLabel;
    UILabel *_chineseDayLabel;
    UIView *_pointView;
    UIView * _lineView;
    UILabel *_restLabel;
    
}

// 日期
- (UILabel *)dayLabel {
    if (!_dayLabel) {
        _dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width/2-10, 5, 20, 15)];
        _dayLabel.textAlignment = NSTextAlignmentCenter;
        _dayLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_dayLabel];
    }
    return _dayLabel;
}
// 农历
- (UILabel *)chineseDayLabel {
    if (!_chineseDayLabel) {
        _chineseDayLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width/2-10, calendarItemH-10*2.5, 20, 10)];
        _chineseDayLabel.textAlignment = NSTextAlignmentCenter;
        _chineseDayLabel.font = [UIFont boldSystemFontOfSize:9];
        _chineseDayLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:_chineseDayLabel];
    }
    return _chineseDayLabel;
}
// 预约蓝色点
- (UIView *)pointView
{
    if (!_pointView) {
        _pointView = [[UIView alloc] init];
        _pointView.backgroundColor =  RGB_Color(31, 124, 235);
        _pointView.frame = CGRectMake(_chineseDayLabel.center.x-2,calendarItemH/2-2, 4, 4);
        _pointView.layer.masksToBounds = YES;
        [_pointView setHidden:YES];
        _pointView.layer.cornerRadius = _pointView.size.width/2.f;
        [self addSubview:_pointView];
    }
    return _pointView;
}
// 休息
- (UILabel *)restLabel {
    
    if (!_restLabel) {
        _restLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width/2-15/2, calendarItemH/2-15/2, 15, 15)];
        _restLabel.textAlignment = NSTextAlignmentCenter;
        _restLabel.font = [UIFont systemFontOfSize:8];
        _restLabel.backgroundColor = [UIColor clearColor];
        _restLabel.textColor = [UIColor lightGrayColor];
        _restLabel.text = @"休";
        _restLabel.hidden = YES;
        [self addSubview:_restLabel];
    }
    return _restLabel;
}
// 选择的圈圈
- (UIView *)selectView
{
    if (!_selectView) {
        _selectView = [[UIView alloc] init];
        _selectView.frame = CGRectMake(self.width/2-25/2,0,25,25);
        _selectView.layer.masksToBounds = YES;
        _selectView.backgroundColor = RGB_Color(31, 124, 235);
        _selectView.layer.cornerRadius = _selectView.size.width/2.f;
        [self insertSubview:_selectView belowSubview:self.contentView];
    }
    return _selectView;
}

- (UIView*)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor colorWithRed:0xe6/255.f green:0xe6/255.f blue:0xe6/255.f alpha:1.f];
        [self addSubview:_lineView];
    }
    return _lineView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
   
    [self pointView].center = CGPointMake(self.width/2.f, self.height/2-2);
}

- (void)setIsSeletedDay:(BOOL)isSeletedDay curDay:(BOOL)isCurDay
{
    
    // 在此处判断是否需要显示红点
    // 如果是预约的就显示红点
    [[self pointView] setHidden:isCurDay];
    
}

@end
