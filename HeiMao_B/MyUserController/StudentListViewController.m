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
#import "SutdentHomeController.h"


static NSString *const kstudentList = @"userinfo/coachstudentlist?coachid=%@&index=1";

@interface StudentListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;

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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
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
    
    [self startDownLoad];
}
- (void)startDownLoad {
    NSString *url = [NSString stringWithFormat:kstudentList,[UserInfoModel defaultUserInfo].userID];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",[NetWorkEntiry domain],url];
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        NSArray *param = [data objectForKey:@"data"];
        if (param != nil && ![param isEqual:[NSNull null]] && param.count > 0) {
            for (NSDictionary *dic in param) {
                HMStudentModel *stuModel = [HMStudentModel converJsonDicToModel:dic];
                [self.dataArray addObject:stuModel];
            }
        }
        
        [self.tableView reloadData];
    }];
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
    SutdentHomeController * stuH = [[SutdentHomeController alloc] init];
    HMStudentModel *model = self.dataArray[indexPath.row];
    stuH.studentId = model.userId;
    [self.navigationController pushViewController:stuH animated:YES];

}
@end
