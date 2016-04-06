//
//  YBHomeLeftViewController.m
//  HeiMao_B
//
//  Created by JiangangYang on 16/3/25.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "YBHomeLeftViewController.h"
#import "FDCalendar.h"
#import "FDCalendarItem.h"
#import "CourseDetailViewController.h"
#import "RefreshTableView.h"
#import "AppointmentCoachTimeInfoModel.h"
#import "YBFDCalendar.h"
#import "YYModel.h"
#import "YBCourseData.h"
#import "YBCourseTableView.h"
#import "YBObjectTool.h"
#import "JZCompletionConfirmationContriller.h"
#import "NoContentTipView.h"

@interface YBHomeLeftViewController ()<FDCalendarDelegate,YBFDCalendarDelegate,UIScrollViewDelegate>
{
    CGFloat startContentOffsetX;
    CGFloat willEndContentOffsetX;
    CGFloat endContentOffsetX;
}

@property(nonatomic,strong) NSMutableArray * leftTableDataArray;
@property(nonatomic,strong) NSMutableArray * centerTableDataArray;
@property(nonatomic,strong) NSMutableArray * rightTableDataArray;

@property (nonatomic,strong) YBCourseTableView *leftCourseTableView;
@property (nonatomic,strong) YBCourseTableView *centerCourseTableView;
@property (nonatomic,strong) YBCourseTableView *rightCourseTableView;

@property (nonatomic,strong) UIView *headView;

@property(nonatomic,strong) FDCalendar *calendarHeadView;
@property(nonatomic,strong) YBFDCalendar *ybCalendarHeadView;

@property(nonatomic,strong) NSDateFormatter *dateFormattor;


@property (nonatomic,assign) BOOL isOpen;

@property (nonatomic,strong) NSDate *selectDate;

@property (nonatomic,strong) UIScrollView *mainScrollView;

@property (nonatomic,strong) UIButton *confimBtn;

@property(nonatomic,strong)NoContentTipView * tipView1;

@end

@implementation YBHomeLeftViewController

