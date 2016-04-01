//
//  FDCalendar.m
//  FDCalendarDemo
//
//  Created by fergusding on 15/8/20.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import "FDCalendar.h"
#import "FDCalendarItem.h"
#import "BaseModelMethod.h"
#import "UIViewController+Method.h"

static NSDateFormatter *dateFormattor;

@interface FDCalendar () <UIScrollViewDelegate, FDCalendarItemDelegate>
{
    CGFloat startContentOffsetX;
    CGFloat willEndContentOffsetX;
    CGFloat endContentOffsetX;
}
@property (strong, nonatomic) NSDate *date;

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) FDCalendarItem *leftCalendarItem;
@property (strong, nonatomic) FDCalendarItem *rightCalendarItem;
@property (strong, nonatomic) UIDatePicker *datePicker;

@property(nonatomic,strong)NSDateFormatter *dateFormattor;

@end

@implementation FDCalendar

- (instancetype)initWithCurrentDate:(NSDate *)date {
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.date = date;
        
        // 星期
        [self setupWeekHeader];
        
        // 滚动视图、三个日历
        [self setupCalendarItems];
        
        // 设置滚动视图
        [self setupScrollView];
        
        [self setFrame:CGRectMake(0, 0, DeviceWidth, CGRectGetMaxY(self.scrollView.frame))];
        
        // 初始化日期
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

// 设置星期文字的显示
- (void)setupWeekHeader {
    
    UIView *weekTitleView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, DeviceWidth-30, ITEMHEIGTH)];
    weekTitleView.backgroundColor = RGB_Color(254, 254, 254);
    [self addSubview:weekTitleView];
    
    NSInteger count = [Weekdays count];
    
    CGFloat offsetX = 0;
    CGFloat width  = (weekTitleView.width - offsetX * 2)/ count;
    
    for (int i = 0; i < count; i++) {
        
        UILabel *weekdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, 0, width, ITEMHEIGTH)];
        weekdayLabel.textAlignment = NSTextAlignmentCenter;
        weekdayLabel.text = Weekdays[i];
        weekdayLabel.font = [UIFont systemFontOfSize:10.f];
        weekdayLabel.textColor = [UIColor lightGrayColor];
        weekdayLabel.backgroundColor = [UIColor clearColor];
        
        [weekTitleView addSubview:weekdayLabel];
        offsetX += weekdayLabel.frame.size.width;
        
    }
    
}

// 设置包含日历的item的scrollView
- (void)setupScrollView
{
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = YES;
    [self.scrollView setFrame:CGRectMake(15, ITEMHEIGTH, DeviceWidth-30, self.centerCalendarItem.frame.size.height)];
    self.scrollView.contentSize = CGSizeMake(3 * self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    [self addSubview:self.scrollView];
    
}

// 设置3个日历的item
- (void)setupCalendarItems {
    
    self.scrollView = [[UIScrollView alloc] init];
    
    self.leftCalendarItem = [[FDCalendarItem alloc] init];
    self.leftCalendarItem.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.leftCalendarItem];
    
    self.centerCalendarItem = [[FDCalendarItem alloc] init];
    CGRect itemFrame = self.leftCalendarItem.frame;
    itemFrame.origin.x = DeviceWidth-30;
    self.centerCalendarItem.frame = itemFrame;
    self.centerCalendarItem.delegate = self;
    self.centerCalendarItem.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.centerCalendarItem];
    
    self.rightCalendarItem = [[FDCalendarItem alloc] init];
    itemFrame.origin.x = (DeviceWidth-30) * 2;
    self.rightCalendarItem.frame = itemFrame;
    self.rightCalendarItem.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.rightCalendarItem];
    
}

- (void)changeDayDate:(NSDate *)date
{
    self.centerCalendarItem.seletedDate = date;
    
    self.leftCalendarItem.seletedDate = [self.centerCalendarItem previousDayDate];
    
    self.rightCalendarItem.seletedDate = [self.centerCalendarItem nextDayDate];
    
    if ([_delegate respondsToSelector:@selector(fdCalendar:didSelectedDate:)]) {
        [_delegate fdCalendar:self didSelectedDate:self.centerCalendarItem.seletedDate];
    }
    
    [self.centerCalendarItem reloadDate];

}

- (void)changeDate:(NSDate *)date
{
    NSLog(@"设置当前日期，初始化setCurrentDate");
    
    self.centerCalendarItem.seletedDate = date;
    
    self.leftCalendarItem.seletedDate = [self.centerCalendarItem previousMonthDate];
    
    self.rightCalendarItem.seletedDate = [self.centerCalendarItem nextMonthDate];
    
    [self.centerCalendarItem changeDate];

}

