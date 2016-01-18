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


#import "CourseDetailViewController.h"
#import "NoContentTipView.h"
#import "WMUITool.h"
#import "ScanViewController.h"
#import "UINavigationBar+JGNavigationBar.h"
#import "SearchCourseViewController.h"

@interface CourseViewController () <UITableViewDataSource,UITableViewDelegate,RFSegmentViewDelegate>

@property(nonatomic,strong) RFSegmentView * segController;
@property(nonatomic,strong)RefreshTableView * courseSummaryTableView;

/*
 *  新订单
 */
@property(nonatomic,strong)NSMutableArray * courseSummaryData;
/*
 *  待评价
 */
@property(nonatomic,strong)NSMutableArray * courseSummaryDataWaitEvaluate;
/*
 *  已取消
 */
@property(nonatomic,strong)NSMutableArray * courseSummaryDataCancled;
/*
 *  已完成
 */
@property(nonatomic,strong)NSMutableArray * courseSummaryDataCompleted;

@property(nonatomic,assign)BOOL isNeedRefresh;
@property(nonatomic,strong)NSDateFormatter *dateFormattor;
@property(nonatomic,strong)NoContentTipView * tipView1;

@property (nonatomic,assign)NSInteger reservationstate;

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
    
    [self initUI];
    
    [self addNotification];
}

#pragma mark Life Sycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self resetNavBar];
    
    [self setUpRightNavBar];
    
    self.myNavigationItem.title = @"约车";
    
}

- (void)setUpRightNavBar
{
    if (self.segController.selIndex==0) {// 签到
        self.myNavigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"signBtnImg" highIcon:@"signBtnImg" target:self action:@selector(rightBarBtnWithQianDaoDidClick)];
    }else{// 搜索
        self.myNavigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"iconfont-chazhao-2" highIcon:@"iconfont-chazhao-2" target:self action:@selector(rightBarBtnWithSearchDidClick)];
    }

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    if(self.isNeedRefresh){
//        [self.courseSummaryTableView.refreshHeader beginRefreshing];
//        self.isNeedRefresh = NO;
//    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 规置导航
    [self.myNavController.navigationBar lt_reset];
    self.view.transform = CGAffineTransformMakeTranslation(0, 0);
    [self setNavgationBarTransformProess:0];
    self.myNavController.navigationBar.backIndicatorImage = [UIImage new];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
   // NSLog(@"offsetY:%f",offsetY);
    
    if (offsetY>0) {
        
        if (offsetY>=44) {
        
            [self setNavgationBarTransformProess:1];
            
        }else{
            
            [self setNavgationBarTransformProess:(offsetY/44)];
        }
        
    }else{
        
        self.view.transform = CGAffineTransformMakeTranslation(0, 0);
        
        [self setNavgationBarTransformProess:0];
        self.myNavController.navigationBar.backIndicatorImage = [UIImage new];
        
    }
  
}

- (void)setNavgationBarTransformProess:(CGFloat)progress
{
    self.view.transform = CGAffineTransformMakeTranslation(0, (-44*progress));
    
    [self.myNavController.navigationBar lt_setTranslationY:(-44*progress)];
    [self.myNavController.navigationBar lt_setContentAlpha:(1-progress)];
    
}

#pragma mark - Action
- (void)segmentViewSelectIndex:(NSInteger)index
{
    
    self.segController.selIndex = index;
    
    NSLog(@"刷新数据segmentViewSelectIndex:%ld",(long)index);
    [self setUpRightNavBar];

    if (index==0) {
        self.reservationstate = 3;
    }else if (index==1){
        self.reservationstate = 6;
    }else if (index==2){
        self.reservationstate = 2;
    }else if (index==3){
        self.reservationstate = 7;
    }
    
    [self.courseSummaryTableView reloadData];
    
    [self.courseSummaryTableView.refreshHeader beginRefreshing];

}

