//
//  FDCalendarItem.m
//  FDCalendarDemo
//
//  Created by fergusding on 15/8/20.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import "FDCalendarItem.h"
#import "YBObjectTool.h"
#import "FDCalendarCell.h"

#define CollectionViewHorizonMargin 0
#define CollectionViewVerticalMargin 0

typedef NS_ENUM(NSUInteger, FDCalendarMonth) {
    FDCalendarMonthPrevious = 0,
    FDCalendarMonthCurrent = 1,
    FDCalendarMonthNext = 2,
};

@interface FDCalendarItem () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic,assign) NSInteger selectIndex;
@end

@implementation FDCalendarItem

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        [self setupCollectionView];
        [self setFrame:CGRectMake(0, 0, DeviceWidth-30, calendarItemH)];
    }
    return self;
}

- (void)changeDate
{
    NSLog(@"reloadData.restArray:%@",self.restArray);
    NSLog(@"reloadData.bookArray:%@",self.bookArray);
    NSLog(@"self.seletedDate:%@",self.seletedDate);

    self.collectionView.contentOffset = CGPointMake([self getCurrentDataOffsetWithData:self.seletedDate], 0);

    [self.collectionView reloadData];
}

#pragma mark - Custom Accessors
- (void)reloadDate
{
    NSLog(@"reloadData.restArray:%@",self.restArray);
    NSLog(@"reloadData.bookArray:%@",self.bookArray);
    NSLog(@"self.seletedDate:%@",self.seletedDate);
  
    self.collectionView.contentOffset = CGPointMake([self getCurrentDataOffsetWithData:self.seletedDate], 0);
    
    [self.collectionView reloadData];
    
}

- (CGFloat)getCurrentDataOffsetWithData:(NSDate *)date
{
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    [fomatter setDateFormat:@"dd"];
    
    NSString *dateStr = [fomatter stringFromDate:date];

    NSLog(@"[YBObjectTool compareMonthDateWithSelectDate:date]:%d",[YBObjectTool compareMonthDateWithSelectDate:date]);
    
    NSInteger dayInDate = [self weekdayOfFirstDayInDate];
    NSLog(@"dateStr:%@ dayInDate:%ld [dateStr integerValue] / 7 * self.collectionView.width:%f",dateStr,(long)dayInDate,([dateStr integerValue]+dayInDate-1) / 7 * self.collectionView.width);
    
    return ([dateStr integerValue]+dayInDate-1) / 7 * self.collectionView.width;

}

// 获取date的下个月日期
- (NSDate *)nextMonthDate {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = 1;
    NSDate *nextMonthDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self.seletedDate options:NSCalendarMatchStrictly];
    return nextMonthDate;
}
// 获取date的上个月日期
- (NSDate *)previousMonthDate {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = -1;
    NSDate *previousMonthDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self.seletedDate options:NSCalendarMatchStrictly];
    return previousMonthDate;
}

// 获得下个月第一天
- (NSDate *)getNextMonthFitstDate{

    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    [fomatter setDateFormat:@"dd"];
    NSString *dateStr = [fomatter stringFromDate:self.seletedDate];
    
    NSInteger totleDays = [self totalDaysInMonthOfDate:self.seletedDate];
    NSLog(@"获得下个月第一天dateStr:%@ totleDays:%ld totleDays-[dateStr integerValue]:%ld",dateStr,(long)totleDays,totleDays - [dateStr integerValue]);
    
    // 获取date的下个月日期
    NSDateComponents *components = [[NSDateComponents alloc] init];
//    components.month = 1;
    components.day =  totleDays - [dateStr integerValue] + 1;
    NSDate *nextMonthDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self.seletedDate options:NSCalendarMatchStrictly];
    NSLog(@"获得下个月nextMonthDate:%@",nextMonthDate);
    
    return nextMonthDate;

}
// 获得上个月最后一天
- (NSDate *)previousMonthLastDate{

    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    [fomatter setDateFormat:@"dd"];
    NSString *dateStr = [fomatter stringFromDate:self.seletedDate];
    
    NSInteger totleDays = [self totalDaysInMonthOfDate:self.seletedDate];
    NSLog(@"获得上个月最后一天dateStr:%@ totleDays:%ld totleDays-[dateStr integerValue]:%ld",dateStr,(long)totleDays,totleDays - [dateStr integerValue]);
    
    // 获取date的下个月日期
    NSDateComponents *components = [[NSDateComponents alloc] init];
    //    components.month = 1;
    components.day = - [dateStr integerValue];
    NSDate *nextMonthDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self.seletedDate options:NSCalendarMatchStrictly];
    NSLog(@"获得上个月最后一天:%@",nextMonthDate);
    
    // 返回该月的第一天
    return nextMonthDate;
}


