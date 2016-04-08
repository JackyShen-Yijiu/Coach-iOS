//
//  JZHomeStudentSubjectOneView.m
//  HeiMao_B
//
//  Created by ytzhang on 16/3/28.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZHomeStudentAllListView.h"
#import "JZHomeStudentListCell.h"
#import "BLPFAlertView.h"
#import "ChatViewController.h"
#import "YBStudentDetailsViewController.h"
#import <YYModel.h>


@interface JZHomeStudentAllListView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation JZHomeStudentAllListView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    _dataArray = [NSMutableArray array];
    [self addSubview:self.tableView];
    [self initRefreshView];
}
#pragma mark ---- UITableViewDelegate 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
    
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
    listCell.listModel = self.dataArray[indexPath.row];
    listCell.studentListMessageAndCall = ^(NSInteger tag){
        if (500 == tag) {
            // 信息
            JZResultModel *model = self.dataArray[indexPath.row];
            [self messageWithModel:model];
        }
        if (501 == tag) {
            // 电话
            JZResultModel *model = self.dataArray[indexPath.row];
            [self callPhonewithModel:model];
        }
    };

    return listCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 跳转学员详情页
    JZResultModel *model = _dataArray[indexPath.row];
    YBStudentDetailsViewController *studentDetailVC = [[YBStudentDetailsViewController alloc] init];
    studentDetailVC.studentID = model.userid;
    [self.parementVC.navigationController pushViewController:studentDetailVC animated:YES];
}

#pragma mark ---- 电话
- (void)callPhonewithModel:(JZResultModel *)model{
    
    if (model.mobile == nil ||[model.mobile isEqualToString:@""]) {
        [self.parementVC showTotasViewWithMes:@"该学员未录入电话!"];
        return;
    }
    
    [BLPFAlertView showAlertWithTitle:@"电话号码" message:model.mobile cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] completion:^(NSUInteger selectedOtherButtonIndex) {
        
        NSUInteger indexAlert = selectedOtherButtonIndex + 1;
        if (indexAlert == 1) {
            
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",model.mobile];
            UIWebView * callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            [self.parementVC.view addSubview:callWebview];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }else {
            return ;
        }
        
    }];
}
- (void)initRefreshView
{
    NSLog(@"self.subjectID = %@",(NSString *)@(self.subjectID));
    
    NSLog(@"self.studentState = %@",(NSString *)@(self.studentState));
    WS(ws);
    self.tableView.refreshHeader.beginRefreshingBlock = ^(){
        NSLog(@" subjectID=%@ State == %@  ", (NSString *)@(ws.subjectID),(NSString *)@(ws.studentState) );
        [NetWorkEntiry coachStudentListWithCoachId:[[UserInfoModel defaultUserInfo] userID] subjectID:(NSString *)@(ws.subjectID) studentID:(NSString *)@(ws.studentState) index:1 count:10 success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"responseObject=%@ subjectID=%@ State == %@  ",responseObject, (NSString *)@(ws.subjectID),(NSString *)@(ws.studentState) );
            NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
            NSArray *data = [responseObject objectArrayForKey:@"data"];
            if (type == 1) {
                
                [ws.dataArray removeAllObjects];
                
                if (data.count == 0) {
//                    ws.noDataShowBGView.hidden = NO;
                    [ws.tableView.refreshHeader endRefreshing];
                    [ws.tableView reloadData];
                    return ;
                }
//                ws.noDataShowBGView.hidden = YES;
                for (NSDictionary *dic in data) {
                    JZResultModel *model = [JZResultModel yy_modelWithDictionary:dic];
                    [ws.dataArray addObject:model];
                }
                
                
                    [ws.tableView.refreshHeader endRefreshing];
                NSLog(@"ws.dataArray.count = %lu",ws.dataArray.count);
                    [ws.tableView reloadData];
                    
                    if (data.count>=10) {
                        ws.tableView.refreshFooter.scrollView = ws.tableView;
                    }else{
                        ws.tableView.refreshFooter.scrollView = nil;
                    }
                
                
            }else{
                [ws dealErrorResponseWithTableView:ws.tableView info:responseObject];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [ws netErrorWithTableView:ws.tableView];
        }];
        
    };
    
    ws.tableView.refreshFooter.beginRefreshingBlock = ^(){
        //                        NSArray *dataArray = [NSArray array];
        
        if(_dataArray.count % RELOADDATACOUNT){
            [ws.parementVC showTotasViewWithMes:@"已经加载所有数据"];
            if (ws.tableView.refreshFooter) {
                [ws.tableView.refreshFooter endRefreshing];
                ws.tableView.refreshFooter.scrollView = nil;
            }
            return ;
        }
        
        [NetWorkEntiry coachStudentListWithCoachId:[[UserInfoModel defaultUserInfo] userID] subjectID:(NSString *)@(ws.subjectID) studentID:(NSString *)@(ws.studentState) index:_dataArray.count / RELOADDATACOUNT count:RELOADDATACOUNT success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
            if (type == 1) {
                if (responseObject[@"data"]) {
                    for (NSDictionary *dic in responseObject[@"data"]) {
                        JZResultModel *model = [JZResultModel yy_modelWithDictionary:dic];
                        [ws.dataArray addObject:model];
                        [ws.tableView reloadData];
                    }
                    
                }else{
                    [ws.parementVC showTotasViewWithMes:@"已经加载所有数据"];
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
#pragma mark Load Data
- (void)dealErrorResponseWithTableView:(RefreshTableView *)tableview info:(NSDictionary *)dic
{
    [self.parementVC showTotasViewWithMes:[dic objectForKey:@"msg"]];
    [tableview.refreshHeader endRefreshing];
    [tableview.refreshFooter endRefreshing];
}

- (void)netErrorWithTableView:(RefreshTableView*)tableView
{
    [self.parementVC showTotasViewWithMes:@"网络异常，稍后重试"];
    [tableView.refreshHeader endRefreshing];
    [tableView.refreshFooter endRefreshing];
}


#pragma mark ---- 信息
- (void)messageWithModel:(JZResultModel *)model{
    NSLog(@"%s self.dmData.data.studentinfo.userid:%@",__func__,model.userid);
    
    ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:model.userid conversationType:eConversationTypeChat];
    chatController.title = model.name;
    [self.parementVC.navigationController pushViewController:chatController animated:YES];
    
    
}

- (RefreshTableView *)tableView{
    if (_tableView == nil) {
        CGRect rect = self.frame;
        _tableView = [[RefreshTableView alloc] initWithFrame:rect];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

@end
