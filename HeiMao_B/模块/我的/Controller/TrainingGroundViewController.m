//
//  TrainingGroundViewController.m
//  HeiMao_B
//
//  Created by bestseller on 15/11/16.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "TrainingGroundViewController.h"
#import "ToolHeader.h"
#import "UIDevice+JEsystemVersion.h"
#import "UIView+CalculateUIView.h"
#import "buttonSelectedModel.h"
#import "ButtonSelectedCell.h"
static NSString *const kTrainingGround = @"getschooltrainingfield?schoolid=%@";

@interface TrainingGroundViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIButton *naviBarRightButton;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableArray *upDateArray;
@property (strong, nonatomic) buttonSelectedModel *model;
@end

@implementation TrainingGroundViewController
- (NSMutableArray *)upDateArray {
    if (_upDateArray == nil) {
        _upDateArray = [[NSMutableArray alloc] init];
    }
    return _upDateArray;
}
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
- (UIButton *)naviBarRightButton {
    if (_naviBarRightButton == nil) {
        _naviBarRightButton = [WMUITool initWithTitle:@"完成" withTitleColor:[UIColor whiteColor] withTitleFont:[UIFont systemFontOfSize:16]];
        _naviBarRightButton.frame = CGRectMake(0, 0, 44, 44);
        [_naviBarRightButton addTarget:self action:@selector(clickRight:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviBarRightButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"训练场地";
    self.view.backgroundColor = RGB_Color(245, 247, 250);
    self.automaticallyAdjustsScrollViewInsets = NO;
    if ([UIDevice jeSystemVersion] >= 7.0f) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarRightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self startDownLoad];

}
- (void)startDownLoad
{
    NSString *urlString = [NSString stringWithFormat:kTrainingGround,[UserInfoModel defaultUserInfo].schoolId];
    NSString *url = [NSString stringWithFormat:@"%@/%@",HOST_TEST_DAMIAN,urlString];
    [JENetwoking startDownLoadWithUrl:url postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        NSDictionary *param = data;
        NSArray *array = param[@"data"];
        if (array!= nil && ![array isEqual:[NSNull null]] && array.count > 0) {
            for (NSDictionary *dic in array) {
                buttonSelectedModel *model = [[buttonSelectedModel alloc] init];
                model.infoId = dic[@"id"];
                model.name = dic[@"name"];
                NSString * trainName = [[UserInfoModel defaultUserInfo].trainfieldlinfo objectStringForKey:@"name"];
                if (trainName && [trainName isEqualToString:dic[@"name"]]) {
                    model.is_selected = YES;
                }else{
                    model.is_selected = NO;
                }
                [self.dataArray addObject:model];
            }
            [self.tableView reloadData];
        }
    }];
}
- (void)clickRight:(UIButton *)sender
{
    
    if (self.model==nil) {
        ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"请选择训练场地" controller:self];
        [alerview show];
        return;
    }
    
    NSString *updateUserInfoUrl = [NSString stringWithFormat:@"%@/%@",HOST_TEST_DAMIAN,kupdateUserInfo];
    
    NSDictionary *dicParam = @{@"trainfield":self.model.infoId,@"coachid":[UserInfoModel defaultUserInfo].userID};
    
    [JENetwoking startDownLoadWithUrl:updateUserInfoUrl postParam:dicParam WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        NSDictionary *dataParam = data;
        NSNumber *messege = dataParam[@"type"];
        if (messege.intValue == 1) {
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[@"name"] = self.model.name;
            dict[@"id"] = self.model.infoId;
            [UserInfoModel defaultUserInfo].trainfieldlinfo = dict;
            
            ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"上传成功" controller:self];
            
            [alerview show];
            [[NSNotificationCenter defaultCenter] postNotificationName:ktrainGroundKey object:nil];
            [self.navigationController popViewControllerAnimated:YES];

        }else {
            return;
        }
        
    }];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    ButtonSelectedCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[ButtonSelectedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    buttonSelectedModel *model = self.dataArray[indexPath.row];
    [cell receiveDataWithModel:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    buttonSelectedModel *model = self.dataArray[indexPath.row];
    if (model.is_selected == NO) {
        model.is_selected = YES;
        [self.dataArray replaceObjectAtIndex:indexPath.row withObject:model];
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        self.model = model;
    }else if (model.is_selected == YES) {
        model.is_selected = NO;
        [self.dataArray replaceObjectAtIndex:indexPath.row withObject:model];
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}
@end
