//
//  OrderCompleteViewController.m
//  HeiMao_B
//
//  Created by kequ on 15/12/17.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "OrderCompleteViewController.h"
#import "RefreshTableView.h"
#import "CourseRatingUserInfoCell.h"
#import "CoursePicListCell.h"
#import "CourseDesInPutCell.h"
#import "CourseEnsureCell.h"
#import "HMCourseModel.h"

@interface OrderCompleteViewModel : NSObject
@property(nonatomic,strong)HMCourseModel * userInfo;
@property(nonatomic,strong)NSString * title;
@property(nonatomic,strong)NSArray * pickItemsDataList;
@property(nonatomic,strong)NSString * inputDes;
@end
@implementation OrderCompleteViewModel
@end


@interface OrderCompleteViewController()<UITableViewDelegate,UITableViewDataSource,CourseDesInPutCellDelegate,CourseEnsureCellDelegate>
@property(nonatomic,strong)RefreshTableView * tableView;
@property(nonatomic,strong)CourseDesInPutCell * inputCell;
@property(nonatomic,strong)OrderCompleteViewModel * model;
@property(nonatomic,assign)BOOL isNeedRefresh;
@end

@implementation OrderCompleteViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB_Color(247, 249, 251);
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addKeyBoradNotificaiton];
    [self initUI];
}


#pragma mark Life Sycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initNavBar];
}

#pragma mark - initUI
- (void)initNavBar
{
    [self resetNavBar];
    self.myNavigationItem.title = @"教学内容确定";
    UIButton *buttonRight = [self getBarButtonWithTitle:@"确定"];
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

- (void)initRefreshView
{
//    WS(ws);
//    [self.tableView refreshHeader].beginRefreshingBlock = ^(){
//        [NetWorkEntiry getCoureDetailInfoWithCouresId:self.couresID success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
//            if (type == 1) {
//                ws.model = [HMCourseModel converJsonDicToModel:[responseObject objectInfoForKey:@"data"]];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [ws.tableView.refreshHeader endRefreshing];
//                    [ws.tableView reloadData];
//                    [ws postNotificationMakeSummarRefreshUI];
//                });
//            }else{
//                [ws dealErrorResponseWithTableView:ws.tableView info:responseObject];
//            }
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            [ws netErrorWithTableView:ws.tableView];
//        }];
//    };
}


#pragma mark - Data
- (void)refreshModel
{
    
}

#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [CoursePicListCell cellHight:[[self model] pickItemsDataList].count couleNumber:1];
    }else if (indexPath.row == 1){
        return [CourseDesInPutCell cellHeight];
    }else if (indexPath.row == 2){
        return [CourseEnsureCell cellHeigthWithTitle:YES];
    }
    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        CoursePicListCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CoursePicListCell class])];
        if (!cell) {
            cell = [[CoursePicListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CoursePicListCell class])];
        }
        [cell.pickListView setTitle:self.model.title];
        cell.pickListView.pickItemArray = self.model.pickItemsDataList;
        return cell;
    }else if (indexPath.row == 1){
        
        CourseDesInPutCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CourseDesInPutCell class])];
        if (!cell) {
            cell = [[CourseDesInPutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CourseDesInPutCell class])];
            cell.delegate = self;
        }
        self.inputCell = cell;
        cell.placeLabel.text =  @"其他教学内容说明";
        return cell;
        
    }else if (indexPath.row == 2){
        CourseEnsureCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CourseEnsureCell class])];
        
        if (!cell) {
            cell = [[CourseEnsureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CourseEnsureCell class])];
            cell.delegate = self;
            [cell.ensurebutton setTitle:@"提交并去评价" forState:UIControlStateNormal];
            [cell.ensurebutton setTitle:@"提交并去评价" forState:UIControlStateHighlighted];
            [cell setTitle:@"评价有积分奖励。越用心的评价奖励约高哦"];
        }
        return cell;
        
    }
    
    return [UITableViewCell new];
}

#pragma mark - Action
#pragma makr - rightButtonClick
- (void)rightButtonDidClick:(UIButton *)button
{
    //确定
}

#pragma mark input
- (void)courseDesInPutCellDidTextViewWillChangeToString:(NSString *)str
{
    self.model.inputDes = str;
}

#pragma mark - ensureButton
- (void)courseCellDidEnstureClick:(CourseEnsureCell *)cell
{
    //提交并去评价
    
}

#pragma mark - KeyBoard
- (void)addKeyBoradNotificaiton
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardShow:(NSNotification*)notification
{
    if([self.inputCell.textView isFirstResponder]){
        [self.tableView setContentOffset:CGPointMake(self.tableView.contentOffset.x, self.inputCell.top - 10) animated:YES];
    }
}

- (void)keyboardHide:(NSNotification*)notification
{
    [self.tableView setContentOffset:CGPointMake(self.tableView.contentOffset.x, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIPanGestureRecognizer * pan = scrollView.panGestureRecognizer;
    CGPoint  velocityInView = [pan velocityInView:scrollView];
    if (velocityInView.y > 0) {
        [self.inputCell.textView resignFirstResponder];
    }
}

- (void)dealErrorResponseWithInfo:(NSDictionary *)dic
{
    [self showTotasViewWithMes:[dic objectForKey:@"msg"]];
}

#pragma mar - AlertView
- (void)showAlertView
{
    if (NSClassFromString(@"UIAlertController")) {
        UIAlertController * alertCont = [UIAlertController alertControllerWithTitle:nil message:@"操作成功" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * actionn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self alertView:[UIAlertView new] clickedButtonAtIndex:0];
        }];
        [alertCont addAction:actionn];
        [self presentViewController:alertCont animated:YES completion:nil];
    }else{
        UIAlertView * alerView = [[UIAlertView alloc] initWithTitle:nil message:@"操作成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alerView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    if ([_delegate respondsToSelector:@selector(courseCancelControllerDidOpeartionSucess:)]) {
//        [_delegate courseCancelControllerDidOpeartionSucess:self];
//    }
}

- (NSString *)seletedReasion
{
    NSString * str = nil;
    for (PickerItemModel * itemModel in self.model.pickItemsDataList) {
        if (itemModel.isSeleted) {
            str = itemModel.title;
        }
    }
    return str;
}

@end


