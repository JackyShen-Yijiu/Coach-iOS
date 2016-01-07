//
//  FDCalendar.m
//  FDCalendarDemo
//
//  Created by fergusding on 15/8/20.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import "FDCalendar.h"
#import "FDCalendarItem.h"

#define Weekdays @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"]

static NSDateFormatter *dateFormattor;

@interface FDCalendar () <UIScrollViewDelegate, FDCalendarItemDelegate>

@property (strong, nonatomic) NSDate *date;

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) FDCalendarItem *leftCalendarItem;
@property (strong, nonatomic) FDCalendarItem *centerCalendarItem;
@property (strong, nonatomic) FDCalendarItem *rightCalendarItem;
@property (strong, nonatomic) UIDatePicker *datePicker;

@end

@implementation FDCalendar

- (instancetype)initWithCurrentDate:(NSDate *)date {
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.date = date;
        
        [self setupTitleBar];
        [self setupWeekHeader];
        [self setupCalendarItems];
        [self setupScrollView];
        [self setFrame:CGRectMake(0, 0, DeviceWidth, CGRectGetMaxY(self.scrollView.frame))];
        
        [self setCurrentDate:self.date];
    }
    return self;
}

#pragma mark - Private

- (NSString *)stringFromDate:(NSDate *)date {
    if (!dateFormattor) {
        dateFormattor = [[NSDateFormatter alloc] init];
        [dateFormattor setDateFormat:@"yyyy年M月"];
    }
    return [dateFormattor stringFromDate:date];
}

// 设置上层的titleBar
- (void)setupTitleBar {
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, ITEMHEIGTH)];
    titleView.backgroundColor = [UIColor whiteColor];
    [self addSubview:titleView];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((DeviceWidth - 150)/2.f, 0, 150, titleView.height)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:15.f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithRed:0x33/255.f green:0x33/255.f blue:0x33/255.f alpha:1];    
    [titleView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(titleLabel.left - 44, 10, 32, 24)];
    [leftButton setImage:[UIImage imageNamed:@"icon_previous"] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"icon_previous_h"] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(setPreviousMonthDate) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:leftButton];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(titleLabel.right + 20, 10, 32, 24)];
    [rightButton setImage:[UIImage imageNamed:@"icon_next"] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"icon_next_h"] forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(setNextMonthDate) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:rightButton];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, titleView.frame.size.height - .5, titleView.frame.size.width, .5)];
    lineView.backgroundColor = [UIColor colorWithRed:0xe6/255.f green:0xe6/255.f blue:0xe6/255.f alpha:1.f];
    [titleView addSubview:lineView];
    
}

// 设置星期文字的显示
- (void)setupWeekHeader {
    
    NSInteger count = [Weekdays count];
    
    CGFloat offsetX = 20.f;
    CGFloat width  = (DeviceWidth - offsetX * 2)/ count;
    
    for (int i = 0; i < count; i++) {
        UILabel *weekdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, ITEMHEIGTH, width, ITEMHEIGTH)];
        weekdayLabel.textAlignment = NSTextAlignmentCenter;
        weekdayLabel.text = Weekdays[i];
        weekdayLabel.font = [UIFont systemFontOfSize:10.f];
        weekdayLabel.textColor = [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1.f];
        
        [self addSubview:weekdayLabel];
        offsetX += weekdayLabel.frame.size.width;
    }
//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 46 * 2 - .5, DeviceWidth, .5)];
//    lineView.backgroundColor = [UIColor colorWithRed:0xe6/255.f green:0xe6/255.f blue:0xe6/255.f alpha:1.f];
//    [self addSubview:lineView];
}

// 设置包含日历的item的scrollView
- (void)setupScrollView {
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.scrollView setFrame:CGRectMake(0, ITEMHEIGTH + 30, DeviceWidth, self.centerCalendarItem.frame.size.height)];
    self.scrollView.contentSize = CGSizeMake(3 * self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    [self addSubview:self.scrollView];
}

// 设置3个日历的item
- (void)setupCalendarItems {
    
    self.scrollView = [[UIScrollView alloc] init];
    
    self.leftCalendarItem = [[FDCalendarItem alloc] init];
    [self.scrollView addSubview:self.leftCalendarItem];
    
    CGRect itemFrame = self.leftCalendarItem.frame;
    itemFrame.origin.x = DeviceWidth;
    self.centerCalendarItem = [[FDCalendarItem alloc] init];
    self.centerCalendarItem.frame = itemFrame;
    self.centerCalendarItem.delegate = self;
    [self.scrollView addSubview:self.centerCalendarItem];
    
    itemFrame.origin.x = DeviceWidth * 2;
    self.rightCalendarItem = [[FDCalendarItem alloc] init];
    self.rightCalendarItem.frame = itemFrame;
    [self.scrollView addSubview:self.rightCalendarItem];
    
}

// 设置当前日期，初始化
- (void)setCurrentDate:(NSDate *)date
{
    NSLog(@"设置当前日期，初始化");
    
    self.centerCalendarItem.date = date;
    
    self.leftCalendarItem.date = [self.centerCalendarItem previousMonthDate];
    
    self.rightCalendarItem.date = [self.centerCalendarItem nextMonthDate];
    
    // 设置顶部标题
    [self.titleLabel setText:[self stringFromDate:self.centerCalendarItem.date]];
   
    // 设置当前月份的预约、休假
    [self loadCurrentCalendarData:date];
    
}

- (void)loadCurrentCalendarData:(NSDate *)date
{
    NSLog(@"网络请求date.description:%@",date.description);
#warning 此处网络请求，然后传递数据
    
    self.centerCalendarItem.restStr = @"15";
    
    NSArray *bookArray = [NSArray arrayWithObjects:@"15",@"18",@"23",nil];
    self.centerCalendarItem.bookArray = bookArray;
    
    [self.centerCalendarItem reloadData];
    
}

// 重新加载日历items的数据
- (void)reloadCalendarItems
{
    CGPoint offset = self.scrollView.contentOffset;
    
    if (offset.x > self.scrollView.frame.size.width) {
        [self setNextMonthDate];
    } else {
        [self setPreviousMonthDate];
    }
    
}

#pragma mark - SEL

// 跳到上一个月
- (void)setPreviousMonthDate
{
    [self setCurrentDate:[self.centerCalendarItem previousMonthDate]];
}

// 跳到下一个月
- (void)setNextMonthDate {
    [self setCurrentDate:[self.centerCalendarItem nextMonthDate]];
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self reloadCalendarItems];
    
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    
}

#pragma mark - FDCalendarItemDelegate

- (void)calendarItem:(FDCalendarItem *)item didSelectedDate:(NSDate *)date
{
    
    NSLog(@"%s",__func__);
    
    self.date = date;
    self.centerCalendarItem.seletedDate = date;
    self.leftCalendarItem.seletedDate = date;
    self.rightCalendarItem.seletedDate = date;
    [self setCurrentDate:self.date];
    if ([_delegate respondsToSelector:@selector(fdCalendar:didSelectedDate:)]) {
        [_delegate fdCalendar:self didSelectedDate:self.date];
    }
    
}

@end
