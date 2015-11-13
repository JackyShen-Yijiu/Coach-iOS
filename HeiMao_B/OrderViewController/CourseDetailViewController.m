//
//  courseDetailViewController.m
//  HeiMao_B
//
//  Created by kequ on 15/10/27.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "CourseDetailViewController.h"
#import "CourseDetailView.h"
#import "SutdentHomeController.h"
#import "CourseCancelController.h"
#import "CoureseRatingController.h"
#import "RefreshTableView.h"
#import "CourseDetailViewCell.h"
#import "ChatViewController.h"

@interface CourseDetailViewController()<CourseDetailViewDelegate,UITableViewDataSource,UITableViewDelegate,CourseCancelControllerDelegate,CoureseRatingControllerDelegate>
@property(nonatomic,strong)RefreshTableView * tableView;
@property(nonatomic,strong)HMCourseModel * model;
@property(nonatomic,assign)BOOL isNeedRefresh;
@end
@implementation CourseDetailViewController

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
        [self.tableView.refreshHeader beginRefreshing];
    }
    self.isNeedRefresh = NO;
}

#pragma mark - initUI
- (void)initNavBar
{
    [self resetNavBar];
    self.myNavigationItem.title = @"预约详情";
    
    UIButton *buttonRight = [self getBarButtonWithTitle:@""];
    [buttonRight setImage:[UIImage imageNamed:@"conversation_normal"] forState:UIControlStateNormal];
    [buttonRight setImage:[UIImage imageNamed:@"conversation_press"] forState:UIControlStateNormal];
    [buttonRight addTarget:self action:@selector(rightButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:buttonRight];
    self.myNavigationItem.rightBarButtonItems = @[[self barSpaingItem],item];
}

-(void)initUI
{
    UIView * view = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    
    self.tableView = [[RefreshTableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64) style:
                      UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.refreshFooter = nil;
    [self.view addSubview:self.tableView];
    [self initRefreshView];
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
    [self.tableView refreshHeader].beginRefreshingBlock = ^(){
        [NetWorkEntiry getCoureDetailInfoWithCouresId:self.couresID success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
            if (type == 1) {
                ws.model = [HMCourseModel converJsonDicToModel:[responseObject objectInfoForKey:@"data"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [ws.tableView.refreshHeader endRefreshing];
                    [ws.tableView reloadData];
                    [ws postNotificationMakeSummarRefreshUI];
                });
            }else{
                [ws dealErrorResponseWithTableView:ws.tableView info:responseObject];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [ws netErrorWithTableView:ws.tableView];
        }];
    };
}

#pragma mark TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model ? 1 : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CourseDetailView cellHeightWithModel:self.model];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identify = NSStringFromClass([CourseDetailViewCell class]);
    CourseDetailViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[CourseDetailViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.detailView.delegate = self;
    }
    cell.model = self.model;
    cell.detailView.model = self.model;
    [cell.detailView refreshUI];
    return cell;
}

#pragma mark - Action
#pragma mark Right
- (void)rightButtonDidClick:(UIButton *)button
{
    ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:@"5288" conversationType:eConversationTypeChat];
}


- (void)courseDetailViewDidClickAgreeButton:(CourseDetailView *)view
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [NetWorkEntiry postToDealRequestOfCoureseWithCoachid:[[UserInfoModel defaultUserInfo] userID] coureseID:self.model.courseId didReject:YES cancelreason:nil cancelcontent:nil  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        if (type == 1) {
            [self showTotasViewWithMes:@"操作成功"];
            [[[self tableView] refreshHeader] beginRefreshing];
        }else{
            [self dealErrorResponseWithTableView:nil info:responseObject];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self showTotasViewWithMes:@"网络异常"];
    }];
}

- (void)courseDetailViewDidClickDisAgreeButton:(CourseDetailView *)view
{
    //拒绝
    CourseCancelController * cour = [[CourseCancelController alloc] init];
    cour.courseId = self.model.courseId;
    cour.controllerType = KControllTypeReject;
    [self.navigationController pushViewController:cour animated:YES];
}

- (void)courseDetailViewDidClickCanCelButton:(CourseDetailView *)view
{
    //取消
    CourseCancelController * cour = [[CourseCancelController alloc] init];
    cour.delegate = self;
    cour.courseId = self.model.courseId;
    cour.controllerType = KControllTypeCancel;
    [self.navigationController pushViewController:cour animated:YES];
}


- (void)courseDetailViewDidClickWatingToDone:(CourseDetailView *)view
{
    //确定学完
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(ws);
    [NetWorkEntiry postToEnstureDoneofCourseWithCoachid:[[UserInfoModel defaultUserInfo] userID] coureseID:self.model.courseId learningcontent:nil contentremarks:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        if (type == 1) {
            [ws showTotasViewWithMes:@"操作成功"];
            [[[ws tableView] refreshHeader] beginRefreshing];
        }else{
            [ws dealErrorResponseWithTableView:nil info:responseObject];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [ws showTotasViewWithMes:@"网络异常"];
    }];
}

- (void)courseDetailViewDidClickRecommentButton:(CourseDetailView *)view
{
    //评论
    CoureseRatingController * crc = [[CoureseRatingController alloc] init];
    crc.courseId = self.model.courseId;
    crc.studentModel = self.model.studentInfo;
    crc.delegate = self;
    [self.navigationController pushViewController:crc animated:YES];
}


- (void)courseDetailViewDidClickStudentDetail:(CourseDetailView *)view
{
    SutdentHomeController * sudH = [[SutdentHomeController alloc] init];
    sudH.studentId = self.model.studentInfo.userId;
    [self.navigationController pushViewController:sudH animated:YES];
}

#pragma mark - delegate
- (void)courseCancelControllerDidOpeartionSucess:(CourseCancelController *)controller
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[self.tableView refreshHeader] beginRefreshing];
}

- (void)coureseRatingControllerDidOpeartionSucess:(CoureseRatingController *)controller
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[self.tableView refreshHeader] beginRefreshing];
}

- (void)postNotificationMakeSummarRefreshUI
{
    [[NSNotificationCenter defaultCenter] postNotificationName:KCourseViewController_NeedRefresh object:self.model];
}
@end
