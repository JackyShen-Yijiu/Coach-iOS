//
//  YBHomeLeftViewController.m
//  HeiMao_B
//
//  Created by JiangangYang on 16/3/25.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "YBHomeLeftViewController.h"
#import "FDCalendar.h"
#import "NoContentTipView.h"
#import "CourseSummaryDayCell.h"
#import "CourseDetailViewController.h"
#import "RefreshTableView.h"
#import "AppointmentCoachTimeInfoModel.h"
#import "YBFDCalendar.h"
#import "YYModel.h"
#import "YBCourseData.h"

#define calendarH 55
#define YBFDCalendarH 228

@interface YBHomeLeftViewController ()<UITableViewDataSource,UITableViewDelegate,FDCalendarDelegate,YBFDCalendarDelegate>

// 底部tableview
@property(nonatomic,strong) UITableView * courseDayTableView;

@property (nonatomic,strong) UIView *headView;

@property(nonatomic,strong) FDCalendar *calendarHeadView;
@property(nonatomic,strong) YBFDCalendar *ybCalendarHeadView;

@property(nonatomic,strong)NSMutableArray * courseDayTableData;

@property(nonatomic,strong)NSDateFormatter *dateFormattor;

@property(nonatomic,strong)NoContentTipView * tipView2;

@property (nonatomic,assign) BOOL isOpen;

@property (nonatomic,strong) NSDate *selectDate;

@end

@implementation YBHomeLeftViewController

- (NSMutableArray *)courseDayTableData
{
    if (_courseDayTableData==nil) {
        _courseDayTableData = [NSMutableArray array];
    }
    return _courseDayTableData;
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
    
    self.view.backgroundColor = RGB_Color(253, 253, 253);
    self.selectDate = [NSDate date];
    
    // 底部预约列表
    self.courseDayTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+calendarH, self.view.width, self.view.height-calendarH-64) style:UITableViewStylePlain];
    self.courseDayTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.courseDayTableView.delegate = self;
    self.courseDayTableView.dataSource = self;
    self.courseDayTableView.contentInset = UIEdgeInsetsMake(0, 0, calendarH, 0);
    [self.view addSubview:self.courseDayTableView];
    self.courseDayTableView.backgroundColor = [UIColor whiteColor];
    
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
    xialaBtn.frame = CGRectMake(self.calendarHeadView.width-20, -7, 15, 44);
    [xialaBtn setImage:[UIImage imageNamed:@"JZCoursefold_down"] forState:UIControlStateNormal];
    [xialaBtn addTarget:self action:@selector(xialaBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.calendarHeadView addSubview:xialaBtn];
    
    // 占位图
    self.tipView2 = [[NoContentTipView alloc] initWithContetntTip:@"您现在没有预约"];
    [self.tipView2 setHidden:YES];
    [self.courseDayTableView addSubview:self.tipView2];
    self.tipView2.center = CGPointMake(self.courseDayTableView .width/2.f, CGRectGetMaxY(self.view.frame)+self.tipView2.height);
    
    // 刷新当前界面
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(needRefresh:) name:KCourseViewController_NeedRefresh object:nil];
    
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
        openXialaBtn.frame = CGRectMake(self.ybCalendarHeadView.width-20, -7, 15, 44);
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)needRefresh:(NSNotification *)notification
{
    NSLog(@"%s",__func__);
}

- (void)modifyVacation
{
    
    if (self.isOpen) {

        // 设置当前日期
        [self.ybCalendarHeadView setCurrentDate:[NSDate date]];
        [self YBFDCalendar:self.ybCalendarHeadView didSelectedDate:[NSDate date]];
        
    }else{
        
        // 设置当前日期
        [self.calendarHeadView setCurrentDate:[NSDate date]];
        [self fdCalendar:self.calendarHeadView didSelectedDate:[NSDate date]];
        
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
    [self loadFootListDataWithinfoId:dataStr];
    
}

- (void)YBFDCalendar:(YBFDCalendar *)calendar didSelectedDate:(NSDate *)date
{
    NSLog(@"切换日历代理方法 %s",__func__);
    
    self.selectDate = date;
//    self.calendarHeadView.selectDate = self.selectDate;
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
    [self loadFootListDataWithinfoId:dataStr];
    
}

- (void)loadFootListDataWithinfoId:(NSString *)infoId
{
    
    NSString *  userId = [[UserInfoModel defaultUserInfo] userID];
    if (userId==nil && infoId==nil) {
        return;
    }
    
    WS(ws);
    // 加载底部预约列表数据
    [NetWorkEntiry getcoursereservationlistWithUserId:userId date:infoId  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"切换日历获取最新数据:responseObject:%@",responseObject);
        
        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        
        if (type == 1) {
            
            [ws.courseDayTableData removeAllObjects];
            
            NSArray *dataArray = responseObject[@"data"];
            
            for (NSDictionary *dict in dataArray) {
                YBCourseData *dataModel = [YBCourseData yy_modelWithDictionary:dict];
                
                dataModel.appointMentCount = 10;//dataModel.coursestudentcount;
                
                NSInteger studentCount = dataModel.appointMentCount;
                NSInteger hangshu = studentCount / 4;
                NSInteger yushu = studentCount % 4;

                if (YBIphone6 || YBIphone6Plus) {
                    hangshu = studentCount / 5;
                    yushu = studentCount % 5;
                }
                NSLog(@"hangshu:%ld yushu:%ld",(long)hangshu,(long)yushu);
                
                CGFloat coureStudentCollectionViewH = (coureSundentCollectionH + 8) * hangshu;
                if (yushu!=0) {
                    coureStudentCollectionViewH = (coureSundentCollectionH + 8) * (hangshu + 1);
                }
                NSLog(@"setModel coureStudentCollectionViewH:%f",coureStudentCollectionViewH);
    
                dataModel.appointMentViewH = coureStudentCollectionViewH;
                
                [ws.courseDayTableData addObject:dataModel];
            }
            
            NSLog(@"ws.courseDayTableData:%lu",(unsigned long)ws.courseDayTableData.count);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [ws.courseDayTableView reloadData];
            });
            
        }else{
            
            [ws dealErrorResponseWithTableView:nil info:responseObject];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ws netErrorWithTableView:nil];
    }];
    
}

#pragma mark - DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    count =  self.courseDayTableData.count;
    [self.tipView2 setHidden:count];
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CourseSummaryDayCell cellHeightWithModel:self.courseDayTableData[indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CourseSummaryDayCell * dayCell = [tableView dequeueReusableCellWithIdentifier:@"dayCell"];
    if (!dayCell) {
        dayCell = [[CourseSummaryDayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"dayCell"];
    }
    dayCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row < self.courseDayTableData.count)
        [dayCell setModel:self.courseDayTableData[indexPath.row]];
    
    dayCell.parentViewController = self;
    dayCell.backgroundColor = RGB_Color(255, 255, 255);
    
    return dayCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YBCourseData  * courseModel = nil;
    courseModel = [[self courseDayTableData] objectAtIndex:indexPath.row];
    if (courseModel) {
        CourseDetailViewController * decv = [[CourseDetailViewController alloc] init];
        decv.couresID = courseModel.coachid;
        [self.navigationController pushViewController:decv animated:YES];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView==self.courseDayTableView) {
        [self hiddenOpenCalendar];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
