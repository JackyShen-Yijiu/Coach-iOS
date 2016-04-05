//
//  YBFDCalendar.h
//  YBFDCalendarDemo
//
//  Created by fergusding on 15/8/20.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YBFDCalendar;
@protocol YBFDCalendarDelegate <NSObject>
- (void)YBFDCalendar:(YBFDCalendar *)calendar didSelectedDate:(NSDate *)date;
@end
@interface YBFDCalendar : UIView

- (instancetype)initWithCurrentDate:(NSDate *)date;

@property(nonatomic,weak)id<YBFDCalendarDelegate>delegate;

- (void)setCurrentDate:(NSDate *)date;

@property (nonatomic,strong) NSDate *selectDate;

@end
