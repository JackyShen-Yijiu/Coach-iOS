//
//  courseViewController.m
//  HeiMao_B
//
//  Created by kequ on 15/10/24.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "CourseViewController.h"
#import "RFSegmentView.h"
#import "RefreshTableView.h"
#import "HMCourseModel.h"
#import "CourseSummaryListCell.h"

#import "FDCalendar.h"
#import "CourseSummaryDayCell.h"
#import "CourseDetailViewController.h"


@interface CourseViewController () <UITableViewDataSource,UITableViewDelegate,RFSegmentViewDelegate,FDCalendarDelegate>

@property(nonatomic,strong)UISegmentedControl * segController;
@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,strong)RefreshTableView * courseSummaryTableView;
@property(nonatomic,strong)NSMutableArray * courseSummaryData;

@property(nonatomic,strong)UITableView * courseDayTableView;
@property(nonatomic,strong)FDCalendar *calendarHeadView;
@property(nonatomic,strong)NSMutableArray * courseDayTableData;

@property(nonatomic,assign)BOOL isNeedRefresh;
@property(nonatomic,strong)NSDateFormatter *dateFormattor;
@end

@implementation CourseViewController


#pragma mark - LoingNotification
- (void)didLoginSucess:(NSNotification *)notification
{
    [self.courseSummaryTableView.refreshHeader beginRefreshing];
    [self fdCalendar:nil didSelectedDate:[NSDate date]];
}

- (void)didLoginoutSucess:(NSNotification *)notifcation
{
    [self.courseDayTableData removeAllObjects];
    [[self courseDayTableData] removeAllObjects];
    [self.courseSummaryTableView reloadData];
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
}


#pragma mark Life Sycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initNavBar];
    [self showMessCountInTabBar:10];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(self.isNeedRefresh){
        [self.courseSummaryTableView.refreshHeader beginRefreshing];
        [self fdCalendar:nil didSelectedDate:[NSDate date]];
    }
    self.isNeedRefresh = NO;
}

#pragma mark - initUI

- (void)initNavBar
{
    [self resetNavBar];
    RFSegmentView * segController = [[RFSegmentView alloc] initWithFrame:CGRectMake(0, 0, 180, 30.f) items:@[@"预约",@"日程"]];
    segController.delegate = self;
    [segController setSeltedIndex:self.scrollView.contentOffset.x / self.scrollView.width];
    self.myNavigationItem.titleView = segController;
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
    
    self.courseSummaryTableView = [[RefreshTableView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.width, self.scrollView.height) style:UITableViewStylePlain];
    self.courseSummaryTableView.delegate = self;
    self.courseSummaryTableView.dataSource = self;
    [self.scrollView addSubview:self.courseSummaryTableView];
    [self initRefreshView];
    
    //日程
    self.courseDayTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.scrollView.width, 0, self.scrollView.width, self.scrollView.height) style:UITableViewStylePlain];
    self.courseDayTableView.delegate = self;
    self.courseDayTableView.dataSource = self;
    
    self.calendarHeadView = [[FDCalendar alloc] initWithCurrentDate:[NSDate date]];
    self.calendarHeadView.delegate = self;
    self.courseDayTableView.tableHeaderView = self.calendarHeadView;
    self.courseDayTableView.sectionHeaderHeight = self.calendarHeadView.height;
    [self.scrollView addSubview:self.courseDayTableView];

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