- (void)rightBarBtnWithQianDaoDidClick
{
    NSLog(@"签到");
    ScanViewController *vc = [[ScanViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)rightBarBtnWithSearchDidClick
{
    NSLog(@"搜索");
    SearchCourseViewController *vc = [[SearchCourseViewController alloc] init];

    vc.reservationstate = self.reservationstate;
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)initUI
{
    // 头部tab
    self.segController = [[RFSegmentView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40) items:@[@"新订单",@"待评价",@"已取消",@"已完成"]];
    self.segController.backgroundColor = [UIColor whiteColor];
    self.segController.delegate = self;
    [self.segController setSeltedIndex:0];
    [self.view addSubview:self.segController];

    // 预约
    self.courseSummaryTableView = [[RefreshTableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.segController.frame), self.view.width, self.view.height-64-40) style:UITableViewStylePlain];
    self.courseSummaryTableView.backgroundColor = RGB_Color(251, 251, 251);
    self.courseSummaryTableView.delegate = self;
    self.courseSummaryTableView.dataSource = self;
    [self.view addSubview:self.courseSummaryTableView];
    
    [self initRefreshView];
    
    //日程
    self.tipView1 = [[NoContentTipView alloc] initWithContetntTip:@"无内容"];
    [self.tipView1 setHidden:YES];
    [self.courseSummaryTableView addSubview:self.tipView1];
    self.tipView1.center = CGPointMake(self.courseSummaryTableView .width/2.f, self.courseSummaryTableView.height/2.f);
   
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
        
        [NetWorkEntiry getCourseinfoWithUserId:[[UserInfoModel defaultUserInfo] userID] reservationstate:ws.reservationstate pageIndex:1 pageCount:RELOADDATACOUNT success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"responseObject:%@",responseObject);
            
            NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
            NSArray *data = [responseObject objectArrayForKey:@"data"];
            
            if (type == 1) {
                
                if (ws.segController.selIndex==0) {
                    ws.courseSummaryData = [[BaseModelMethod getCourseListArrayFormDicInfo:data] mutableCopy];
                }else if (ws.segController.selIndex==1){
                    ws.courseSummaryDataWaitEvaluate = [[BaseModelMethod getCourseListArrayFormDicInfo:data] mutableCopy];
                }else if (ws.segController.selIndex==2){
                    ws.courseSummaryDataCancled = [[BaseModelMethod getCourseListArrayFormDicInfo:data] mutableCopy];
                }else if (ws.segController.selIndex==3){
                    ws.courseSummaryDataCompleted = [[BaseModelMethod getCourseListArrayFormDicInfo:data] mutableCopy];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [ws.courseSummaryTableView.refreshHeader endRefreshing];
                    
                    [ws.courseSummaryTableView reloadData];
                    
                    if (data.count>=10) {
                        ws.courseSummaryTableView.refreshFooter.scrollView = ws.courseSummaryTableView;
                    }else{
                        ws.courseSummaryTableView.refreshFooter.scrollView = nil;
                    }
                    
                });
                
            }else{
                [ws dealErrorResponseWithTableView:ws.courseSummaryTableView info:responseObject];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [ws netErrorWithTableView:ws.courseSummaryTableView];
        }];
    };
    
    self.courseSummaryTableView.refreshFooter.beginRefreshingBlock = ^(){
        
        NSArray *dataArray = [NSArray array];
        
        if (ws.segController.selIndex==0) {
            dataArray = ws.courseSummaryData;
        }else if (ws.segController.selIndex==1){
            dataArray = ws.courseSummaryDataWaitEvaluate;
        }else if (ws.segController.selIndex==2){
            dataArray = ws.courseSummaryDataCancled;
        }else if (ws.segController.selIndex==3){
            dataArray = ws.courseSummaryDataCompleted;
        }
        
        if(dataArray.count % RELOADDATACOUNT){
            [ws showTotasViewWithMes:@"已经加载所有数据"];
            if (ws.courseSummaryTableView.refreshFooter) {
                [ws.courseSummaryTableView.refreshFooter endRefreshing];
                ws.courseSummaryTableView.refreshFooter.scrollView = nil;
            }
            return ;
        }
        
        [NetWorkEntiry getCourseinfoWithUserId:[[UserInfoModel defaultUserInfo] userID]  reservationstate:ws.reservationstate pageIndex:dataArray.count / RELOADDATACOUNT pageCount:RELOADDATACOUNT success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
            if (type == 1) {
                
                NSArray * listArray = [BaseModelMethod getCourseListArrayFormDicInfo:[responseObject objectArrayForKey:@"data"]];

                if (listArray.count) {
                    
                    if (ws.segController.selIndex==0) {
                        
                        [ws.courseSummaryData addObjectsFromArray:listArray];
                        
                    }else if (ws.segController.selIndex==1){
                        
                        [ws.courseSummaryDataWaitEvaluate addObjectsFromArray:listArray];
                        
                    }else if (ws.segController.selIndex==2){
                        
                        [ws.courseSummaryDataCancled addObjectsFromArray:listArray];
                        
                    }else if (ws.segController.selIndex==3){
                        
                        [ws.courseSummaryDataCompleted addObjectsFromArray:listArray];
                        
                    }
                    
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
        if (self.segController.selIndex==0) {
            
            count =  self.courseSummaryData.count;
            
        }else if (self.segController.selIndex==1){
            
            count =  self.courseSummaryDataWaitEvaluate.count;
            
        }else if (self.segController.selIndex==2){
            
            count =  self.courseSummaryDataCancled.count;
            
        }else if (self.segController.selIndex==3){
            
            count =  self.courseSummaryDataCompleted.count;
            
        }
        
        if (!self.isNeedRefresh)
            [self.tipView1 setHidden:count];
    }
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.courseSummaryTableView) {
        if (self.segController.selIndex==0) {
            
            return [CourseSummaryListCell cellHeightWithModel:self.courseSummaryData[indexPath.row]];

        }else if (self.segController.selIndex==1){
            
            return [CourseSummaryListCell cellHeightWithModel:self.courseSummaryDataWaitEvaluate[indexPath.row]];

        }else if (self.segController.selIndex==2){
            
            return [CourseSummaryListCell cellHeightWithModel:self.courseSummaryDataCancled[indexPath.row]];

        }else if (self.segController.selIndex==3){
            
            return [CourseSummaryListCell cellHeightWithModel:self.courseSummaryDataCompleted[indexPath.row]];

        }
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
        if (self.segController.selIndex==0) {
            if (indexPath.row < self.courseSummaryData.count)
                [sumCell setModel:self.courseSummaryData[indexPath.row]];
        }else if (self.segController.selIndex==1){
            if (indexPath.row < self.courseSummaryDataWaitEvaluate.count)
                [sumCell setModel:self.courseSummaryDataWaitEvaluate[indexPath.row]];
        }else if (self.segController.selIndex==2){
            if (indexPath.row < self.courseSummaryDataCancled.count)
                [sumCell setModel:self.courseSummaryDataCancled[indexPath.row]];
        }else if (self.segController.selIndex==3){
            if (indexPath.row < self.courseSummaryDataCompleted.count)
                [sumCell setModel:self.courseSummaryDataCompleted[indexPath.row]];
        }
        
        return sumCell;
    }
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HMCourseModel  * courseModel = nil;
    
    CourseDetailViewController * decv = [[CourseDetailViewController alloc] init];

    if (tableView == self.courseSummaryTableView) {
        if (self.segController.selIndex==0) {
           
            courseModel = [[self courseSummaryData] objectAtIndex:indexPath.row];
            decv.courseTitle = @"新订单";
            
        }else if (self.segController.selIndex==1){
            
            courseModel = [[self courseSummaryDataWaitEvaluate] objectAtIndex:indexPath.row];
            decv.courseTitle = @"待评价";
            
        }else if (self.segController.selIndex==2){
            
            courseModel = [[self courseSummaryDataCancled] objectAtIndex:indexPath.row];
            decv.courseTitle = @"已取消";

        }else if (self.segController.selIndex==3){
            
            courseModel = [[self courseSummaryDataCompleted] objectAtIndex:indexPath.row];
            decv.courseTitle = @"已完成";

        }
    }
    if (courseModel) {
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
    
     [self.courseSummaryTableView.refreshHeader beginRefreshing];

    return;
    /*
    HMCourseModel * model = [notification object];
    
    if (model) {
        
        NSArray *dataArray = [NSArray array];
        
        if (self.segController.selIndex==0) {
            
            dataArray = self.courseSummaryData;
            
        }else if (self.segController.selIndex==1){
            
            dataArray = self.courseSummaryDataWaitEvaluate;
            
        }else if (self.segController.selIndex==2){
            
            dataArray = self.courseSummaryDataCancled;
            
        }else if (self.segController.selIndex==3){
            
            dataArray = self.courseSummaryDataCompleted;
            
        }
        for (HMCourseModel * sumModel in dataArray) {
            
            if ([sumModel.courseId isEqualToString:model.courseId]) {
            
                sumModel.courseStatue = model.courseStatue;

                [self.courseSummaryTableView reloadData];
                
                break;
            }
        }
    }
     */
}

@end