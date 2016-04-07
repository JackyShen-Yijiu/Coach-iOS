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
#import "CourseRatingCell.h"
#import "YBStudentDetailsViewController.h"

#define GOTORECOMENDTAG     1000

@interface OrderCompleteViewModel : NSObject
@property(nonatomic,strong)NSString * title;
@property(nonatomic,strong)NSArray * pickItemsDataListTwo;
@property(nonatomic,strong)NSArray * pickItemsDataListThree;
@property(nonatomic,strong)NSString * inputDes;
@end
@implementation OrderCompleteViewModel
@end


@interface OrderCompleteViewController()<UITableViewDelegate,UITableViewDataSource,CourseDesInPutCellDelegate,CourseEnsureCellDelegate>
@property(nonatomic,strong)RefreshTableView * tableView;
@property(nonatomic,strong)CourseDesInPutCell * inputCell;
@property(nonatomic,strong)OrderCompleteViewModel * model;
@property(nonatomic,strong)CourseRatingModel * ratModel;
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
    self.isNeedRefresh = YES;
    [self addKeyBoradNotificaiton];
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
    self.myNavigationItem.title = @"评价";
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
    WS(ws);
    [self.tableView refreshHeader].beginRefreshingBlock = ^(){
        [NetWorkEntiry getTrainContentSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
            if (type == 1) {
                NSDictionary * dataInfo = [responseObject objectInfoForKey:@"data"];
                NSArray * subTwo = [dataInfo objectArrayForKey:@"subjecttwo"];
                NSArray * subTree = [dataInfo objectArrayForKey:@"subjectthree"];
                ws.model.pickItemsDataListTwo = [ws trainpickListWithArray:subTwo];
                ws.model.pickItemsDataListThree = [ws trainpickListWithArray:subTree];
                [ws.tableView.refreshHeader endRefreshing];
                [ws.tableView reloadData];
                
            }else{
                [ws dealErrorResponseWithTableView:ws.tableView info:responseObject];
                [[self myNavController] popViewControllerAnimated:YES];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self showTotasViewWithMes:@"网络错误"];
            [[self myNavController] popViewControllerAnimated:YES];
        }];
    };
}

- (void)dealErrorResponseWithTableView:(RefreshTableView *)tableview info:(NSDictionary *)dic
{
    [self showTotasViewWithMes:[dic objectForKey:@"msg"]];
    [tableview.refreshHeader endRefreshing];
    [tableview.refreshFooter endRefreshing];
}


- (NSArray *)trainpickListWithArray:(NSArray *)array
{
    NSMutableArray * pickList = [NSMutableArray arrayWithCapacity:0];
    for (NSString * str in array) {
        PickerItemModel * pickerModel = [[PickerItemModel alloc] init];
        if ([str isKindOfClass:[NSString class]] && str.length) {
            pickerModel.title = str;
            [pickList addObject:pickerModel];
        }
    }
    return pickList;
}

#pragma mark - TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self pickList] ? 5 : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return [CourseRatingUserInfoCell cellHeigth];
            break;
        case 1:
            return [CoursePicListCell cellHight:[self pickList].count couleNumber:2];
            break;
        case 2:
            return [CourseRatingCell cellHigthWithBottomView:YES];
            break;
        case 3:
            return [CourseDesInPutCell cellHeight];
            break;
        case 4:
            return [CourseEnsureCell cellHeigthWithTitle:YES];
            break;
        default:
            break;
    }
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
        {
            CourseRatingUserInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CourseRatingUserInfoCell class])];
            if (!cell) {
                cell = [[CourseRatingUserInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CourseRatingUserInfoCell class])];
            }
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.model = self.courseModel.studentInfo;
            [cell.bottomView setHidden:NO];
            return cell;
        }
            break;
        case 1:
        {
            CoursePicListCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CoursePicListCell class])];
            if (!cell) {
                cell = [[CoursePicListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CoursePicListCell class])];
                cell.pickListView.couleNumber = 2;
            }
            [cell.pickListView setTitle:[NSString stringWithFormat:@"%@教学内容",self.courseModel.classType.classTypeName]];
            cell.pickListView.pickItemArray = [self pickList];
            return cell;
        }
            break;
            
        case 2:
            
        {
            CourseRatingCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CourseRatingCell class])];
            if (!cell) {
                cell = [[CourseRatingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CourseRatingCell class])];
                [cell.bottonLineView setHidden:YES];
                [cell.bottomView setHidden:NO];
            }
            [cell setModel:self.ratModel];
            
            return cell;

        }
            break;

        case 3:
        {
            CourseDesInPutCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CourseDesInPutCell class])];
            if (!cell) {
                cell = [[CourseDesInPutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CourseDesInPutCell class])];
                cell.delegate = self;
            }
            self.inputCell = cell;
            cell.placeLabel.text =  @"写点评论吧，对其他小伙伴有很大帮助哦";
            return cell;

        }
            break;
            
        case 4:
        {
            CourseEnsureCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CourseEnsureCell class])];
            
            if (!cell) {
                cell = [[CourseEnsureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CourseEnsureCell class])];
                cell.delegate = self;
                [cell.ensurebutton setTitle:@"提交" forState:UIControlStateNormal];
                [cell.ensurebutton setTitle:@"提交" forState:UIControlStateHighlighted];
                [cell setTitle:@"评价有积分奖励。越用心的评价奖励约高哦"];
            }
            return cell;
        }
            break;
        default:
            break;
    }    
    return [UITableViewCell new];
}