- (void)initRefreshView
{
    WS(ws);
    self.courseSummaryTableView.refreshHeader.beginRefreshingBlock = ^(){
        
        [NetWorkEntiry getCourseinfoWithUserId:[[UserInfoModel defaultUserInfo] userID] pageIndex:1 pageCount:RELOADDATACOUNT success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
            
            if (type == 1) {
                ws.courseSummaryData = [[BaseModelMethod getCourseListArrayFormDicInfo:[responseObject objectArrayForKey:@"data"]] mutableCopy];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [ws.courseSummaryTableView.refreshHeader endRefreshing];
                    [ws.courseSummaryTableView reloadData];
                });
            }else{
                [ws dealErrorResponseWithTableView:ws.courseSummaryTableView info:responseObject];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [ws netErrorWithTableView:ws.courseSummaryTableView];
        }];
    };
    
    self.courseSummaryTableView.refreshFooter.beginRefreshingBlock = ^(){
      
        if(ws.courseSummaryData.count % RELOADDATACOUNT){
            [ws showTotasViewWithMes:@"已经加载所有数据"];
            [ws.courseSummaryTableView.refreshFooter endRefreshing];
            return ;
        }
        [NetWorkEntiry getCourseinfoWithUserId:[[UserInfoModel defaultUserInfo] userID] pageIndex:ws.courseSummaryData.count / RELOADDATACOUNT pageCount:RELOADDATACOUNT success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
            if (type == 1) {
                NSArray * listArray = [BaseModelMethod getCourseListArrayFormDicInfo:[responseObject objectArrayForKey:@"data"]];
                if (listArray.count) {
                    [ws.courseSummaryData addObjectsFromArray:listArray];
                    [ws.courseSummaryTableView reloadData];
                }else{
                    [ws showTotasViewWithMes:@"已经加载所有数据"];
                }
                [ws.courseSummaryTableView.refreshFooter endRefreshing];
            }else{
                [ws dealErrorResponseWithTableView:ws.courseSummaryTableView info:responseObject];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [ws netErrorWithTableView:ws.courseSummaryTableView];
        }];
    };
}

#pragma mark LoadDayData
- (void)fdCalendar:(FDCalendar *)calendar didSelectedDate:(NSDate *)date
{
    if (!self.dateFormattor) {
        self.dateFormattor = [[NSDateFormatter alloc] init];
        [self.dateFormattor setDateFormat:@"yyyy-M-d"];
    }
    NSString * dataStr = [self.dateFormattor stringFromDate:date];
    NSString *  userId = [[UserInfoModel defaultUserInfo] userID];
    
    WS(ws);
    [NetWorkEntiry getAllCourseInfoWithUserId:userId DayTime:dataStr  success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
    if (tableView == self.courseSummaryTableView) {
        return self.courseSummaryData.count;
    }else{
        return self.courseDayTableData.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.courseSummaryTableView) {
        return [CourseSummaryListCell cellHeightWithModel:self.courseSummaryData[indexPath.row]];
    }else{
        return [CourseSummaryDayCell cellHeight];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.courseSummaryTableView) {
        CourseSummaryListCell * sumCell = [tableView dequeueReusableCellWithIdentifier:@"SumCell"];
        if (!sumCell) {
            sumCell = [[CourseSummaryListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SumCell"];
        }
        if (indexPath.row < self.courseSummaryData.count)
            [sumCell setModel:self.courseSummaryData[indexPath.row]];
        return sumCell;
    }else{
        CourseSummaryDayCell * dayCell = [tableView dequeueReusableCellWithIdentifier:@"dayCell"];
        if (!dayCell) {
            dayCell = [[CourseSummaryDayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"dayCell"];
        }
        if (indexPath.row < self.courseDayTableData.count)
            [dayCell setModel:self.courseDayTableData[indexPath.row]];
        
        return dayCell;
    }
    return [UITableViewCell new];
}

#pragma mark - Action
- (void)segmentViewSelectIndex:(NSInteger)index
{
    [self.scrollView setContentOffset:CGPointMake(index * self.scrollView.width, self.scrollView.contentOffset.y) animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HMCourseModel  * courseModel = nil;
    if (tableView == self.courseSummaryTableView) {
        courseModel = [[self courseSummaryData] objectAtIndex:indexPath.row];
    }else{
        courseModel = [[self courseDayTableData] objectAtIndex:indexPath.row];
    }
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
    HMCourseModel * model = [notification object];
    if (model) {
        for (HMCourseModel * sumModel in self.courseSummaryData) {
            if ([sumModel.courseId isEqualToString:model.courseId]) {
                sumModel.courseStatue = model.courseStatue;
                [self.courseDayTableView reloadData];
                break;
            }
        }
    }
}

@end