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

#import "CourseSummaryDayCell.h"
#import "CourseDetailViewController.h"
#import "NoContentTipView.h"
#import "WMUITool.h"

@interface CourseViewController () <UITableViewDataSource,UITableViewDelegate,RFSegmentViewDelegate>

@property(nonatomic,strong)UISegmentedControl * segController;
@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,strong)RefreshTableView * courseSummaryTableView;
@property(nonatomic,strong)NSMutableArray * courseSummaryData;

@property(nonatomic,assign)BOOL isNeedRefresh;
@property(nonatomic,strong)NSDateFormatter *dateFormattor;
@property(nonatomic,strong)NoContentTipView * tipView1;
@property(nonatomic,strong)NoContentTipView * tipView2;

@end

@implementation CourseViewController

#pragma mark - LoingNotification
- (void)didLoginSucess:(NSNotification *)notification
{
    [self.courseSummaryTableView.refreshHeader beginRefreshing];
}

- (void)didLoginoutSucess:(NSNotification *)notifcation
{
  [self.courseSummaryTableView reloadData];
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
    
    [self resetNavBar];
    
    self.myNavigationItem.title = @"约车";
    
    [self.scrollView setContentOffset:CGPointMake(0 * self.scrollView.width, self.scrollView.contentOffset.y) animated:YES];
    
    [self setUpTableViewHead];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(self.isNeedRefresh){
        [self.courseSummaryTableView.refreshHeader beginRefreshing];
    }
    self.isNeedRefresh = NO;
}

#pragma mark - initUI

- (void)setUpTableViewHead
{
    RFSegmentView * segController = [[RFSegmentView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40) items:@[@"新订单",@"待评价",@"已取消",@"已完成"]];
    segController.backgroundColor = [UIColor whiteColor];
    segController.delegate = self;
    [segController setSeltedIndex:self.scrollView.contentOffset.x / self.scrollView.width];
    self.courseSummaryTableView.tableHeaderView = segController;
    
}

#pragma mark - Action
- (void)segmentViewSelectIndex:(NSInteger)index
{
    NSLog(@"刷新数据segmentViewSelectIndex:%ld",(long)index);
    if (index==0) {// 签到

        self.myNavigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"signBtnImg" highIcon:@"signBtnImg" target:self action:@selector(rightBarBtnWithQianDaoDidClick)];
        
    }else{// 搜索
        
        self.myNavigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"iconfont-chazhao-2" highIcon:@"iconfont-chazhao-2" target:self action:@selector(rightBarBtnWithSearchDidClick)];

    }
    
}

- (void)rightBarBtnWithQianDaoDidClick
{
    NSLog(@"签到");
}
- (void)rightBarBtnWithSearchDidClick
{
    NSLog(@"搜索");
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
    
    // 预约
    self.courseSummaryTableView = [[RefreshTableView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.width, self.scrollView.height) style:UITableViewStylePlain];
    self.courseSummaryTableView.delegate = self;
    self.courseSummaryTableView.dataSource = self;
    [self.scrollView addSubview:self.courseSummaryTableView];
    
    [self initRefreshView];
    
    //日程
    self.tipView1 = [[NoContentTipView alloc] initWithContetntTip:@"您现在没有预约"];
    [self.tipView1 setHidden:YES];
    [self.courseSummaryTableView addSubview:self.tipView1];
    self.tipView1.center = CGPointMake(self.courseSummaryTableView .width/2.f, self.courseSummaryTableView.height/2.f);
    
    self.tipView2 = [[NoContentTipView alloc] initWithContetntTip:@"您现在没有预约"];
    [self.tipView2 setHidden:YES];
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
            
            NSLog(@"responseObject:%@",responseObject);
            
            NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
            
            if (type == 1) {
                
                ws.courseSummaryData = [[BaseModelMethod getCourseListArrayFormDicInfo:[responseObject objectArrayForKey:@"data"]] mutableCopy];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [ws.courseSummaryTableView.refreshHeader endRefreshing];
                    
                    [ws.courseSummaryTableView reloadData];
                    
                    ws.courseSummaryTableView.refreshFooter.scrollView = ws.courseSummaryTableView;
                    
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
            ws.courseSummaryTableView.refreshFooter.scrollView = nil;
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

#pragma mark - DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    if (tableView == self.courseSummaryTableView) {
        count =  self.courseSummaryData.count;
        if (!self.isNeedRefresh)
            [self.tipView1 setHidden:count];
    }
    return count;
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
    }
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HMCourseModel  * courseModel = nil;
    if (tableView == self.courseSummaryTableView) {
        courseModel = [[self courseSummaryData] objectAtIndex:indexPath.row];
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

                [self.courseSummaryTableView reloadData];
                
                break;
            }
        }
    }
}

@end