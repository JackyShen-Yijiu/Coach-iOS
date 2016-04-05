//
//  YBFDCalendarItem.h
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

@protocol YBFDCalendarItemDelegate;

@interface YBFDCalendarItem : UIView

@property (strong, nonatomic) NSDate *seletedDate;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (weak, nonatomic) id<YBFDCalendarItemDelegate> delegate;

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

@protocol YBFDCalendarItemDelegate <NSObject>

- (void)YBCalendarItem:(YBFDCalendarItem *)item didSelectedDate:(NSDate *)date;

@end
