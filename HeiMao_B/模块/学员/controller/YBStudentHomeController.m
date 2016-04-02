//
//  YBStudentHomeController.m
//  HeiMao_B
//
//  Created by JiangangYang on 16/3/25.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "YBStudentHomeController.h"
#import "JZHomeStudentToolBarView.h"

#import "JZHomeStudentSubjectOneView.h"
#import "JZHomeStudentSubjectTwoView.h"
#import "JZHomeStudentSubjectThreeView.h"
#import "JZHomeStudentSubjectFourView.h"
#import "JZHomeStudentViewModel.h"
#import "RefreshTableView.h"
#import "JZHomeStudentListCell.h"
#import "MJRefreshFooter.h"
#import "MJRefreshHeader.h"
#import "MJRefresh.h"
#import "JZResultModel.h"
#import <YYModel.h>
#import "BLPFAlertView.h"
#import "JZCompletionConfirmationContriller.h"
#import "YBStudentDetailsViewController.h"
#import "ChatViewController.h"
//#import <MJRefreshHeader.h>
//#import <MJRefreshFooter.h>
//#import <MJRefresh/MJRefresh.h>

#define YBRatio 1.15
#define ScreenWidthIs_6Plus_OrWider [UIScreen mainScreen].bounds.size.width >= 414

#define ktopHight 112

#define ktopSmallHight 65

#define kbottmWith 44

#define ksegmentH 36

@interface YBStudentHomeController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) RefreshTableView *tableView;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UISegmentedControl *segment;

@property (nonatomic, strong) JZHomeStudentToolBarView *toolBarView;

@property (nonatomic, assign) BOOL isshowSegment; // 是否显示segment控件,当授课科目只有一个时,不显示

@property (nonatomic, assign) CGFloat bgH;

@property (nonatomic, strong) NSString *oneStr;

@property (nonatomic, strong) NSString *twoStr;

@property (nonatomic, strong) NSString *threeStr;

@property (nonatomic, strong) NSString *fourStr;

@property (nonatomic, strong) JZHomeStudentViewModel *studentViewModel;

@property (nonatomic, assign) NSInteger subjectID;  // 科目的选择

@property (nonatomic, assign) NSInteger studentState; // 学员状态的选择

@property (nonatomic, strong) NSMutableArray *resultDataArray;


@property (nonatomic, strong) NSArray *subjectIDArray;   // 根据教练授课科目 排序好的subjectID
@end

@implementation YBStudentHomeController
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.myNavigationItem.rightBarButtonItem = nil;
    self.myNavigationItem.leftBarButtonItem = nil;
    self.myNavigationItem.title = nil;
    self.myNavigationItem.titleView = nil;
    
    // 设置里面可以更改授课科目 所以在这里要动态的改变segment 和 toolBarView 的位置坐标
    [self changeBgViewFrame];
    
    [self initRefreshView];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self initShowNOBG];
    
}

#pragma mark ---- 根据数据判断是否显示暂无字样
- (void)initShowNOBG{
    // 开始是全部置为可点击状态,
    NSArray *viewArray = [_toolBarView subviews];
    for (UIView *view in viewArray) {
        if ([view isKindOfClass:[UIButton class]]) {
            view.userInteractionEnabled = YES;
        }
    }
    [NetWorkEntiry getAllSubjectNumberStateWithCoachId:[UserInfoModel defaultUserInfo].userID subjectID:[NSString stringWithFormat:@"%lu",_subjectID] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *param = responseObject;
        NSLog(@"pass= responseObject= %@ _subjectID=%lu",responseObject, _subjectID);
        if (1 == [param[@"type"] integerValue]) {
            /*
             {
             "type": 1,
             "msg": "",
             "data": {
             "studentcount": 26, // 全部学员
             "onstudystudentcount": 21, // 在学学员
             "noexamstudentcount": 0, // 未考学员
             "reservationstudentcount": 0, // 约考学员
             "nopassstudentcount": 0, // 补考学员
             "passstudentcount": 4 // 通过学员
             }
             }
             */
            NSDictionary *data = param[@"data"];
            if (0 == [data[@"studentcount"] integerValue]) {
                [self showBgTitleWith:0];
            }
            if (0 == [data[@"noexamstudentcount"] integerValue]) {
                [self showBgTitleWith:1];
            }
            if (0 == [data[@"reservationstudentcount"] integerValue]) {
                [self showBgTitleWith:2];
            }
            if (0 == [data[@"nopassstudentcount"] integerValue]) {
                [self showBgTitleWith:3];
            }
            if (0 == [data[@"passstudentcount"] integerValue]) {
                [self showBgTitleWith:4];
            }
            
        }
        else {
            [self showTotasViewWithMes:param[@"msg"]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self showTotasViewWithMes:@"网络错误"];
    }];
    
    
    [self.tableView.refreshHeader beginRefreshing];

}
- (void)showBgTitleWith:(NSInteger )tag{
    
    NSArray *viewArray = [_toolBarView subviews];
    for (UIView *view in viewArray) {
        if ([view isKindOfClass:[UIButton class]]) {
            if (view.tag == tag) {
                view.userInteractionEnabled = NO;
                CGRect rect = view.bounds;
                UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(rect.origin.x + 20, rect.origin.y + 10, 40, 27)];
                
                img.image = [UIImage imageNamed:@"flage_null"];
                [view addSubview:img];
                
            }
        }
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    _isshowSegment = YES;
    _resultDataArray = [NSMutableArray array]
    ;    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
    [self setNavBar];
    [self.view addSubview:self.tableView];
    
//    [self.tableView.header beginRefreshing];
    
    
}
- (void)changeBgViewFrame{
    _isshowSegment = YES;
    self.myNavigationItem.title = @"学员";
    NSArray *sujectArray = [UserInfoModel defaultUserInfo].subject;
    if (sujectArray.count == 1) {
        _isshowSegment = NO;
        NSDictionary *dic = sujectArray.firstObject;
        self.myNavigationItem.title = dic[@"name"];
        _subjectID = [dic[@"subjectid"] integerValue];
        
    }
    _isshowSegment ? (_bgH = ktopHight) : (_bgH = ktopSmallHight);
    [self initUI];
}