// 设置当前日期，初始化
- (void)setCurrentDate:(NSDate *)date
{
    NSLog(@"设置当前日期，初始化setCurrentDate date:%@",date);
    
    self.centerCalendarItem.seletedDate = date;
    
    self.leftCalendarItem.seletedDate = [self.centerCalendarItem previousMonthDate];
    
    self.rightCalendarItem.seletedDate = [self.centerCalendarItem nextMonthDate];
    
    if ([_delegate respondsToSelector:@selector(fdCalendar:didSelectedDate:)]) {
        [_delegate fdCalendar:self didSelectedDate:self.centerCalendarItem.seletedDate];
    }
    
    [self.centerCalendarItem reloadDate];

    // 设置当前月份的预约、休假
    //[self loadCurrentCalendarData:date];
    
}

- (void)loadCurrentCalendarData:(NSDate *)date
{
    NSLog(@"设置当前月份的预约、休假 网络请求 date.description:%@",date.description);
    
    if (!self.dateFormattor) {
        self.dateFormattor = [[NSDateFormatter alloc] init];
    }
    // 年
    [self.dateFormattor setDateFormat:@"yyyy"];
    NSString * yearStr = [self.dateFormattor stringFromDate:date];
    // 月
    [self.dateFormattor setDateFormat:@"M"];
    NSString * monthStr = [self.dateFormattor stringFromDate:date];

    NSString *  userId = [[UserInfoModel defaultUserInfo] userID];
    
    WS(ws);
    [NetWorkEntiry getAllCourseInfoWithUserId:userId yearTime:yearStr monthTime:monthStr success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"刷新日历：responseObject:%@",responseObject);
        
        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        
        if (type == 1) {
            
            NSDictionary *array = responseObject[@"data"];
            
            // 休假
            NSArray *leaveoff = [array objectForKey:@"leaveoff"];
            // 预约
            NSArray *reservationapply = [array objectForKey:@"reservationapply"];

            dispatch_async(dispatch_get_main_queue(), ^{

                ws.centerCalendarItem.restArray = leaveoff;
                
                ws.centerCalendarItem.bookArray = reservationapply;
                
                [ws.centerCalendarItem reloadDate];
                
            });
           
        }else{
            
            NSLog(@"%@",responseObject[@"msg"]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{    //拖动前的起始坐标
    
    startContentOffsetX = scrollView.contentOffset.x;
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{    //将要停止前的坐标
    
    willEndContentOffsetX = scrollView.contentOffset.x;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    endContentOffsetX = scrollView.contentOffset.x;
    
    if (endContentOffsetX < willEndContentOffsetX && willEndContentOffsetX < startContentOffsetX) { // 画面从右往左移动，前一页
        [self setPreviousMonthDate];
        NSLog(@"画面从右往左移动，前一页");
    } else if (endContentOffsetX > willEndContentOffsetX && willEndContentOffsetX > startContentOffsetX) {// 画面从左往右移动，后一页
        [self setNextMonthDate];
        NSLog(@"画面从左往右移动，后一页");
    }
    
    // 重置
    self.scrollView.contentOffset = CGPointMake(self.scrollView.width, 0);
    
}

// 跳到上一个月
- (void)setPreviousMonthDate
{
//    [self setCurrentDate:[self.centerCalendarItem previousMonthDate]];
    [self setCurrentDate:[self.centerCalendarItem previousDayDate]];
}
// 跳到下一个月
- (void)setNextMonthDate {
//    [self setCurrentDate:[self.centerCalendarItem nextMonthDate]];
    [self setCurrentDate:[self.centerCalendarItem nextDayDate]];
}

- (void)calendarItem:(FDCalendarItem *)item didSelectedDate:(NSDate *)date
{
    
    NSLog(@"%s date:%@",__func__,date);
    
    self.date = date;
    self.centerCalendarItem.seletedDate = date;
    self.leftCalendarItem.seletedDate = date;
    self.rightCalendarItem.seletedDate = date;
    
    // 设置当前日期，初始化
//    [self setCurrentDate:self.date];
    
    // 刷新控制器底部数据
    if ([_delegate respondsToSelector:@selector(fdCalendar:didSelectedDate:)]) {
        [_delegate fdCalendar:self didSelectedDate:self.date];
    }
    
}

@end
