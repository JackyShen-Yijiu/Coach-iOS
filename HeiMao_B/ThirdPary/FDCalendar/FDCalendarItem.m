//
//  FDCalendarItem.m
//  FDCalendarDemo
//
//  Created by fergusding on 15/8/20.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//


#import "FDCalendarItem.h"

@interface FDCalendarCell : UICollectionViewCell
@property(nonatomic,assign)KCellStation station;

- (UILabel *)dayLabel;
//- (UILabel *)chineseDayLabel;
- (UIView *)lineView;


@end

@implementation FDCalendarCell {
    UILabel *_dayLabel;
    UIView * _lineView;
    UIView * _maskView;
    UIView * _pointView;
}

- (UILabel *)dayLabel {
    if (!_dayLabel) {
        _dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _dayLabel.textAlignment = NSTextAlignmentCenter;
        _dayLabel.backgroundColor = [UIColor clearColor];
        _dayLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_dayLabel];
    }
    return _dayLabel;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.dayLabel.frame = self.bounds;
    switch (self.station) {
        case KCellStationCenter:
            self.lineView.frame = CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5f);
            break;
        case KCellStationLeft:
           self.lineView.frame = CGRectMake(-20, self.frame.size.height - 0.5, self.frame.size.width + 20, 0.5f);
            break;
        case KCellStationRight:
           self.lineView.frame = CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width + 20, 0.5f);
            break;
    }
    self.maskView.center = CGPointMake(self.width/2.f, self.height/2.f);
    [self pointView].center = CGPointMake(self.width/2.f, self.height/2.f + 12);
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

- (void)setIsSeletedDay:(BOOL)isSeletedDay curDay:(BOOL)isCurDay
{
    
    [[self pointView] setHidden:isCurDay];
    if (isCurDay) {
        self.dayLabel.textColor = isCurDay ? RGB_Color(40, 121, 243) : [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1.f];
        if (isSeletedDay) {
            [self.maskView setHidden:NO];
            [[self pointView] setHidden:YES];
            self.dayLabel.textColor = [UIColor whiteColor];
        }else{
            [self.maskView setHidden:YES];
            [[self pointView] setHidden:NO];
            self.dayLabel.textColor = RGB_Color(40, 121, 243);
        }
    }else{
        if (isSeletedDay) {
            [self.maskView setHidden:NO];
            [[self pointView] setHidden:YES];
            self.dayLabel.textColor = [UIColor whiteColor];
        }else{
            [self.maskView setHidden:YES];
            [[self pointView] setHidden:YES];
            self.dayLabel.textColor = [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1.f];
        }
        
    }
}

- (UIView *)maskView
{
    if (!_maskView) {
        _maskView = [[UIView alloc] init];
        _maskView.backgroundColor =  RGB_Color(40, 121, 243);
        _maskView.center = CGPointMake(self.width/2.f, self.height/2.f);
        _maskView.size = CGSizeMake(30, 30);
        [_maskView setHidden:YES];
        _maskView.layer.cornerRadius = _maskView.size.width/2.f;
        [self addSubview:_maskView];
    }
    [self sendSubviewToBack:_maskView];
    return _maskView;
}

- (UIView *)pointView
{
    if (!_pointView) {
        _pointView = [[UIView alloc] init];
        _pointView.backgroundColor =  RGB_Color(40, 121, 243);
        _pointView.center = CGPointMake(self.width/2.f, self.height/2.f + 10);
        _pointView.size = CGSizeMake(4, 4);
        _pointView.layer.masksToBounds = YES;
        [_pointView setHidden:YES];
        _pointView.layer.cornerRadius = _pointView.size.width/2.f;
    }
    [self insertSubview:_pointView aboveSubview:self.dayLabel];
    return _pointView;
}

@end

#define CollectionViewHorizonMargin 0
#define CollectionViewVerticalMargin 0

#define ChineseMonths @[@"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",@"九月", @"十月", @"冬月", @"腊月"]
#define ChineseDays @[@"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",@"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十", @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十"]

typedef NS_ENUM(NSUInteger, FDCalendarMonth) {
    FDCalendarMonthPrevious = 0,
    FDCalendarMonthCurrent = 1,
    FDCalendarMonthNext = 2,
};

@interface FDCalendarItem () <UICollectionViewDataSource, UICollectionViewDelegate>


@end

@implementation FDCalendarItem

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        [self setupCollectionView];
        [self setFrame:CGRectMake(0, 0, DeviceWidth, self.collectionView.frame.size.height + CollectionViewVerticalMargin * 2)];
    }
    return self;
}

#pragma mark - Custom Accessors

- (void)setDate:(NSDate *)date {
    _date = date;
    [self.collectionView reloadData];
}

#pragma mark - Public 

// 获取date的下个月日期
- (NSDate *)nextMonthDate {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = 1;
    NSDate *nextMonthDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self.date options:NSCalendarMatchStrictly];
    return nextMonthDate;
}

