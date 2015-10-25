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
#import "OrderSummaryDayCell.h"

@interface OrderViewController () <UITableViewDataSource,UITableViewDelegate,RFSegmentViewDelegate>

@property(nonatomic,strong)UISegmentedControl * segController;
@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,strong)RefreshTableView * orderSummaryTableView;
@property(nonatomic,strong)NSMutableArray * orderSummaryData;

@property(nonatomic,strong)RefreshTableView * orderDayTableView;
@property(nonatomic,strong)NSMutableArray * orderTableData;

@property(nonatomic,assign)BOOL isNeedRefresh;

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
    
    self.orderDayTableView = [[RefreshTableView alloc] initWithFrame:CGRectMake(self.scrollView.width, 0, self.scrollView.width, self.scrollView.height) style:UITableViewStylePlain];
    self.orderDayTableView.delegate = self;
    self.orderDayTableView.dataSource = self;
    [self.scrollView addSubview:self.orderDayTableView];
    [self initRefreshView];
    
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


#pragma mark - DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.orderSummaryTableView) {
        return self.orderSummaryData.count;
    }else{
        return self.orderTableData.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.orderSummaryTableView) {
        return [OrderSummaryListCell cellHeight];
    }else{
        return 0;
//        return [FacrotyFeedViewCell cellHeight];
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
//        GoodsFeedViewCell * gCell = [tableView dequeueReusableCellWithIdentifier:@"GCELL"];
//        if (!gCell) {
//            gCell = [[GoodsFeedViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GCELL"];
//            gCell.delegate = self;
//        }
//        if (indexPath.row < self.goodsFeedsModel.feedsList.count)
//            [gCell setModel:self.goodsFeedsModel.feedsList[indexPath.row]];
//        
//        return gCell;
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
    if (tableView == self.orderSummaryTableView) {
//        HMOrderModel * model = [[self orderSummaryData] objectAtIndex:indexPath.row];
//        FactoryViewController * fac = [[FactoryViewController alloc] initWithFactoryId:model.factoryId facoryCode:model.factoryName];
//        [self.navigationController pushViewController:fac animated:YES];
    }else{
//        GoodsModel * model = [[[self goodsFeedsModel] feedsList] objectAtIndex:indexPath.row];
//        GoodsDetailController * detailC = [[GoodsDetailController alloc] init];
//        detailC.goodsID = model.goodsID;
//        [self.navigationController pushViewController:detailC animated:YES];
    }
}

@end