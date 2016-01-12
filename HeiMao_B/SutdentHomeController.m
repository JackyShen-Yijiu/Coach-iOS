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
@property(nonatomic,strong)UIButton * buttonRight;
@property(nonatomic,strong)UIView * recomendTitle;
@property(nonatomic,assign)BOOL isNeedRefresh;
@property(nonatomic,strong)UIView * nextView;
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
    self.buttonRight = [self getBarButtonWithTitle:@""];
    [self.buttonRight setImage:[UIImage imageNamed:@"tel_normal"] forState:UIControlStateNormal];
    [self.buttonRight setImage:[UIImage imageNamed:@"tel_click"] forState:UIControlStateHighlighted];
    [self.buttonRight addTarget:self action:@selector(telButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonRight setHidden:YES];
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:self.buttonRight];
    self.myNavigationItem.rightBarButtonItems = @[[self barSpaingItem],item];
}

-(void)initUI
{
    UIView * view = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    
    self.tableView = [[RefreshTableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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
    self.tableView.refreshHeader.beginRefreshingBlock = ^(){
        
        [NetWorkEntiry getStudentAllInfoWithStudentId:ws.studentId success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
            if (type == 1) {
                ws.model = [HMStudentModel converJsonDicToModel:[responseObject objectInfoForKey:@"data"]];
                [NetWorkEntiry getAllRecomendWithUserID:ws.studentId WithIndex:1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
                    if (type == 1) {
                        ws.model.recommendArrays = [[BaseModelMethod getRecomendListArrayFormDicInfo:[responseObject objectArrayForKey:@"data"]] mutableCopy];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            ws.tableView.refreshFooter.scrollView = ws.tableView;
                            [ws.tableView.refreshHeader endRefreshing];
                            [ws.tableView reloadData];
                        });
                        
                        [ws.buttonRight setHidden:![ws.model.telPhoto length]];
                    }else{
                        [ws.buttonRight setHidden:YES];
                        [ws dealErrorResponseWithTableView:ws.tableView info:responseObject];
                    }
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    [ws netErrorWithTableView:ws.tableView];
                    [ws.buttonRight setHidden:YES];
                }];
                
            }else{
                [ws.buttonRight setHidden:YES];
                [ws dealErrorResponseWithTableView:ws.tableView info:responseObject];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [ws netErrorWithTableView:ws.tableView];
        }];
    };
    
    [self.tableView refreshFooter].beginRefreshingBlock = ^(){
        if(ws.model.recommendArrays.count % RELOADDATACOUNT){
            [ws showTotasViewWithMes:@"已经加载所有数据"];
            [ws.tableView.refreshFooter endRefreshing];
            ws.tableView.refreshFooter.scrollView = nil;
            return ;
        }
        
        [NetWorkEntiry getAllRecomendWithUserID:ws.studentId WithIndex:ws.model.recommendArrays.count / RELOADDATACOUNT success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
            if (type == 1) {
                NSArray * listArray = [BaseModelMethod getRecomendListArrayFormDicInfo:[responseObject objectArrayForKey:@"data"]];
                if (listArray.count) {
                    [ws.model.recommendArrays addObjectsFromArray:listArray];
                    [ws.tableView reloadData];
                }else{
                    [ws showTotasViewWithMes:@"已经加载所有数据"];
                }
                
                [ws.tableView.refreshFooter endRefreshing];
                
            }else{
                [ws dealErrorResponseWithTableView:ws.tableView info:responseObject];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [ws netErrorWithTableView:ws.tableView];
            
        }];
    };
}


#pragma mark - TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.model ? 5 : 0;
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
    if(section == 4){
        //最后一行
        return 65.f;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 2){
        return self.recomendTitle;
    }
    
    if(section == 4 && self.model.leavecoursecount == 0){
        //最后一行
        [self setNExtViewTitle:[NSString stringWithFormat:@"报考%@",self.model.subjectInfo.subJectName]];
        return self.nextView;
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        return 20;
    }
    return 0.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];;
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
        [basicCell setBgImageUrlStr:self.model.porInfo.originalpic userName:self.model.userName userId:self.model.disPlayId];
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
    if (self.model.telPhoto) {
        NSString * telPhoto = [NSString stringWithFormat:@"telprompt://%@",self.model.telPhoto];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telPhoto]];
    }else{
//        [self showTotasViewWithMes:@"用户无手机号码：测试"];
    }
}


- (UIView *)nextView
{
    if (!_nextView){
        _nextView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 65)];
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(15, 10, self.view.width - 30, 45)];
        button.backgroundColor = RGB_Color(33, 124, 236);
        button.tag = 100;
        [button setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor]  forState:UIControlStateHighlighted];
        [[button titleLabel] setFont:[UIFont systemFontOfSize:12.f]];
        [button addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [_nextView addSubview:button];
    }
    return _nextView;
}

- (void)setNExtViewTitle:(NSString *)title
{
    UIButton * button = (UIButton *)[[self nextView] viewWithTag:100];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
}

- (void)buttonDidClick:(UIButton *)button
{
    [self showTotasViewWithMes:@"等待服务接口"];
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
