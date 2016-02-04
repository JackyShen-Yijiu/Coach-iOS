//
//  FDCalendarItem.h
//  FDCalendarDemo
//
//  Created by fergusding on 15/8/20.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DeviceWidth [UIScreen mainScreen].bounds.size.width

// 顶部标题高度
#define ITEMHEIGTH 30.F
// 日期高度
#define calendarItemH 65

typedef NS_ENUM(NSInteger,KCellStation){
    KCellStationLeft,
    KCellStationCenter,
    KCellStationRight
};

@protocol FDCalendarItemDelegate;

@interface FDCalendarItem : UIView

@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSDate *seletedDate;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (weak, nonatomic) id<FDCalendarItemDelegate> delegate;

- (NSDate *)nextMonthDate;
- (NSDate *)previousMonthDate;

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
- (void)reloadData;

@end

@protocol FDCalendarItemDelegate <NSObject>

- (void)calendarItem:(FDCalendarItem *)item didSelectedDate:(NSDate *)date;

@end
