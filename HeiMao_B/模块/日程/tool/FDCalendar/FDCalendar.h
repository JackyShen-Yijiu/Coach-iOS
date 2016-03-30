//
//  FDCalendar.h
//  FDCalendarDemo
//
//  Created by fergusding on 15/8/20.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FDCalendar,FDCalendarItem;

@protocol FDCalendarDelegate <NSObject>
- (void)fdCalendar:(FDCalendar *)calendar didSelectedDate:(NSDate *)date;
@end
@interface FDCalendar : UIView

@property (strong, nonatomic) FDCalendarItem *centerCalendarItem;

- (instancetype)initWithCurrentDate:(NSDate *)date;

@property(nonatomic,weak)id<FDCalendarDelegate>delegate;

- (void)setCurrentDate:(NSDate *)date;
- (void)changeDate:(NSDate *)date;
- (void)changeDayDate:(NSDate *)date;

@property (nonatomic,strong) NSDate *selectDate;

@end
