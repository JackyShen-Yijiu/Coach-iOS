//
//  JZPassStudentListController.m
//  HeiMao_B
//
//  Created by ytzhang on 16/4/1.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZPassStudentListController.h"
#import "RefreshTableView.h"
#import "JZStudentPassListCell.h"
#import "JZPassListData.h"
#import <YYModel.h>
#import "BLPFAlertView.h"
#import "ChatViewController.h"
@interface JZPassStudentListController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) RefreshTableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation JZPassStudentListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通过学员";
    self.dataArray = [NSMutableArray array];
    self.view.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
    [self.view addSubview:self.tableView];
    [self initData];
}
- (void)initData{
    [NetWorkEntiry getPassListStudentWihtCoachID:[UserInfoModel defaultUserInfo].userID subjectID:_subjectID examDate:_examDate examState:(NSString *)@(1) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *param = responseObject;
        if ([param[@"type"] integerValue] == 1) {
            NSArray *array = param[@"data"];
            if (array.count) {
                for (NSDictionary *dic in array) {
                    
                    
                    JZPassListData *listModel = [JZPassListData yy_modelWithDictionary:dic];
                    
                    [self.dataArray addObject:listModel];
                    
                }
                JZPassListData *listModel = [self.dataArray firstObject];
                NSLog(@"listModel.idField  =%@",listModel.idField);
                [self.tableView reloadData];
            }else{
                [self showTotasViewWithMes:@"暂无数据"];
            }
            
        }else{
            [self showTotasViewWithMes:@"网络错误"];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self showTotasViewWithMes:@"网络错误"];
    }];
}
#pragma mark ---- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *IDCell = @"cellID";
    JZStudentPassListCell *listCell = [tableView dequeueReusableCellWithIdentifier:IDCell];
    if (!listCell) {
        listCell = [[JZStudentPassListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDCell];
    }
    listCell.passlistMoel = _dataArray[indexPath.row];
    listCell.studentListMessageAndCall = ^(NSInteger tag){
        if (500 == tag) {
            // 信息
            JZPassListData *model = _dataArray[indexPath.row];
            [self messageWithModel:model];
        }
        if (501 == tag) {
            // 电话
            JZPassListData *model = _dataArray[indexPath.row];
            [self callPhonewithModel:model];
        }
    };
    return listCell;
}


- (RefreshTableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[RefreshTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height  - 64) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}
#pragma mark ---- 电话
- (void)callPhonewithModel:(JZPassListData *)model{
    
    if (model.userid.mobile == nil ||[model.userid.mobile isEqualToString:@""]) {
        [self showTotasViewWithMes:@"该学员未录入电话!"];
        return;
    }
    
    [BLPFAlertView showAlertWithTitle:@"电话号码" message:model.userid.mobile cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] completion:^(NSUInteger selectedOtherButtonIndex) {
        
        NSUInteger indexAlert = selectedOtherButtonIndex + 1;
        if (indexAlert == 1) {
            
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",model.userid.mobile];
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
- (void)messageWithModel:(JZPassListData *)model{
    
    ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:model.userid.idField conversationType:eConversationTypeChat];
    chatController.title = model.userid.name;
    [self.parentViewController.navigationController pushViewController:chatController animated:YES];

}

@end