- (void)initUI{
    
    [_bgView removeFromSuperview];
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, _bgH)];
    _bgView.backgroundColor = [UIColor whiteColor];
    if (_isshowSegment) {
        
        // 显示segmnet
        NSArray *subject =  [UserInfoModel defaultUserInfo].subject;
        NSMutableArray *titleArray = [NSMutableArray array];
        
        for (NSDictionary *dic in subject) {
            [titleArray addObject:dic[@"subjectid"]];
        }
        
        // 冒泡排序后将_id转化为相应的科目文字
        _subjectIDArray = [self bubbleSort:titleArray];
        _subjectID = [[_subjectIDArray firstObject] integerValue];
        _studentState = 0;
        NSMutableArray *resultMustArray = [NSMutableArray array];
        NSString *str = nil;
        for (NSNumber *_id in _subjectIDArray) {
            
            if ( [_id isEqualToNumber:@1]) {
                str = @"科目一";
                _oneStr = str;
                [resultMustArray addObject:str];
            }
            if ( [_id isEqualToNumber:@2]) {
                str = @"科目二";
                _twoStr = str;
                [resultMustArray addObject:str];
            }
            if ( [_id isEqualToNumber:@3]) {
                str = @"科目三";
                _threeStr = str;
                [resultMustArray addObject:str];
            }
            if ( [_id isEqualToNumber:@4]) {
                str = @"科目四";
                _fourStr = str;
                [resultMustArray addObject:str];
            }
        }
        _segment = [[UISegmentedControl alloc] initWithItems:resultMustArray];
        // segmnetW 根据 教练所授课科目自由伸缩;
        CGFloat segmentX  = 50;
        CGFloat segmentW = (self.view.width - segmentX * 2) * resultMustArray.count / 3;
        CGFloat segmentH = ksegmentH;
        _segment.frame = CGRectMake(0, 10, segmentW, segmentH);
        _segment.centerX = self.view.centerX;
        _segment.tintColor = JZ_MAIN_COLOR;
        [_segment addTarget:self action:@selector(didClicksegmentedControlAction:) forControlEvents:UIControlEventValueChanged];
        _segment.selectedSegmentIndex = 0;
        
        // 添加segment 控件
        [_bgView addSubview:_segment];
        
    }
    // 不显示时不添加 segment 控件
    [self.bgView addSubview:self.toolBarView];
    [self.view addSubview:self.bgView];
    if (!_isshowSegment) {
        _tableView.frame = CGRectMake(0, _bgH + 64, self.view.width, self.view.height - _bgH - 45);
    }else{
        _tableView.frame = CGRectMake(0, ktopHight + 64, self.view.width, self.view.height - ktopHight - 64);
    }
    
    
}
- (void)setNavBar{
    self.myNavigationItem.title = nil;
    self.myNavigationItem.titleView = nil;
    self.myNavigationItem.rightBarButtonItem = nil;
    self.myNavigationItem.rightBarButtonItems = nil;
    self.myNavigationItem.leftBarButtonItem = nil;
    self.myNavigationItem.leftBarButtonItems = nil;

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
        NSLog(@"self.subjectID = %@",(NSString *)@(self.subjectID));
        
         NSLog(@"self.studentState = %@",(NSString *)@(self.studentState));
        WS(ws);
        self.tableView.refreshHeader.beginRefreshingBlock = ^(){
            [NetWorkEntiry coachStudentListWithCoachId:[[UserInfoModel defaultUserInfo] userID] subjectID:(NSString *)@(ws.subjectID) studentID:(NSString *)@(ws.studentState) index:1 count:10 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"responseObject=%@ subjectID=%@ State == %@  ",responseObject, (NSString *)@(ws.subjectID),(NSString *)@(ws.studentState) );
                NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
                NSArray *data = [responseObject objectArrayForKey:@"data"];
                if (type == 1) {
        
                    [ws.resultDataArray removeAllObjects];
                    
                    if (data.count == 0) {
                        [ws showTotasViewWithMes:@"暂无"];
                        [ws.tableView.refreshHeader endRefreshing];
                        [ws.tableView reloadData];
                        return ;
                    }
                    for (NSDictionary *dic in data) {
                        JZResultModel *model = [JZResultModel yy_modelWithDictionary:dic];
                        [ws.resultDataArray addObject:model];
                    }
                    
                        dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [ws.tableView.refreshHeader endRefreshing];
                        
                        [ws.tableView reloadData];
                        
                        if (data.count>=10) {
                            ws.tableView.refreshFooter.scrollView = ws.tableView;
                        }else{
                            ws.tableView.refreshFooter.scrollView = nil;
                        }
                        
                    });
                    
                }else{
                    [ws dealErrorResponseWithTableView:ws.tableView info:responseObject];
                }

            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [ws netErrorWithTableView:ws.tableView];
            }];
            
        };
        
        ws.tableView.refreshFooter.beginRefreshingBlock = ^(){
//                        NSArray *dataArray = [NSArray array];
        
                        if(_resultDataArray.count % RELOADDATACOUNT){
                            [ws showTotasViewWithMes:@"已经加载所有数据"];
                            if (ws.tableView.refreshFooter) {
                                [ws.tableView.refreshFooter endRefreshing];
                                ws.tableView.refreshFooter.scrollView = nil;
                            }
                            return ;
                        }
            
            [NetWorkEntiry coachStudentListWithCoachId:[[UserInfoModel defaultUserInfo] userID] subjectID:(NSString *)@(ws.subjectID) studentID:(NSString *)@(ws.studentState) index:_resultDataArray.count / RELOADDATACOUNT count:RELOADDATACOUNT success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
                                if (type == 1) {
                                    if (responseObject[@"data"]) {
                                        for (NSDictionary *dic in responseObject[@"data"]) {
                                            JZResultModel *model = [JZResultModel yy_modelWithDictionary:dic];
                                            [ws.resultDataArray addObject:model];
                                            [ws.tableView reloadData];
                                        }

                                    }else{
                                        [ws showTotasViewWithMes:@"已经加载所有数据"];
                                    }
                                    [ws.tableView.refreshFooter endRefreshing];
                                    
                                } else{
                                     [ws dealErrorResponseWithTableView:ws.tableView info:responseObject];
                                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [ws netErrorWithTableView:ws.tableView];
            }];
            
            

        };
        
    }