// collectionView显示日期单元，设置其属性
- (void)setupCollectionView
{
    CGFloat itemWidth = ((DeviceWidth-30) - CollectionViewHorizonMargin * 2) / 7;
    CGFloat itemHeight = calendarItemH;
    
    UICollectionViewFlowLayout *flowLayot = [[UICollectionViewFlowLayout alloc] init];
    flowLayot.sectionInset = UIEdgeInsetsZero;
    flowLayot.itemSize = CGSizeMake(itemWidth, itemHeight);
    flowLayot.minimumLineSpacing = 0;
    flowLayot.minimumInteritemSpacing = 0;
    //水平滑动
    flowLayot.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGRect collectionViewFrame = CGRectMake(CollectionViewHorizonMargin, CollectionViewVerticalMargin, DeviceWidth-30, itemHeight);
    self.collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:flowLayot];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.pagingEnabled = YES;
    [self.collectionView registerClass:[FDCalendarCell class] forCellWithReuseIdentifier:@"CalendarCell"];
    [self addSubview:self.collectionView];

}

// 获取date当前月的第一天是星期几
- (NSInteger)weekdayOfFirstDayInDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self.seletedDate];
    [components setDay:1];
    NSDate *firstDate = [calendar dateFromComponents:components];
    NSDateComponents *firstComponents = [calendar components:NSCalendarUnitWeekday fromDate:firstDate];
    return firstComponents.weekday - 1;
}

// 获取date当前月的总天数
- (NSInteger)totalDaysInMonthOfDate:(NSDate *)date {
    NSRange range = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}

// 获取某月day的日期
- (NSDate *)dateOfMonth:(FDCalendarMonth)calendarMonth WithDay:(NSInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date;
    
    switch (calendarMonth) {
        case FDCalendarMonthPrevious:
            date = [self previousMonthDate];
            break;
            
        case FDCalendarMonthCurrent:
            date = self.seletedDate;
            break;
            
        case FDCalendarMonthNext:
            date = [self nextMonthDate];
            break;
        default:
            break;
    }
    
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    [components setDay:day];
    NSDate *dateOfDay = [calendar dateFromComponents:components];
    
    return dateOfDay;
    
}

