//
//  FDCalendarItem.h
//  FDCalendarDemo
//
//  Created by fergusding on 15/8/20.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,KCellStation){
    KCellStationLeft,
    KCellStationCenter,
    KCellStationRight
};

@protocol FDCalendarItemDelegate;

@interface FDCalendarItem : UIView

@property (strong, nonatomic) NSDate *seletedDate;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (weak, nonatomic) id<FDCalendarItemDelegate> delegate;

- (NSDate *)nextMonthDate;
- (NSDate *)previousMonthDate;

//// 获取date的下一天
//- (NSDate *)nextDayDate;
//// 获取date的前一天
//- (NSDate *)previousDayDate;

// 获得下个月第一天
- (NSDate *)getNextMonthFitstDate;
// 获得上个月最后一天
- (NSDate *)previousMonthLastDate;

/*
 *  当月预约时间
 */
@property (nonatomic , strong) NSArray *bookArray;
/*
 *  当月请假日期
 */
@property (nonatomic , strong) NSArray *restArray;
/*
 *  刷新界面
 */
- (void)reloadDate;
/*
 *  刷新界面
 */
- (void)changeDate;

@end

@protocol FDCalendarItemDelegate <NSObject>

- (void)calendarItem:(FDCalendarItem *)item didSelectedDate:(NSDate *)date;

@end