// 获取date的上个月日期
- (NSDate *)previousMonthDate {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = -1;
    NSDate *previousMonthDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self.date options:NSCalendarMatchStrictly];
    return previousMonthDate;
}

#pragma mark - Private

// collectionView显示日期单元，设置其属性
- (void)setupCollectionView {
    CGFloat itemWidth = (DeviceWidth - 40.f) / 7;
    CGFloat itemHeight = 40.f;
    
    UICollectionViewFlowLayout *flowLayot = [[UICollectionViewFlowLayout alloc] init];
    flowLayot.sectionInset = UIEdgeInsetsZero;
    flowLayot.itemSize = CGSizeMake(itemWidth, itemHeight);
    flowLayot.minimumLineSpacing = 0;
    flowLayot.minimumInteritemSpacing = 0;
    
    CGRect collectionViewFrame = CGRectMake(CollectionViewHorizonMargin, CollectionViewVerticalMargin, DeviceWidth, itemHeight * 6);
    self.collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:flowLayot];
    self.collectionView.contentInset  = UIEdgeInsetsMake(0, 20, 0, 20);
    [self addSubview:self.collectionView];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.scrollEnabled = NO;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[FDCalendarCell class] forCellWithReuseIdentifier:@"CalendarCell"];
}

// 获取date当前月的第一天是星期几
- (NSInteger)weekdayOfFirstDayInDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self.date];
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
            date = self.date;
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
    return 46;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"CalendarCell";
    FDCalendarCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.dayLabel.textColor = [UIColor blackColor];
//    cell.chineseDayLabel.textColor = [UIColor grayColor];
    NSInteger firstWeekday = [self weekdayOfFirstDayInDate];
    NSInteger totalDaysOfMonth = [self totalDaysInMonthOfDate:self.date];
//    NSInteger totalDaysOfLastMonth = [self totalDaysInMonthOfDate:[self previousMonthDate]];
    
    
    NSDate * curDate = nil;
    if (indexPath.row < firstWeekday) {    // 小于这个月的第一天
        cell.dayLabel.text = nil;
        [cell setIsSeletedDay:NO curDay:NO];
//        NSInteger day = totalDaysOfLastMonth - firstWeekday + indexPath.row + 1;
//        cell.dayLabel.text = [NSString stringWithFormat:@"%ld", day];
//        cell.dayLabel.textColor = [UIColor grayColor];
//        curDate = [self dateOfMonth:FDCalendarMonthPrevious WithDay:day];
    } else if (indexPath.row >= totalDaysOfMonth + firstWeekday) {    // 大于这个月的最后一天
//        [cell setIsCurDay:NO];
//        NSInteger day = indexPath.row - totalDaysOfMonth - firstWeekday + 1;
//        cell.dayLabel.text = [NSString stringWithFormat:@"%ld", day];
//        cell.dayLabel.textColor = [UIColor grayColor];
//        curDate = [self dateOfMonth:FDCalendarMonthNext WithDay:day];
//        if ([curDate isEqualToDate:[NSDate date]]) {
//            [cell setIsCurDay:YES];
//        }
        cell.dayLabel.text = nil;
        [cell setIsSeletedDay:NO curDay:NO];
    } else {    // 属于这个月
        NSInteger day = indexPath.row - firstWeekday + 1;
        cell.dayLabel.text= [NSString stringWithFormat:@"%ld", day];
        
        if (day == [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:self.date]) {
            cell.backgroundColor = [UIColor clearColor];
            cell.layer.cornerRadius = cell.frame.size.height / 2;
            cell.dayLabel.textColor = [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1.f];
        }
        curDate = [self dateOfMonth:FDCalendarMonthCurrent WithDay:day];
        BOOL isSeletedDaya = [self isEnqual:curDate : self.seletedDate];
        [cell setIsSeletedDay:isSeletedDaya curDay:[self isEnqual:curDate :[NSDate date]]];
    }
    
    if (indexPath.row % 7 == 0) {
        cell.station = KCellStationLeft;
    }else if (indexPath.row % 7 == 6){
        cell.station = KCellStationRight;
    }else{
        cell.station = KCellStationCenter;
    }
    
    return cell;
}

- (BOOL)isEnqual:(NSDate *)date1 :(NSDate *)date2
{
    if(!date1 || !date2) return NO;
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date1];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date2];
    return (components1.year == components2.year) && (components1.month == components2.month) && (components1.day == components2.day);
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FDCalendarCell * cell = (FDCalendarCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (!cell.dayLabel.text) {
        return;
    }
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self.date];
    NSInteger firstWeekday = [self weekdayOfFirstDayInDate];
    [components setDay:indexPath.row - firstWeekday + 1];
    NSDate *selectedDate = [[NSCalendar currentCalendar] dateFromComponents:components];
    if (self.delegate && [self.delegate respondsToSelector:@selector(calendarItem:didSelectedDate:)]) {
        [self.delegate calendarItem:self didSelectedDate:selectedDate];
    }
}


@end