#pragma mark ---- segment的点击事件
- (void)didClicksegmentedControlAction:(UISegmentedControl *)Seg {
    NSInteger index = Seg.selectedSegmentIndex;
     _subjectID = [_subjectIDArray[index] integerValue];
    [_toolBarView selectItem:0];
    [self initShowNOBG];
    [self.tableView.refreshHeader  beginRefreshing];
    
}
#pragma mark 筛选条件
- (void)dvvToolBarViewItemSelectedAction:(NSInteger)index {
    
    if (0 == index) {
        _studentState = index;
        
    }else if (1 == index) {
        _studentState = index;
       
    }else if (2 == index) {
        _studentState = index;
        
    }
    else if (3 == index) {
        _studentState = index;
        
    }else if (4 == index) {
        _studentState = index;
        
    }
   [self.tableView.refreshHeader  beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (NSArray *)bubbleSort:(NSArray *)arg{//冒泡排序算法
    
    NSMutableArray *args = [NSMutableArray arrayWithArray:arg];
    
    for(int i=0;i<args.count-1;i++){
        
        for(int j=i+1;j<args.count;j++){
            
            if (args[i]>args[j]){
                
                int temp = [args[i] intValue];
                
                [args replaceObjectAtIndex:i withObject:args[j]];
                
                args[j] = @(temp);
                
            }
        }
    }
    return args;
}
#pragma mark ---- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _resultDataArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 98;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *IDCell = @"cellID";
    JZHomeStudentListCell *listCell = [tableView dequeueReusableCellWithIdentifier:IDCell];
    if (!listCell) {
        listCell = [[JZHomeStudentListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDCell];
    }
    listCell.listModel = _resultDataArray[indexPath.row];
    listCell.studentListMessageAndCall = ^(NSInteger tag){
        if (500 == tag) {
            // 信息
            JZResultModel *model = _resultDataArray[indexPath.row];
            [self messageWithModel:model];
        }
        if (501 == tag) {
            // 电话
            JZResultModel *model = _resultDataArray[indexPath.row];
            [self callPhonewithModel:model];
        }
    };
    return listCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 跳转学员详情页
    JZResultModel *model = _resultDataArray[indexPath.row];
    YBStudentDetailsViewController *studentDetailVC = [[YBStudentDetailsViewController alloc] init];
    studentDetailVC.studentID = model.userid;
    [self.navigationController pushViewController:studentDetailVC animated:YES];
}
#pragma mark ---- 电话
- (void)callPhonewithModel:(JZResultModel *)model{
    
        if (model.mobile == nil ||[model.mobile isEqualToString:@""]) {
            [self showTotasViewWithMes:@"该学员未录入电话!"];
            return;
        }
        
        [BLPFAlertView showAlertWithTitle:@"电话号码" message:model.mobile cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] completion:^(NSUInteger selectedOtherButtonIndex) {
            
            NSUInteger indexAlert = selectedOtherButtonIndex + 1;
            if (indexAlert == 1) {
                
                NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",model.mobile];
                UIWebView * callWebview = [[UIWebView alloc] init];
                [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
                [self.view addSubview:callWebview];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }else {
                return ;
            }
            
        }];
}

#pragma mark ---- 信息
- (void)messageWithModel:(JZResultModel *)model{
    NSLog(@"%s self.dmData.data.studentinfo.userid:%@",__func__,model.userid);
    
    ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:model.userid conversationType:eConversationTypeChat];
    chatController.title = model.name;
    [self.parentViewController.navigationController pushViewController:chatController animated:YES];

    
}

- (JZHomeStudentToolBarView *)toolBarView {
    
    // 这里没有用懒加载, 因为当设置里面的科目相应更改后, 这样要动态的调整
    [_toolBarView removeFromSuperview];
        _toolBarView = [JZHomeStudentToolBarView new];
    if (!_isshowSegment) {
         _toolBarView.frame = CGRectMake(0, 14, self.view.width, 52);
    }
    if (_isshowSegment) {
        _toolBarView.frame = CGRectMake(0, CGRectGetMaxY(self.segment.frame) + 14, self.view.width, 52);
    }
        _toolBarView.titleNormalColor = JZ_FONTCOLOR_LIGHT;
        _toolBarView.titleSelectColor = JZ_MAIN_COLOR;
        _toolBarView.followBarColor = JZ_MAIN_COLOR;
        
        _toolBarView.layer.shadowColor = [UIColor blackColor].CGColor;
        _toolBarView.layer.shadowOffset = CGSizeMake(0, 2);
        _toolBarView.layer.shadowOpacity = 0.036;
        _toolBarView.layer.shadowRadius = 2;
        _toolBarView.titleFont = [UIFont systemFontOfSize:12];
        _toolBarView.titleArray = @[ @"全部", @"未考",@"约考", @"补考",@"通过" ];
        _toolBarView.imgNormalArray = @[@"student_all_off",@"student_study_off",@"student_exam_off",@"student_examed_off",@"student_pass_off"];
    _toolBarView.imgSelectArray = @[@"student_all_on",@"student_study_on",@"student_exam_on",@"student_examed_on",@"student_pass_on"];
    
        __weak typeof(self) ws = self;
        [_toolBarView dvvToolBarViewItemSelected:^(UIButton *button) {
            [ws dvvToolBarViewItemSelectedAction:button.tag];
        }];
        
        if (ScreenWidthIs_6Plus_OrWider) {
            _toolBarView.titleFont = [UIFont systemFontOfSize:14*YBRatio];
        }
    return _toolBarView;
}
- (RefreshTableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[RefreshTableView alloc] initWithFrame:CGRectMake(0, ktopHight + 64, self.view.width, self.view.height - 45 - ktopHight - 64) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

@end
