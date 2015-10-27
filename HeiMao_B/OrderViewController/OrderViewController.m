//
//  OrderViewController.m
//  HeiMao_B
//
//  Created by kequ on 15/10/24.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "OrderViewController.h"
#import "RFSegmentView.h"
#import "RefreshTableView.h"
#import "HMOrderModel.h"
#import "OrderSummaryListCell.h"

#import "FDCalendar.h"
#import "OrderSummaryDayCell.h"
#import "OrderDetailViewController.h"


@interface OrderViewController () <UITableViewDataSource,UITableViewDelegate,RFSegmentViewDelegate,FDCalendarDelegate>

@property(nonatomic,strong)UISegmentedControl * segController;
@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,strong)RefreshTableView * orderSummaryTableView;
@property(nonatomic,strong)NSMutableArray * orderSummaryData;

@property(nonatomic,strong)UITableView * orderDayTableView;
@property(nonatomic,strong)FDCalendar *calendarHeadView;
@property(nonatomic,strong)NSMutableArray * orderDayTableData;

@property(nonatomic,assign)BOOL isNeedRefresh;
@property(nonatomic,strong)NSDateFormatter *dateFormattor;
@end

@implementation OrderViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.isNeedRefresh = YES;
    [self initUI];
}


#pragma mark Life Sycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initNavBar];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(self.isNeedRefresh){
        [self.orderSummaryTableView.refreshHeader beginRefreshing];
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
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64)];
    self.scrollView.contentSize = CGSizeMake(self.view.width * 2, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.scrollEnabled = NO;
    [self.view addSubview:self.scrollView];
    
    self.orderSummaryTableView = [[RefreshTableView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.width, self.scrollView.height) style:UITableViewStylePlain];
    self.orderSummaryTableView.delegate = self;
    self.orderSummaryTableView.dataSource = self;
    [self.scrollView addSubview:self.orderSummaryTableView];
    [self initRefreshView];
    
    //日程
    self.orderDayTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.scrollView.width, 0, self.scrollView.width, self.scrollView.height) style:UITableViewStylePlain];
    self.orderDayTableView.delegate = self;
    self.orderDayTableView.dataSource = self;
    
    self.calendarHeadView = [[FDCalendar alloc] initWithCurrentDate:[NSDate date]];
    self.calendarHeadView.delegate = self;
    self.orderDayTableView.tableHeaderView = self.calendarHeadView;
    self.orderDayTableView.sectionHeaderHeight = self.calendarHeadView.height;
    [self.scrollView addSubview:self.orderDayTableView];
    
    
    if (self.tabBarController) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.orderDayTableView.width, 48)];
        view.backgroundColor = [UIColor clearColor];
        self.orderDayTableView.tableFooterView = view;
        self.orderSummaryTableView.tableFooterView = view;
    }
}


#pragma mark Load Data
- (void)dealErrorResponseWithTableView:(RefreshTableView *)tableview info:(NSDictionary *)dic
{
    [self showTotasViewWithMes:[dic objectForKey:@"result"]];
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
    self.orderSummaryTableView.refreshHeader.beginRefreshingBlock = ^(){
        
        ws.orderSummaryData = [[BaseModelMethod getOrderListArrayFormDicInfo:nil] mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [ws.orderSummaryTableView.refreshHeader endRefreshing];
            [ws.orderSummaryTableView reloadData];
        });
        return;
        
        [NetWorkEntiry getCourseinfoWithUserId:nil pageIndex:1 pageCount:RELOADDATACOUNT token:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
            
            if (type == 1) {
                ws.orderSummaryData = [[BaseModelMethod getOrderListArrayFormDicInfo:[responseObject objectArrayForKey:@"data"]] mutableCopy];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [ws.orderSummaryTableView.refreshHeader endRefreshing];
                    [ws.orderSummaryTableView reloadData];
                });
            }else{
                [ws dealErrorResponseWithTableView:ws.orderSummaryTableView info:responseObject];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [ws netErrorWithTableView:ws.orderSummaryTableView];
        }];
    };
    
    self.orderSummaryTableView.refreshFooter.beginRefreshingBlock = ^(){
        
        [NetWorkEntiry getCourseinfoWithUserId:nil pageIndex:1 pageCount:RELOADDATACOUNT token:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
            if (type == 1) {
                NSArray * listArray = [BaseModelMethod getOrderListArrayFormDicInfo:[responseObject objectArrayForKey:@"data"]];
                if (listArray.count) {
                    [ws.orderSummaryData addObjectsFromArray:listArray];
                    [ws.orderSummaryTableView reloadData];
                }else{
                    [ws showTotasViewWithMes:@"已经加载所有数据"];
                }
                [ws.orderSummaryTableView.refreshFooter endRefreshing];
            }else{
                [ws dealErrorResponseWithTableView:ws.orderSummaryTableView info:responseObject];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [ws netErrorWithTableView:ws.orderSummaryTableView];
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
    NSLog(@"%@",dataStr);
    self.orderDayTableData = [[BaseModelMethod getOrderListArrayFormDicInfo:nil] mutableCopy];
    [self.orderDayTableView reloadData];
    return;
    
    [NetWorkEntiry getAllCourseInfoWithUserId:nil DayTime:dataStr token:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}



#pragma mark - DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.orderSummaryTableView) {
        return self.orderSummaryData.count;
    }else{
        return self.orderDayTableData.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.orderSummaryTableView) {
        return [OrderSummaryListCell cellHeight];
    }else{
        return [OrderSummaryDayCell cellHeight];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.orderSummaryTableView) {
        OrderSummaryListCell * sumCell = [tableView dequeueReusableCellWithIdentifier:@"SumCell"];
        if (!sumCell) {
            sumCell = [[OrderSummaryListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SumCell"];
        }
        if (indexPath.row < self.orderSummaryData.count)
            [sumCell setModel:self.orderSummaryData[indexPath.row]];
        return sumCell;
    }else{
        OrderSummaryDayCell * dayCell = [tableView dequeueReusableCellWithIdentifier:@"dayCell"];
        if (!dayCell) {
            dayCell = [[OrderSummaryDayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"dayCell"];
        }
        if (indexPath.row < self.orderDayTableData.count)
            [dayCell setModel:self.orderDayTableData[indexPath.row]];
        
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
    HMOrderModel  * orderModel = nil;
    if (tableView == self.orderSummaryTableView) {
        orderModel = [[self orderSummaryData] objectAtIndex:indexPath.row];
    }else{
        orderModel = [[self orderDayTableData] objectAtIndex:indexPath.row];
    }
    if (orderModel) {
        OrderDetailViewController * decv = [[OrderDetailViewController alloc] init];
        decv.orderModel = orderModel;
        [self.navigationController pushViewController:decv animated:YES];
    }
}

@end