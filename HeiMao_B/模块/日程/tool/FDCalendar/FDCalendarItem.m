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
    
    NSInteger firstWeekday = [self weekdayOfFirstDayInDate];
    
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    [fomatter setDateFormat:@"dd"];
    NSInteger dateStr = [[fomatter stringFromDate:self.seletedDate] integerValue] + firstWeekday;
    NSLog(@"reloadData dateStr:%ld",(long)dateStr);
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:dateStr inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
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
    
    if ([YBObjectTool compareMonthDateWithSelectDate:date]!=1) {
        return [dateStr integerValue] / 7 * self.collectionView.width;
    }else{
        return 0;
    }
    
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
// 获取下一天
- (NSDate *)nextDayDate {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = 1;
    NSDate *nextMonthDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self.seletedDate options:NSCalendarMatchStrictly];
    return nextMonthDate;
}
// 获取前一天
- (NSDate *)previousDayDate {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = -1;
    NSDate *previousMonthDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self.seletedDate options:NSCalendarMatchStrictly];
    return previousMonthDate;
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
    
    // 最多有31天、 展示5列数据 x 7天
    return 35;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CalendarCell";
    FDCalendarCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.dayLabel.textColor = [UIColor blackColor];
    cell.selectView.hidden = YES;
    
    NSInteger firstWeekday = [self weekdayOfFirstDayInDate];
    NSInteger totalDaysOfMonth = [self totalDaysInMonthOfDate:self.seletedDate];
    NSInteger totalDaysOfLastMonth = [self totalDaysInMonthOfDate:[self previousMonthDate]];
    
    // cell点击变色
    UIView* selectedBGView = [[UIView alloc] initWithFrame:cell.bounds];
    selectedBGView.backgroundColor = [UIColor clearColor];
    
    // 点击选中的圆圈
//    UIView *selVc = [[UIView alloc] initWithFrame:CGRectMake(cell.width/2-25/2,0,25,25)];
//    selVc.layer.masksToBounds = YES;
//    selVc.layer.cornerRadius = selVc.height / 2;
//    selVc.backgroundColor = RGB_Color(31, 124, 235);
//    [selectedBGView addSubview:selVc];
//    cell.selectedBackgroundView = selectedBGView;
    
    if (indexPath.row < firstWeekday) {// 小于这个月的第一天
        
        cell.userInteractionEnabled = NO;

        cell.dayLabel.textColor = [UIColor blackColor];
        cell.dayLabel.text = nil;
        cell.pointView.hidden = YES;
        cell.chineseDayLabel.hidden = YES;
        cell.restLabel.hidden = YES;
        cell.selectedBackgroundView = nil;

        //NSInteger day = totalDaysOfLastMonth - firstWeekday + indexPath.row + 1;
        //cell.dayLabel.text = [NSString stringWithFormat:@"%ld", day];
        //cell.dayLabel.textColor = [UIColor grayColor];
        //cell.chineseDayLabel.text = [self chineseCalendarOfDate:[self dateOfMonth:FDCalendarMonthPrevious WithDay:day]];
        
    } else if (indexPath.row >= totalDaysOfMonth + firstWeekday) {    // 大于这个月的最后一天
        
        cell.userInteractionEnabled = NO;

//        NSInteger day = indexPath.row - totalDaysOfMonth - firstWeekday + 1;
//        cell.dayLabel.text = [NSString stringWithFormat:@"%ld", day];
//        cell.dayLabel.textColor = [UIColor grayColor];
//        cell.chineseDayLabel.text = [self chineseCalendarOfDate:[self dateOfMonth:FDCalendarMonthNext WithDay:day]];
//
        cell.dayLabel.textColor = [UIColor blackColor];
        cell.dayLabel.text = nil;
        cell.pointView.hidden = YES;
        cell.chineseDayLabel.hidden = YES;
        cell.restLabel.hidden = YES;
        cell.selectedBackgroundView = nil;

    } else {// 属于当前选择的这个月
        
        cell.userInteractionEnabled = YES;

        NSInteger day = indexPath.row - firstWeekday + 1;
        
        cell.dayLabel.text= [NSString stringWithFormat:@"%ld", day];
        
        int compareDataNum = [YBObjectTool compareDateWithSelectDate:[self getCurrentData:indexPath]];
        if (compareDataNum==0) {// 当前
            
            cell.dayLabel.textColor = RGB_Color(31, 124, 235);
            cell.pointView.hidden = YES;
            
            BOOL isRest = [self isRest:self.restArray day:[cell.dayLabel.text integerValue]];
            if (isRest) {// 有休假
                cell.restLabel.hidden = NO;
                cell.pointView.hidden = YES;
            }else{// 未休假
                cell.restLabel.hidden = YES;
            }
            
        }else if (compareDataNum==1){// 大于当前日期
            
            cell.dayLabel.textColor = [UIColor blackColor];
            
        }else if (compareDataNum==-1){// 小于当前日期
            
            cell.dayLabel.textColor = [UIColor grayColor];
            
        }
        
        if ([self getCurrentData:indexPath] == self.seletedDate) {
            
            cell.dayLabel.textColor = [UIColor whiteColor];
            cell.selectView.hidden = NO;
            
        }
        
        if (compareDataNum!=0) {// 不是当前
            
            // 根据服务器返回数据判断是否休假
            if (self.restArray && [self.restArray count]!=0) {
                cell.restLabel.hidden = ![self isRest:self.restArray day:[cell.dayLabel.text integerValue]];
            }
            
        }
        
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
    
    self.seletedDate = selectedDate;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(calendarItem:didSelectedDate:)]) {
        [self.delegate calendarItem:self didSelectedDate:selectedDate];
    }
    
    self.selectIndex = indexPath.row;
    [self.collectionView reloadData];

}


@end
