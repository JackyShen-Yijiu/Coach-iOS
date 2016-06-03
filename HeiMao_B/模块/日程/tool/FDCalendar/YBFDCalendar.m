//
//  YBFDCalendar.m
//  YBFDCalendarDemo
//
//  Created by fergusding on 15/8/20.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import "YBFDCalendar.h"
#import "YBFDCalendarItem.h"
#import "BaseModelMethod.h"
#import "UIViewController+Method.h"

static NSDateFormatter *dateFormattor;

@interface YBFDCalendar () <UIScrollViewDelegate, YBFDCalendarItemDelegate>
{
    CGFloat startContentOffsetX;
    CGFloat willEndContentOffsetX;
    CGFloat endContentOffsetX;
}
@property (strong, nonatomic) NSDate *date;

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) YBFDCalendarItem *calendarItem;
@property (strong, nonatomic) UIDatePicker *datePicker;

@property(nonatomic,strong) NSDateFormatter *dateFormattor;

@property (nonatomic,strong) UIView *weekTitleView;

@end

@implementation YBFDCalendar

- (instancetype)initWithCurrentDate:(NSDate *)date {
    if (self = [super init]) {
        
        self.backgroundColor = RGB_Color(255, 255, 255);
        
        self.date = date;
        
        // 顶部切换
        [self setUpTopChangeBtn];
        
        // 星期
        [self setupWeekHeader];
        
        // 滚动视图、三个日历
        [self setupCalendarItems];
        
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

- (void)setUpTopChangeBtn
{

    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame = CGRectMake(15+(DeviceWidth-30)/2-80/2, 0, 80, topTitleH);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:12.f];
    self.titleLabel.textColor = RGB_Color(31, 124, 235);
    self.titleLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.titleLabel];
    
    NSArray *imgArray = [NSArray arrayWithObjects:@"JZCoursetriangle_left",@"JZCoursetriangle_right",nil];
    
    for (int i = 0; i<2; i++) {
        
        UIButton *btn = [[UIButton alloc] init];
        
        CGFloat btnX = self.titleLabel.frame.origin.x - 32;
        if (i==1) {
            btnX = CGRectGetMaxX(self.titleLabel.frame);
        }
        btn.frame = CGRectMake(btnX, -3, 32, 32);
        btn.tag = 100 + i;
        btn.backgroundColor = [UIColor clearColor];
        [btn setBackgroundImage:[UIImage imageNamed:imgArray[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(changeBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
    }
    
}

- (void)changeBtnDidClick:(UIButton *)btn
{
    if (btn.tag==100) {
        [self setPreviousMonthDate];
    }else{
        [self setNextMonthDate];
    }
}

// 设置星期文字的显示
- (void)setupWeekHeader {
    
    self.weekTitleView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.titleLabel.frame), DeviceWidth-30, ITEMHEIGTH)];
    self.weekTitleView.backgroundColor = RGB_Color(254, 254, 254);
    [self addSubview:self.weekTitleView];
    
    NSInteger count = [Weekdays count];
    
    CGFloat offsetX = 0;
    CGFloat width  = (self.weekTitleView.width - offsetX * 2)/ count;
    
    for (int i = 0; i < count; i++) {
        
        UILabel *weekdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, 0, width, ITEMHEIGTH)];
        weekdayLabel.textAlignment = NSTextAlignmentCenter;
        weekdayLabel.text = Weekdays[i];
        weekdayLabel.font = [UIFont systemFontOfSize:10.f];
        weekdayLabel.textColor = [UIColor lightGrayColor];
        weekdayLabel.backgroundColor = [UIColor clearColor];
        
        [self.weekTitleView addSubview:weekdayLabel];
        offsetX += weekdayLabel.frame.size.width;
        
    }
    
}

// 设置3个日历的item
- (void)setupCalendarItems {
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = YES;
    [self.scrollView setFrame:CGRectMake(15, CGRectGetMaxY(self.weekTitleView.frame), DeviceWidth-30, YBFDCalendarH-CGRectGetMaxY(self.weekTitleView.frame))];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    [self addSubview:self.scrollView];
    self.scrollView.backgroundColor = [UIColor clearColor];
    
    self.calendarItem = [[YBFDCalendarItem alloc] init];
    self.calendarItem.delegate = self;
    self.calendarItem.frame = self.scrollView.bounds;
    [self.scrollView addSubview:self.calendarItem];
    
}

- (void)setSelectDate:(NSDate *)selectDate
{
    self.calendarItem.seletedDate = selectDate;
    
    // 设置顶部标题
    [self.titleLabel setText:[self stringFromDate:self.calendarItem.seletedDate]];
    
    [self.calendarItem reloadData];

}

// 设置当前日期，初始化
- (void)setCurrentDate:(NSDate *)date
{
    NSLog(@"设置当前日期，初始化:%@",date);
    
    self.calendarItem.seletedDate = date;
   
    // 设置顶部标题
    [self.titleLabel setText:[self stringFromDate:self.calendarItem.seletedDate]];
    
    if ([_delegate respondsToSelector:@selector(YBFDCalendar:didSelectedDate:)]) {
        [_delegate YBFDCalendar:self didSelectedDate:self.calendarItem.seletedDate];
    }
    
    [self.calendarItem reloadData];
    
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
                
                ws.calendarItem.restArray = leaveoff;
                
                ws.calendarItem.bookArray = reservationapply;
                
                [ws.calendarItem reloadData];
                
            });
            
        }else{
            
            NSLog(@"%@",responseObject[@"msg"]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{    //拖动前的起始坐标
    
//    startContentOffsetX = scrollView.contentOffset.x;
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{    //将要停止前的坐标
    
//    willEndContentOffsetX = scrollView.contentOffset.x;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
//    endContentOffsetX = scrollView.contentOffset.x;
//    
//    if (endContentOffsetX < willEndContentOffsetX && willEndContentOffsetX < startContentOffsetX) { // 画面从右往左移动，前一页
//        [self setPreviousMonthDate];
//        NSLog(@"画面从右往左移动，前一页");
//    } else if (endContentOffsetX > willEndContentOffsetX && willEndContentOffsetX > startContentOffsetX) {// 画面从左往右移动，后一页
//        [self setNextMonthDate];
//        NSLog(@"画面从左往右移动，后一页");
//    }
//    
//    // 重置
//    self.scrollView.contentOffset = CGPointMake(self.scrollView.width, 0);
    
}

#pragma mark - UIScrollViewDelegate

#pragma mark - SEL
// 跳到上一个月
- (void)setPreviousMonthDate
{
//    [self setCurrentDate:[self.calendarItem previousMonthDate]];
    self.selectDate = [self.calendarItem previousMonthDate];
}
// 跳到下一个月
- (void)setNextMonthDate {
//    [self setCurrentDate:[self.calendarItem nextMonthDate]];
    self.selectDate = [self.calendarItem nextMonthDate];
}

#pragma mark - FDCalendarItemDelegate
- (void)YBCalendarItem:(YBFDCalendarItem *)item didSelectedDate:(NSDate *)date
{
    
    NSLog(@"%s",__func__);
    
    self.date = date;
    self.calendarItem.seletedDate = date;
    
    // 设置当前日期，初始化
    //    [self setCurrentDate:self.date];
    
    // 刷新控制器底部数据
    if ([_delegate respondsToSelector:@selector(YBFDCalendar:didSelectedDate:)]) {
        [_delegate YBFDCalendar:self didSelectedDate:self.date];
    }
    
}

@end