- (UIButton *)confimBtn
{
    if (_confimBtn==nil) {
        
        CGFloat confimBtnW = 48;
        CGFloat confimBtnH = confimBtnW;
        CGFloat confimBtnX = 5;
        CGFloat confimBtnY = self.view.height - 64 - confimBtnW;
        _confimBtn = [[UIButton alloc] initWithFrame:CGRectMake(confimBtnX, confimBtnY, confimBtnW, confimBtnH)];
        _confimBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"JZCoursebutton_time"]];
        [_confimBtn addTarget:self action:@selector(confimBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _confimBtn;
}

- (void)confimBtnDidClick
{
    
    JZCompletionConfirmationContriller *vc = [JZCompletionConfirmationContriller new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (NSMutableArray *)leftTableDataArray
{
    if (_leftTableDataArray==nil) {
        _leftTableDataArray = [NSMutableArray array];
    }
    return _leftTableDataArray;
}
- (NSMutableArray *)centerTableDataArray
{
    if (_centerTableDataArray==nil) {
        _centerTableDataArray = [NSMutableArray array];
    }
    return _centerTableDataArray;
}
- (NSMutableArray *)rightTableDataArray
{
    if (_rightTableDataArray==nil) {
        _rightTableDataArray = [NSMutableArray array];
    }
    return _rightTableDataArray;
}
- (YBCourseTableView *)leftCourseTableView
{
    if (_leftCourseTableView==nil) {
        _leftCourseTableView = [[YBCourseTableView alloc] init];
        _leftCourseTableView.backgroundColor = [UIColor redColor];
        _leftCourseTableView.parentViewController = self;
    }
    return _leftCourseTableView;
}
- (YBCourseTableView *)rightCourseTableView
{
    if (_rightCourseTableView==nil) {
        _rightCourseTableView = [[YBCourseTableView alloc] init];
        _rightCourseTableView.backgroundColor = [UIColor redColor];
        _rightCourseTableView.parentViewController = self;
    }
    return _rightCourseTableView;
}
- (YBCourseTableView *)centerCourseTableView
{
    if (_centerCourseTableView==nil) {
        _centerCourseTableView = [[YBCourseTableView alloc] initWithFrame:CGRectMake(0, 0, self.mainScrollView.width, self.mainScrollView.height-64)];
        _centerCourseTableView.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
        _centerCourseTableView.parentViewController = self;
    }
    return _centerCourseTableView;
}

- (void)hiddenOpenCalendar
{
    // 隐藏展开更多
    if (self.isOpen) {
        [self xialaBtnDidClick];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self hiddenOpenCalendar];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
    self.selectDate = [NSDate date];
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, calendarH, self.view.width, self.view.height-calendarH)];
    self.mainScrollView.backgroundColor = [UIColor whiteColor];
//    self.mainScrollView.contentSize = CGSizeMake(self.mainScrollView.width, self.mainScrollView.height);
//    self.mainScrollView.contentOffset = CGPointMake(0, 0);
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.delegate = self;
    [self.view addSubview:self.mainScrollView];
    
//    [self.mainScrollView addSubview:self.leftTableView];
    [self.mainScrollView addSubview:self.centerCourseTableView];
//    [self.mainScrollView addSubview:self.rightTableView];
    
    self.tipView1 = [[NoContentTipView alloc] initWithContetntTip:@"暂无数据"];
    [self.tipView1 setHidden:YES];
    [self.centerCourseTableView addSubview:self.tipView1];
    self.tipView1.center = CGPointMake(self.centerCourseTableView.width/2.f, self.centerCourseTableView.height/2.f);
    
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, calendarH)];
    self.headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headView];
    
    self.headView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.headView.layer.shadowOffset = CGSizeMake(0, 2);
    self.headView.layer.shadowOpacity = 0.036;
    self.headView.layer.shadowRadius = 2;
    
    // 顶部日历
    self.calendarHeadView = [[FDCalendar alloc] initWithCurrentDate:[NSDate date]];
    self.calendarHeadView.delegate = self;
    self.calendarHeadView.frame = CGRectMake(0, 0, self.view.width, calendarH);
    [self.headView addSubview:self.calendarHeadView];
    
    // 添加右边下拉按钮
    UIButton *xialaBtn = [[UIButton alloc] init];
    xialaBtn.frame = CGRectMake(self.calendarHeadView.width-20, -10, 20, 44);
    [xialaBtn setImage:[UIImage imageNamed:@"JZCoursefold_down"] forState:UIControlStateNormal];
    [xialaBtn addTarget:self action:@selector(xialaBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.calendarHeadView addSubview:xialaBtn];
    
    [self.view addSubview:self.confimBtn];

    // 刷新当前界面
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(needRefresh:) name:KCourseViewController_NeedRefresh object:nil];
    // 隐藏展开日历
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenOpenCalendar) name:@"hiddenOpenCalendar" object:nil];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hiddenOpenCalendar];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{    //拖动前的起始坐标
    
//    startContentOffsetX = scrollView.contentOffset.x;
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{//将要停止前的坐标
    
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
//    self.mainScrollView.contentOffset = CGPointMake(self.mainScrollView.width, 0);
    
}

// 跳到上一个月
- (void)setPreviousMonthDate
{
    NSDate *previousDate = [self.calendarHeadView.centerCalendarItem previousMonthDate];
    NSLog(@"previousDate:%@",previousDate);
    
    [self.calendarHeadView setCurrentDate:previousDate];
    
}

// 跳到下一个月
- (void)setNextMonthDate {
    
    NSDate *nextDayDate = [self.calendarHeadView.centerCalendarItem nextMonthDate];
    
    NSLog(@"nextDayDate:%@",nextDayDate);
    
    [self.calendarHeadView setCurrentDate:nextDayDate];
    
}

- (void)xialaBtnDidClick
{
    NSLog(@"%s",__func__);

    if (self.isOpen) {
        
        [UIView animateWithDuration:0.5 animations:^{
            self.ybCalendarHeadView.transform = CGAffineTransformIdentity;
            self.calendarHeadView.transform = CGAffineTransformIdentity;
        }completion:^(BOOL finished) {
            [self.ybCalendarHeadView removeFromSuperview];
        }];

    }else{
        
        // 顶部展开的日历
        self.ybCalendarHeadView = [[YBFDCalendar alloc] initWithCurrentDate:self.selectDate];
        self.ybCalendarHeadView.delegate = self;
        self.ybCalendarHeadView.frame = CGRectMake(0, -YBFDCalendarH, self.view.width, YBFDCalendarH);
        [self.view addSubview:self.ybCalendarHeadView];
        self.ybCalendarHeadView.layer.shadowColor = [UIColor blackColor].CGColor;
        self.ybCalendarHeadView.layer.shadowOffset = CGSizeMake(0, 2);
        self.ybCalendarHeadView.layer.shadowOpacity = 0.036;
        self.ybCalendarHeadView.layer.shadowRadius = 2;
        
        // 添加右边下拉按钮
        UIButton *openXialaBtn = [[UIButton alloc] init];
        openXialaBtn.frame = CGRectMake(self.ybCalendarHeadView.width-20, -10, 20, 44);
        [openXialaBtn setImage:[UIImage imageNamed:@"JZCoursefold_up"] forState:UIControlStateNormal];
        [openXialaBtn addTarget:self action:@selector(xialaBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        [self.ybCalendarHeadView addSubview:openXialaBtn];
        
        [UIView animateWithDuration:0.5 animations:^{
            self.ybCalendarHeadView.transform = CGAffineTransformMakeTranslation(0, YBFDCalendarH+64);
            self.calendarHeadView.transform = CGAffineTransformMakeTranslation(0, -self.calendarHeadView.height);
        }];

    }

    self.isOpen = !self.isOpen;
    
}

- (void)needRefresh:(NSNotification *)notification
{
    NSLog(@"%s",__func__);
}

- (void)today
{
    if (self.isOpen) {
        
        // 设置当前日期
        [self.ybCalendarHeadView setCurrentDate:[NSDate date]];
        
    }else{
        
        // 设置当前日期
        [self.calendarHeadView setCurrentDate:[NSDate date]];

    }
    
}

- (void)modifyVacation:(NSDate *)date
{
    
    if (self.isOpen) {

        // 设置当前日期
        [self.ybCalendarHeadView setCurrentDate:self.selectDate];
        
    }else{
        
        // 设置当前日期
        [self.calendarHeadView setCurrentDate:self.selectDate];

    }
    
}

- (void)dealErrorResponseWithTableView:(RefreshTableView *)tableview info:(NSDictionary *)dic
{
    [self showTotasViewWithMes:[dic objectForKey:@"msg"]];
    [tableview.refreshHeader endRefreshing];
    [tableview.refreshFooter endRefreshing];
}

- (void)netErrorWithTableView:(RefreshTableView*)tableView
{
    [self showTotasViewWithMes:@"网络异常，稍后重试"];
    [tableView.refreshHeader endRefreshing];
    [tableView.refreshFooter endRefreshing];
}

#pragma mark LoadDayData
- (void)fdCalendar:(FDCalendar *)calendar didSelectedDate:(NSDate *)date
{
    NSLog(@"切换日历代理方法 %s date:%@",__func__,date);

    self.selectDate = date;
    self.ybCalendarHeadView.selectDate = self.selectDate;

    if (!self.dateFormattor) {
        self.dateFormattor = [[NSDateFormatter alloc] init];
        [self.dateFormattor setDateFormat:@"yyyy-M-d"];
    }
    NSString * dataStr = [self.dateFormattor stringFromDate:date];
    NSLog(@"切换日历代理方法 dataStr:%@",dataStr);
    
    // 加载底部预约列表数据
    [self loadFootListDataWithdataStr:dataStr];
    
}

- (void)YBFDCalendar:(YBFDCalendar *)calendar didSelectedDate:(NSDate *)date
{
    NSLog(@"切换日历代理方法 %s",__func__);
    
    self.selectDate = date;
    [self.calendarHeadView changeDate:self.selectDate];
    
    // 隐藏展开更多
    if (self.isOpen) {
        [self xialaBtnDidClick];
    }
    
    if (!self.dateFormattor) {
        self.dateFormattor = [[NSDateFormatter alloc] init];
        [self.dateFormattor setDateFormat:@"yyyy-M-d"];
    }
    NSString * dataStr = [self.dateFormattor stringFromDate:date];
    NSLog(@"YBFDCalendar切换日历代理方法 dataStr:%@",dataStr);
    
    // 加载底部预约列表数据
    [self loadFootListDataWithdataStr:dataStr];
    
}

- (void)loadFootListDataWithdataStr:(NSString *)dataStr
{
    
    NSString *  userId = [[UserInfoModel defaultUserInfo] userID];
    if (userId==nil && dataStr==nil) {
        return;
    }
    
    WS(ws);
    // 加载底部预约列表数据
    [NetWorkEntiry getcoursereservationlistWithUserId:userId date:dataStr  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"切换日历获取最新数据:responseObject:%@",responseObject);
        
        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        
        if (type == 1) {
            
            [ws.centerTableDataArray removeAllObjects];
            
            NSArray *dataArray = responseObject[@"data"];
            
            for (NSDictionary *dict in dataArray) {
                YBCourseData *dataModel = [YBCourseData yy_modelWithDictionary:dict];
                                
                NSInteger studentCount = dataModel.coursestudentcount;
                NSInteger hangshu = studentCount / 4;
                NSInteger yushu = studentCount % 4;

                if (YBIphone6) {
                    hangshu = studentCount / 5;
                    yushu = studentCount % 5;
                }
                if (YBIphone6Plus) {
                    hangshu = studentCount / 6;
                    yushu = studentCount % 6;
                }
                NSLog(@"预约数据hangshu:%ld yushu:%ld",(long)hangshu,(long)yushu);
                
                CGFloat coureStudentCollectionViewH = (coureSundentCollectionH + 8) * hangshu;
                if (yushu!=0) {
                    coureStudentCollectionViewH = (coureSundentCollectionH + 8) * (hangshu + 1);
                }
                NSLog(@"setModel coureStudentCollectionViewH:%f",coureStudentCollectionViewH);
    
                dataModel.appointMentViewH = coureStudentCollectionViewH;
                
                [ws.centerTableDataArray addObject:dataModel];
            }
            
            ws.centerCourseTableView.selectData = dataStr;
            ws.centerCourseTableView.dataArray = ws.centerTableDataArray;
            
            NSLog(@"ws.centerTableDataArray.count:%lu",(unsigned long)ws.centerTableDataArray.count);
            
            [ws.centerCourseTableView reloadData];

            [self.tipView1 setHidden:ws.centerTableDataArray.count];

        }else{
            
            [ws dealErrorResponseWithTableView:nil info:responseObject];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ws netErrorWithTableView:nil];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
