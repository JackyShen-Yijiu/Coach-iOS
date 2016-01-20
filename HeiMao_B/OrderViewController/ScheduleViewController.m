//
//  ScheduleViewController.m
//  HeiMao_B
//
//  Created by kequ on 15/10/24.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "ScheduleViewController.h"
#import "RefreshTableView.h"
#import "HMCourseModel.h"
#import "CourseSummaryListCell.h"

#import "FDCalendar.h"
#import "CourseSummaryDayCell.h"
#import "CourseDetailViewController.h"
#import "NoContentTipView.h"
#import "VacationViewController.h"

@interface ScheduleViewController () <UITableViewDataSource,UITableViewDelegate,FDCalendarDelegate>

@property(nonatomic,strong)UISegmentedControl * segController;
@property(nonatomic,strong)UIScrollView * scrollView;

@property(nonatomic,strong)UITableView * courseDayTableView;
@property(nonatomic,strong)FDCalendar *calendarHeadView;
@property(nonatomic,strong)NSMutableArray * courseDayTableData;

@property(nonatomic,assign)BOOL isNeedRefresh;
@property(nonatomic,strong)NSDateFormatter *dateFormattor;
@property(nonatomic,strong)NoContentTipView * tipView2;
@end

@implementation ScheduleViewController

#pragma mark - LoingNotification
- (void)didLoginSucess:(NSNotification *)notification
{
    [self fdCalendar:nil didSelectedDate:[NSDate date]];
}

- (void)didLoginoutSucess:(NSNotification *)notifcation
{
    [self.courseDayTableData removeAllObjects];
    [[self courseDayTableData] removeAllObjects];
    [self.courseDayTableView reloadData];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.isNeedRefresh = YES;
    [self initUI];
    [self addNotification];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modifyVacation) name:@"modifyVacation" object:nil];
    
}

- (void)modifyVacation
{
    [self fdCalendar:nil didSelectedDate:[NSDate date]];
}

- (void)restBtnDidClick
{
    VacationViewController *vacation = [[VacationViewController alloc] init];
    [self.navigationController pushViewController:vacation animated:YES];
}

#pragma mark Life Sycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self resetNavBar];
    
    self.myNavigationItem.title = @"日程";
    
    //self.myNavigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"休假" highTitle:@"休假" target:self action:@selector(restBtnDidClick) isRightItem:YES];
    
    //self.myNavigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"今天" highTitle:@"今天" target:self action:@selector(modifyVacation) isRightItem:NO];

    [self.scrollView setContentOffset:CGPointMake(1 * self.scrollView.width, self.scrollView.contentOffset.y) animated:YES];

    //[self initNavBar];
    //    [self showMessCountInTabBar:10];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(self.isNeedRefresh){
        [self fdCalendar:nil didSelectedDate:[NSDate date]];
    }
    self.isNeedRefresh = NO;
}

#pragma mark - initUI

- (void)initNavBar
{
    [self resetNavBar];

}

-(void)initUI
{
    UIView * view = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64 - 48)];
    self.scrollView.contentSize = CGSizeMake(self.view.width * 2, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.scrollEnabled = NO;
    [self.view addSubview:self.scrollView];
    
    //日程
    self.courseDayTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.scrollView.width, 0, self.scrollView.width, self.scrollView.height) style:UITableViewStylePlain];
    self.courseDayTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.courseDayTableView.delegate = self;
    self.courseDayTableView.dataSource = self;
    
    self.calendarHeadView = [[FDCalendar alloc] initWithCurrentDate:[NSDate date]];
    self.calendarHeadView.delegate = self;
    self.courseDayTableView.tableHeaderView = self.calendarHeadView;
    self.courseDayTableView.sectionHeaderHeight = self.calendarHeadView.height;
    [self.scrollView addSubview:self.courseDayTableView];
    
    self.tipView2 = [[NoContentTipView alloc] initWithContetntTip:@"您现在没有预约"];
    [self.tipView2 setHidden:YES];
    [self.courseDayTableView addSubview:self.tipView2];
    self.tipView2.center = CGPointMake(self.courseDayTableView .width/2.f, self.courseDayTableView.height/2.f + 190);
}


#pragma mark Load Data
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
    NSLog(@"切换日历代理方法 %s",__func__);
    
    if (!self.dateFormattor) {
        self.dateFormattor = [[NSDateFormatter alloc] init];
        [self.dateFormattor setDateFormat:@"yyyy-M-d"];
    }
    NSString * dataStr = [self.dateFormattor stringFromDate:date];
    NSString *  userId = [[UserInfoModel defaultUserInfo] userID];
    
    WS(ws);
    [NetWorkEntiry getAllCourseInfoWithUserId:userId DayTime:dataStr  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"切换日历获取最新数据:responseObject:%@",responseObject);
        
        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        
        if (type == 1) {
            
            ws.courseDayTableData = [[BaseModelMethod getCourseListArrayFormDicInfo:[responseObject objectArrayForKey:@"data"]] mutableCopy];
            
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
    if (!self.isNeedRefresh)
        [self.tipView2 setHidden:count];
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CourseSummaryDayCell cellHeight];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    CourseSummaryDayCell * dayCell = [tableView dequeueReusableCellWithIdentifier:@"dayCell"];
    if (!dayCell) {
        dayCell = [[CourseSummaryDayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"dayCell"];
    }
    if (indexPath.row < self.courseDayTableData.count)
        [dayCell setModel:self.courseDayTableData[indexPath.row]];
    
    return dayCell;

    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HMCourseModel  * courseModel = nil;
    courseModel = [[self courseDayTableData] objectAtIndex:indexPath.row];
    if (courseModel) {
        CourseDetailViewController * decv = [[CourseDetailViewController alloc] init];
        decv.couresID = courseModel.courseId;
        [self.navigationController pushViewController:decv animated:YES];
    }
}


#pragma mark -
//其他页面预约状态发生变化，通知本页面更新
- (void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(needRefresh:) name:KCourseViewController_NeedRefresh object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLoginSucess:) name:@"kLoginSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLoginoutSucess:) name:@"kLoginoutSuccess" object:nil];
}

- (void)needRefresh:(NSNotification *)notification
{
    [self.courseDayTableView reloadData];
}

@end