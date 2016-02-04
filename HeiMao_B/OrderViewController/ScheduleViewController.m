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
#import "JGvalidationView.h"
#import "JGYuYueHeadView.h"
#import "AppointmentCoachTimeInfoModel.h"
#import "JGAppointMentViewController.h"

@interface ScheduleViewController () <UITableViewDataSource,UITableViewDelegate,FDCalendarDelegate,JGYuYueHeadViewDelegate>

// 底部tableview
@property(nonatomic,strong) UITableView * courseDayTableView;
// 日历
@property(nonatomic,strong) FDCalendar *calendarHeadView;
// 中间预约时间
@property (nonatomic,strong) JGYuYueHeadView *yuYueheadView;

@property(nonatomic,strong)NSMutableArray * courseDayTableData;

@property(nonatomic,assign)BOOL isNeedRefresh;

@property(nonatomic,strong)NSDateFormatter *dateFormattor;

@property(nonatomic,strong)NoContentTipView * tipView2;

// 教练资格审核提示框
@property (nonatomic,strong)JGvalidationView*bgView;

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
    NSLog(@"%s",__func__);
    
    // 设置当前日期
    [self.calendarHeadView setCurrentDate:[NSDate date]];
    
   [self fdCalendar:self.calendarHeadView didSelectedDate:[NSDate date]];
    
    
}

- (void)xueyuanyuyueDidClick
{
    NSLog(@"%s",__func__);
    JGAppointMentViewController *vc = [[JGAppointMentViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark Life Sycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self resetNavBar];
    
    self.myNavigationItem.title = @"日程";
    
    self.myNavigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"学员预约" highTitle:@"学员预约" target:self action:@selector(xueyuanyuyueDidClick) isRightItem:YES];
    
    self.myNavigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"今天" highTitle:@"今天" target:self action:@selector(modifyVacation) isRightItem:NO];

//    [self fdCalendar:self.calendarHeadView didSelectedDate:[NSDate date]];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(self.isNeedRefresh){
        [self fdCalendar:nil didSelectedDate:[NSDate date]];
    }
    self.isNeedRefresh = NO;
    
    [_bgView removeFromSuperview];
    if ([UserInfoModel defaultUserInfo].userID && [UserInfoModel defaultUserInfo].is_validation==NO) {
        _bgView = [[JGvalidationView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 80)];
        [self.view addSubview:_bgView];
        return;
    }
}

#pragma mark - initUI

- (void)initNavBar
{
    [self resetNavBar];

}

-(void)initUI
{
    
    // 顶部日历
    self.calendarHeadView = [[FDCalendar alloc] initWithCurrentDate:[NSDate date]];
    self.calendarHeadView.delegate = self;
    self.calendarHeadView.frame = CGRectMake(0, 64, self.view.width, 30+65);
    [self.view addSubview:self.calendarHeadView];
    
    // 中间方格
    self.yuYueheadView = [[JGYuYueHeadView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 180)];
    self.yuYueheadView.delegate = self;
    
    // 底部预约列表
    self.courseDayTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.calendarHeadView.frame), self.view.width, self.view.height-self.calendarHeadView.height-64) style:UITableViewStylePlain];
    self.courseDayTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.courseDayTableView.delegate = self;
    self.courseDayTableView.dataSource = self;
    self.courseDayTableView.tableHeaderView = self.yuYueheadView;
    self.courseDayTableView.contentInset = UIEdgeInsetsMake(0, 0, self.calendarHeadView.height, 0);
    [self.view addSubview:self.courseDayTableView];
    
    // 占位图
    self.tipView2 = [[NoContentTipView alloc] initWithContetntTip:@"您现在没有预约"];
    [self.tipView2 setHidden:YES];
    [self.courseDayTableView addSubview:self.tipView2];
    self.tipView2.center = CGPointMake(self.courseDayTableView .width/2.f, CGRectGetMaxY(self.yuYueheadView.frame)+self.tipView2.height);
    
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
    
    // 加载中间预约时间
    [self loadMidYuyueTimeData:dataStr];

    // 加载底部预约列表数据
    [self loadFootListData:dataStr];
    
    // 设置顶部标题
    self.myNavigationItem.title = [NSString stringWithFormat:@"%@",[self.dateFormattor stringFromDate:date]];

}

#pragma mark --- 中间日程点击事件
- (void)JGYuYueHeadViewWithCollectionViewDidSelectItemAtIndexPath:(NSIndexPath *)indexPath timeInfo:(AppointmentCoachTimeInfoModel *)model
{
    NSLog(@"加载底部数据");
    [self loadFootListDataWithinfoId:model.infoId];
    
}

- (void)loadMidYuyueTimeData:(NSString *)dataStr
{
    
    NSLog(@"loadMidYuyueTimeData dataStr:%@",dataStr);
    
    NSString *userId = [[UserInfoModel defaultUserInfo] userID];
    if (userId==nil) {
        return;
    }
    
    WS(ws);
    [NetWorkEntiry getAllCourseTimeWithUserId:userId DayTime:dataStr success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"loadMidYuyueTimeData responseObject:%@",responseObject);
        
        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        
        if (type == 1) {
            
            NSError *error=nil;
            
            NSArray *dataArray = [MTLJSONAdapter modelsOfClass:AppointmentCoachTimeInfoModel.class fromJSONArray:responseObject[@"data"] error:&error];

            dispatch_async(dispatch_get_main_queue(), ^{
                
                [ws.yuYueheadView receiveCoachTimeData:dataArray];
                
            });
            
        }else{
            
            [ws dealErrorResponseWithTableView:nil info:responseObject];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [ws netErrorWithTableView:nil];

    }];
    
}

- (void)loadFootListDataWithinfoId:(NSString *)infoId
{
    
    NSString *  userId = [[UserInfoModel defaultUserInfo] userID];
    if (userId==nil && infoId==nil) {
        return;
    }
    
    WS(ws);
    // 加载底部预约列表数据
    [NetWorkEntiry getcoursereservationlistWithUserId:userId courseid:infoId  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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

- (void)loadFootListData:(NSString *)dataStr
{
    
    NSString *  userId = [[UserInfoModel defaultUserInfo] userID];
    if (userId==nil) {
        return;
    }
    
    WS(ws);
    // 加载底部预约列表数据
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