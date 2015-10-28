//
//  SutdentHomeController.m
//  HeiMao_B
//
//  Created by kequ on 15/10/28.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "SutdentHomeController.h"
#import "RefreshTableView.h"
#import "HMStudentModel.h"
#import "BaseModelMethod.h"

#import "StudentHomeUserBasicInfoCell.h"
#import "StudentHomeUserCourseInfoCell.h"
#import "StudentHomeRecomendCell.h"

@interface SutdentHomeController()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)RefreshTableView * tableView;
@property(nonatomic,strong)HMStudentModel * model;
@property(nonatomic,strong)UIView * recomendTitle;
@property(nonatomic,assign)BOOL isNeedRefresh;

@end

@implementation SutdentHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.isNeedRefresh = YES;
}

#pragma mark Life Sycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initNavBar];
    [self initUI];
    
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
    self.title = @"学员详情";
    UIButton * buttonRight = [self getBarButtonWithTitle:@""];
    [buttonRight setImage:[UIImage imageNamed:@"tel_normal"] forState:UIControlStateNormal];
    [buttonRight setImage:[UIImage imageNamed:@"tel_click"] forState:UIControlStateHighlighted];
    [buttonRight addTarget:self action:@selector(telButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:buttonRight];
    self.myNavigationItem.rightBarButtonItems = @[[self barSpaingItem],item];
}

-(void)initUI
{
    UIView * view = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    
    self.tableView = [[RefreshTableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.refreshFooter = nil;
    [self.view addSubview:self.tableView];
    [self initRefreshView];
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
    self.tableView.refreshHeader.beginRefreshingBlock = ^(){
        
        ws.model = [HMStudentModel converJsonDicToModel:nil];
        ws.model.recommendArrays = [[BaseModelMethod getRecomendListArrayFormDicInfo:nil] mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            sleep(1.f);
            [ws.tableView.refreshHeader endRefreshing];
            [ws.tableView reloadData];
        });
        return;
        
    };
}


#pragma mark - TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.model ? 4 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 0;
    }
    if (section == 3) {
        return self.model.recommendArrays.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 2) {
        return [self recomendTitle].height;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 2){
        return self.recomendTitle;
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        return 20.f;
    }
    return 0.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
           return [StudentHomeUserBasicInfoCell cellHeigth];
            break;
        case 1:
            return [StudentHomeUserCourseInfoCell cellHeigth];
        case 3:
        {
            if (indexPath.row >= 0 && indexPath.row < self.model.recommendArrays.count) {
                HMRecomendModel * rModel = self.model.recommendArrays[indexPath.row];
                return [StudentHomeRecomendCell cellHigthWithModel:rModel];
            }
        }
            break;
        default:
            break;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identiy = nil;
    if (indexPath.section == 0) {
        identiy =  NSStringFromClass([StudentHomeUserBasicInfoCell class]);
        StudentHomeUserBasicInfoCell * basicCell = [tableView dequeueReusableCellWithIdentifier:identiy];
        if (!basicCell) {
            basicCell = [[StudentHomeUserBasicInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identiy];
        }
        [basicCell setBgImageUrlStr:self.model.porInfo.thumbnailpic userName:self.model.userName userId:self.model.userId];
        return basicCell;
    }else if (indexPath.section == 1){
        identiy =  NSStringFromClass([StudentHomeUserCourseInfoCell class]);
        StudentHomeUserCourseInfoCell * infoCell = [tableView dequeueReusableCellWithIdentifier:identiy];
        if (!infoCell) {
            infoCell = [[StudentHomeUserCourseInfoCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                            reuseIdentifier:identiy];
        }
        [infoCell setModel:self.model];
        return infoCell;
    }else if(indexPath.section == 3){
        identiy =  NSStringFromClass([StudentHomeRecomendCell class]);
        StudentHomeRecomendCell * recomendCell = [tableView dequeueReusableCellWithIdentifier:identiy];
        if (!recomendCell) {
            recomendCell = [[StudentHomeRecomendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identiy];
        }
        if (indexPath.row >= 0 && indexPath.row < self.model.recommendArrays.count) {
            recomendCell.model = self.model.recommendArrays[indexPath.row];
        }
        return recomendCell;
    }
    return [UITableViewCell new];
}

#pragma mark - Action
- (void)telButtonClick:(UIButton *)button
{
    
}


#pragma mark - GetMethod
- (UIView *)recomendTitle
{
    if (!_recomendTitle) {
        _recomendTitle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 32.f)];
        _recomendTitle.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, 18, _recomendTitle.width - 30, 14)];
        label.textColor = RGB_Color(0x33, 0x33, 0x33);
        label.font = [UIFont boldSystemFontOfSize:14.f];
        label.text = @"教练评论";
        [_recomendTitle addSubview:label];
    }
    return _recomendTitle;
}
@end