#pragma mark - Action
#pragma makr - rightButtonClick
- (void)rightButtonDidClick:(UIButton *)button
{
    //确定
    [self enstureThenGotoRecomend:NO];
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
    [self enstureThenGotoRecomend:YES];
}

- (void)enstureThenGotoRecomend:(BOOL)isGoTorecomed
{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(ws);
    [NetWorkEntiry postToEnstureDoneofCourseWithCoachid:[[UserInfoModel defaultUserInfo] userID]
                                              coureseID:self.courseModel.courseId
                                        learningcontent:[self seletedReasion]
                                         contentremarks:self.model.inputDes
                                             startLevel:self.ratModel.rating
                                                success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        if (type == 1) {
            [self showAlertView:isGoTorecomed];
        }else{
            [ws dealErrorResponseWithTableView:nil info:responseObject];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [ws showTotasViewWithMes:@"网络异常"];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        YBStudentDetailsViewController * sudH = [[YBStudentDetailsViewController alloc] init];
        sudH.studentID = self.courseModel.studentInfo.userId;
        [self.navigationController pushViewController:sudH animated:YES];
    }
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
- (void)showAlertView:(BOOL)isGoToRecomend
{
    if (NSClassFromString(@"UIAlertController")) {
        UIAlertController * alertCont = [UIAlertController alertControllerWithTitle:nil message:@"操作成功" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * actionn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIAlertView * alertView = [UIAlertView new];
            alertView.tag = isGoToRecomend ? GOTORECOMENDTAG : 0;
            [self alertView:alertView clickedButtonAtIndex:0];
        }];
        [alertCont addAction:actionn];
        [self presentViewController:alertCont animated:YES completion:nil];
    }else{
        UIAlertView * alerView = [[UIAlertView alloc] initWithTitle:nil message:@"操作成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alerView.tag = isGoToRecomend ? GOTORECOMENDTAG : 0;
        [alerView show];

    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([_delegate respondsToSelector:@selector(orderCompleteViewControllerDidEnsutreSucess::)]) {
        [_delegate orderCompleteViewControllerDidEnsutreSucess:self :alertView.tag == GOTORECOMENDTAG];
    }
}

- (NSString *)seletedReasion
{
    NSString * str = nil;
    for (PickerItemModel * itemModel in [self pickList]) {
        if (itemModel.isSeleted) {
            str = itemModel.title;
        }
    }
    return str;
}


#pragma mark - Get

- (NSArray *)pickList
{
    if ([self.courseModel.classType.classTypeName isEqualToString:@"科目二"]) {
        return [[self model] pickItemsDataListTwo];
    }else if ([self.courseModel.classType.classTypeName isEqualToString:@"科目三"]) {
        return [[self model] pickItemsDataListThree];
    }
    return nil;
}

- (OrderCompleteViewModel*)model
{
    if (!_model) {
        _model = [[OrderCompleteViewModel alloc] init];
    }
    return _model;
}
- (CourseRatingModel *)ratModel
{
    if (!_ratModel) {
        _ratModel = [[CourseRatingModel alloc] init];
        _ratModel.title = @"总体评价";
        _ratModel.type = KRateTypeAll;
        _ratModel.rating = 5.f;
    }
    return _ratModel;
}

@end