// 获取date当天的农历
- (NSString *)chineseCalendarOfDate:(NSDate *)date {
    
    NSString *day;
    NSCalendar *chineseCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *components = [chineseCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    if (components.day == 1) {
        day = ChineseMonths[components.month - 1];
    } else {
        day = ChineseDays[components.day - 1];
    }
    
    return day;
}

#pragma mark - UICollectionDatasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    // 最多有31天、 展示7列 * 5周
    return 35;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CalendarCell";
    FDCalendarCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.dayLabel.textColor = [UIColor blackColor];
    cell.selectView.hidden = YES;
    
    // 获取date当前月的第一天是星期几
    NSInteger firstWeekday = [self weekdayOfFirstDayInDate];
    // 获取date当前月的第一天是星期几
    NSInteger totalDaysOfMonth = [self totalDaysInMonthOfDate:self.seletedDate];
    //  获取date当前月的总天数
    NSInteger totalDaysOfLastMonth = [self totalDaysInMonthOfDate:[self previousMonthDate]];
    
    // cell点击变色
    UIView* selectedBGView = [[UIView alloc] initWithFrame:cell.bounds];
    selectedBGView.backgroundColor = [UIColor clearColor];
    
    if (indexPath.row < firstWeekday) {// 小于这个月的第一天

//        cell.dayLabel.text = nil;
//        cell.userInteractionEnabled = NO;
        
        cell.selectedBackgroundView = nil;

        NSInteger day = totalDaysOfLastMonth - firstWeekday + indexPath.row + 1;
        cell.dayLabel.text= [NSString stringWithFormat:@"%ld\n%ld", day,(long)indexPath.row];

        int compareDataNum = [YBObjectTool compareDateWithSelectDate:[self getCurrentData:indexPath]];
        if (compareDataNum==0) {// 当前
            
            cell.dayLabel.textColor = RGB_Color(31, 124, 235);

        }else if (compareDataNum==1){// 大于当前日期
            
            cell.dayLabel.textColor = [UIColor blackColor];
            
        }else if (compareDataNum==-1){// 小于当前日期
            
            cell.dayLabel.textColor = [UIColor grayColor];
            
        }
        
    } else if (indexPath.row >= totalDaysOfMonth + firstWeekday) {    // 大于这个月的最后一天
        
//        cell.dayLabel.text = nil;
//        cell.userInteractionEnabled = NO;

        NSInteger day = indexPath.row - totalDaysOfMonth - firstWeekday + 1;
        cell.dayLabel.text= [NSString stringWithFormat:@"%ld\n%ld", day,(long)indexPath.row];

        int compareDataNum = [YBObjectTool compareDateWithSelectDate:[self getCurrentData:indexPath]];
        if (compareDataNum==0) {// 当前
            
            cell.dayLabel.textColor = RGB_Color(31, 124, 235);

        }else if (compareDataNum==1){// 大于当前日期
            
            cell.dayLabel.textColor = [UIColor blackColor];
            
        }else if (compareDataNum==-1){// 小于当前日期
            
            cell.dayLabel.textColor = [UIColor grayColor];
            
        }

    } else {// 属于当前选择的这个月
        
        cell.userInteractionEnabled = YES;

        NSInteger day = indexPath.row - firstWeekday + 1;
        
        cell.dayLabel.text= [NSString stringWithFormat:@"%ld\n%ld", day,(long)indexPath.row];
        
        int compareDataNum = [YBObjectTool compareDateWithSelectDate:[self getCurrentData:indexPath]];
        if (compareDataNum==0) {// 当前
            
            cell.dayLabel.textColor = RGB_Color(31, 124, 235);
            
        }else if (compareDataNum==1){// 大于当前日期
            
            cell.dayLabel.textColor = [UIColor blackColor];
            
        }else if (compareDataNum==-1){// 小于当前日期
            
            cell.dayLabel.textColor = [UIColor grayColor];
            
        }
        
        if ([self getCurrentData:indexPath] == self.seletedDate) {
            
            cell.dayLabel.textColor = [UIColor whiteColor];
            cell.selectView.hidden = NO;
            
        }
        
//        if (compareDataNum!=0) {// 不是当前
//            
//            // 根据服务器返回数据判断是否休假
//            if (self.restArray && [self.restArray count]!=0) {
//                cell.restLabel.hidden = ![self isRest:self.restArray day:[cell.dayLabel.text integerValue]];
//            }
//            
//        }
        
        // 红点
        //        NSDate *curDate = [self dateOfMonth:FDCalendarMonthCurrent WithDay:day];
        //        BOOL isSelectedData = [self isEnqual:curDate :self.seletedDate];
        //        [cell setIsSeletedDay:isSelectedData curDay:[self isEnqual:curDate :[NSDate date]]];
        //
        // 根据服务器返回数据判断是否预约
        //        if (self.bookArray && [self.bookArray count]!=0) {
        //            cell.pointView.hidden = ![self isBook:self.bookArray day:[cell.dayLabel.text integerValue]];
        //        }
        
    }
    
//    if (indexPath.row % 7 == 0) {
//        cell.station = KCellStationLeft;
//    }else if (indexPath.row % 7 == 6){
//        cell.station = KCellStationRight;
//    }else{
//        cell.station = KCellStationCenter;
//    }
    
    return cell;
}

// 根据item获取日期
- (NSDate *)getCurrentData:(NSIndexPath *)indexPath
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self.seletedDate];
    
    NSInteger firstWeekday = [self weekdayOfFirstDayInDate];
    
    [components setDay:indexPath.row - firstWeekday + 1];
    
    NSDate *selectedDate = [[NSCalendar currentCalendar] dateFromComponents:components];
    
    return selectedDate;
    
}

- (BOOL)isRest:(NSArray *)restArray day:(NSInteger)day
{
    
    if (restArray && restArray.count>0) {// 休假
        
        return [restArray containsObject:@(day)];
        
    }else{// 未休假
        
        return NO;
        
    }
    
}

- (BOOL)isBook:(NSArray *)bookArray day:(NSInteger)day
{
    
    if (bookArray && bookArray.count>0) {// 有预约
        
       return [bookArray containsObject:@(day)];
        
    }else{// 没有预约
        
        return NO;
        
    }
    
}

- (BOOL)isEnqual:(NSDate *)date1 :(NSDate *)date2
{
    if(!date1 || !date2) return NO;
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date1];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date2];
    return (components1.year == components2.year) && (components1.month == components2.month) && (components1.day == components2.day);
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self.seletedDate];
    
    NSInteger firstWeekday = [self weekdayOfFirstDayInDate];
    
    [components setDay:indexPath.row - firstWeekday + 1];
    
    NSDate *selectedDate = [[NSCalendar currentCalendar] dateFromComponents:components];
    NSLog(@"didSelectItemAtIndexPath selectedDate:%@",selectedDate);
    
//    self.seletedDate = selectedDate;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(calendarItem:didSelectedDate:)]) {
        [self.delegate calendarItem:self didSelectedDate:selectedDate];
    }
    
    self.selectIndex = indexPath.row;
    [self changeDate];
//    [self.collectionView reloadData];

}


@end
