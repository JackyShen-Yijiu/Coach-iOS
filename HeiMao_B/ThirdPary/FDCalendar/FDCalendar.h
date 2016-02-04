//
//  FDCalendar.h
//  FDCalendarDemo
//
//  Created by fergusding on 15/8/20.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FDCalendar;
@protocol FDCalendarDelegate <NSObject>
- (void)fdCalendar:(FDCalendar *)calendar didSelectedDate:(NSDate *)date;
@end
@interface FDCalendar : UIView

- (instancetype)initWithCurrentDate:(NSDate *)date;

@property(nonatomic,weak)id<FDCalendarDelegate>delegate;

- (void)setCurrentDate:(NSDate *)date;

@end
