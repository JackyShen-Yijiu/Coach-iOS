//
//  StudentListViewController.m
//  HeiMao_B
//
//  Created by bestseller on 15/11/16.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "StudentListViewController.h"
#import "UIDevice+JEsystemVersion.h"
#import "UIView+CalculateUIView.h"
#import <Chameleon.h>
#import "ToolHeader.h"
#import "StudentListCell.h"
#import "HMStudentModel.h"
#import "YBStudentDetailsViewController.h"
#import "NoContentTipView.h"
#import "RefreshTableView.h"

static NSString *const kstudentList = @"userinfo/coachstudentlist?coachid=%@&index=%lu";

@interface StudentListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic)  RefreshTableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@property(nonatomic,strong)NoContentTipView * tipView1;

@property(nonatomic,assign)BOOL isNeedRefresh;

@end

@implementation StudentListViewController

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[RefreshTableView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    [self startDownLoad];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(self.isNeedRefresh){
        [self.tableView.refreshHeader beginRefreshing];
    }
    self.isNeedRefresh = NO;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.title = @"学员列表";
    self.automaticallyAdjustsScrollViewInsets = NO;
    if ([UIDevice jeSystemVersion] >= 7.0f) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    // 日程
    self.tipView1 = [[NoContentTipView alloc] initWithContetntTip:@"无内容"];
    [self.tipView1 setHidden:YES];
    [self.tableView addSubview:self.tipView1];
    self.tipView1.center = CGPointMake(self.tableView .width/2.f, self.tableView.height/2.f);
    self.isNeedRefresh = YES;

    
}

- (void)startDownLoad {
    WS(ws);
    self.tableView.refreshHeader.beginRefreshingBlock = ^()
    {
        
        NSInteger startSeqix = 1;
        NSString *url = [NSString stringWithFormat:kstudentList,[UserInfoModel defaultUserInfo].userID,startSeqix];
        NSString *urlString = [NSString stringWithFormat:@"%@/%@",HOST_TEST_DAMIAN,url];

        [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data)
        {
            NSArray *param = [data objectForKey:@"data"];
            if (param != nil && ![param isEqual:[NSNull null]] && param.count > 0)
            {
                [ws.dataArray removeAllObjects];
                for (NSDictionary *dic in param)
                {
            
                    HMStudentModel *stuModel = [HMStudentModel converJsonDicToModel:dic];
                    [ws.dataArray addObject:stuModel];
                    [ws.tableView.refreshHeader endRefreshing];
                }
            }
            
            if (param.count>=10) {
                ws.tableView.refreshFooter.scrollView = ws.tableView;
            }else{
                ws.tableView.refreshFooter.scrollView = nil;
            }
            
            if (ws.dataArray.count==0)
            {
                ws.tipView1.hidden = NO;
            }else
            {
                ws.tipView1.hidden = YES;
            }
            
            [ws.tableView reloadData];
        }];
    };
    // 加载
    [self.tableView refreshFooter].beginRefreshingBlock = ^(){
        
        if(ws.dataArray.count % RELOADDATACOUNT)
        {
            [ws showTotasViewWithMes:@"已经加载所有数据"];
            [ws.tableView.refreshFooter endRefreshing];
            ws.tableView.refreshFooter.scrollView = nil;
            return ;
        }
        NSInteger seqix = ws.dataArray.count / RELOADDATACOUNT + 1;
        NSString *url = [NSString stringWithFormat:kstudentList,[UserInfoModel defaultUserInfo].userID,seqix];
        NSString *urlString = [NSString stringWithFormat:@"%@/%@",HOST_TEST_DAMIAN,url];

        [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data)
         {
             NSArray *param = [data objectForKey:@"data"];
//             if (param.count == 0) {
//                 [ws showTotasViewWithMes:@"已经加载所有数据"];
//                 [ws.tableView.refreshFooter endRefreshing];
//                 ws.tableView.refreshFooter.scrollView = nil;
//                 return ;
//             }
             if (param != nil && ![param isEqual:[NSNull null]] && param.count > 0)
             {
                 for (NSDictionary *dic in param)
                 {
                     HMStudentModel *stuModel = [HMStudentModel converJsonDicToModel:dic];
                     [ws.dataArray addObject:stuModel];
                 }
             } else{
                 [ws showTotasViewWithMes:@"已经加载所有数据"];
             }
             
             if (param.count>=10) {
                 ws.tableView.refreshFooter.scrollView = ws.tableView;
             }else{
                 ws.tableView.refreshFooter.scrollView = nil;
             }
             
             [ws.tableView.refreshFooter endRefreshing];
             [ws.tableView reloadData];
         }];

        
        
  };
        
        
        
//        [NetWorkEntiry getAllRecomendWithUserID:ws.studentId WithIndex:ws.model.recommendArrays.count / RELOADDATACOUNT success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
//            if (type == 1) {
//                NSArray * listArray = [BaseModelMethod getRecomendListArrayFormDicInfo:[responseObject objectArrayForKey:@"data"]];
//                if (listArray.count) {
//                    [ws.model.recommendArrays addObjectsFromArray:listArray];
//                    [ws.tableView reloadData];
//                }else{
//                    [ws showTotasViewWithMes:@"已经加载所有数据"];
//                }
//                
//                [ws.tableView.refreshFooter endRefreshing];
//                
//            }else{
//                [ws dealErrorResponseWithTableView:ws.tableView info:responseObject];
//            }
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            [ws netErrorWithTableView:ws.tableView];
//            
//        }];
  

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    StudentListCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[StudentListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    HMStudentModel *model = self.dataArray[indexPath.row];
    cell.stuModel = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YBStudentDetailsViewController * stuH = [[YBStudentDetailsViewController alloc] init];
    HMStudentModel *model = self.dataArray[indexPath.row];
    stuH.studentID = model.userId;
    [self.navigationController pushViewController:stuH animated:YES];

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

@end
