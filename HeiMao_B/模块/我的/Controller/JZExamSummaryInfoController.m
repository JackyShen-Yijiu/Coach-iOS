//
//  JZExamSummaryInfoController.m
//  HeiMao_B
//
//  Created by 雷凯 on 16/4/1.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZExamSummaryInfoController.h"
#import "JZExamHeaderView.h"
#import "JZExamSummaryInfoData.h"
#import "YYModel.h"
#import "JZNopassStudentCell.h"
#import "JZExamStudentListData.h"
#import "JZPassStudentListController.h"

@interface JZExamSummaryInfoController ()
@property (nonatomic, strong) NSMutableArray *examInfoData;
@property (nonatomic, strong) NSMutableArray *examListData;

@property (nonatomic,assign) NSInteger selectHeaderViewTag;

@end

@implementation JZExamSummaryInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"考试信息";
    self.tableView.sectionHeaderHeight = 150.5;
    
    // 监听名字为openGroup的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(haderViewDidOpenGroup:) name:@"openGroup" object:nil];

    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    
//    self.view.backgroundColor = RGB_Color(226, 226, 232);
//    self.tableView.backgroundColor = RGB_Color(226, 226, 232);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        [self loadData];
    
    });

}

-(NSMutableArray *)examInfoData {
    
    if (_examInfoData ==  nil) {
        
        _examInfoData = [[NSMutableArray alloc]init];
    }
    return _examInfoData;
}
-(NSMutableArray *)examListData {
    
    if (_examListData == nil) {
        
        _examListData = [[NSMutableArray alloc]init];
    }
    
    return _examListData;
    
}
#pragma mark - 加载数据

-(void)loadData {
    
    
    [NetWorkEntiry getExamSummaryInfoDataWihtCoachID:[UserInfoModel defaultUserInfo].userID index:1 count:10 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        id result = responseObject;
        
        NSLog(@"result = %@",result);
        
        NSArray *stundentData = result[@"data"];
        
        NSLog(@"数组===%@",stundentData);
        
        
        for (NSDictionary *dict in stundentData) {
            
         JZExamSummaryInfoData *data = [JZExamSummaryInfoData yy_modelWithDictionary:dict];
            
            [self.examInfoData addObject:data];
            
        }
        [self.tableView reloadData];
        
        NSLog(@"======%@=======",self.examInfoData);
        
        NSLog(@"%@",self.examInfoData);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        [self showTotasViewWithMes:@"网络错误"];
        
        NSLog(@"获取学员的考试消息出错啦，错误信息：%@",error);
        
    }];
    
    
}

#pragma mark - 点击下拉菜单请求数据
-(void)getNopassList{
   
    JZExamSummaryInfoData *modelGrop = self.examInfoData[self.selectHeaderViewTag];

        [NetWorkEntiry getPassListStudentWihtCoachID:[UserInfoModel defaultUserInfo].userID subjectID:modelGrop.subject examDate:modelGrop.examdate examState:(NSString *)@(2) success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSLog(@"%@",responseObject);
        
        NSDictionary *param = responseObject;
        if ([param[@"type"] integerValue] == 1) {
            NSArray *array = param[@"data"];
            if (array.count) {
                
                modelGrop.openGroup = YES;
                [self.examInfoData replaceObjectAtIndex:self.selectHeaderViewTag withObject:modelGrop];
                
                [self.examListData removeAllObjects];
                
                for (NSDictionary *dict in array) {
                    JZExamStudentListData *listModel = [JZExamStudentListData yy_modelWithDictionary:dict];
                    [self.examListData addObject:listModel];
                    
                      NSLog(@"%@",dict);
                }
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

- (void)haderViewDidOpenGroup:(NSNotification *)note {
    // 刷新表格
    //    [self.tableView reloadData];
    JZExamHeaderView *headerView = note.object;
    
    NSLog(@"%ld", headerView.tag);
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:headerView.tag];
    // 刷新指定的组
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - Table view 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSLog(@"返回了几个%zd",self.examInfoData.count);
    return self.examInfoData.count;
    
}

// 用来返回每一组的头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    // 1.创建headerView
    JZExamHeaderView *infoHeaerView = [JZExamHeaderView examHeaderViewWithTableView:tableView];
    
    // 2.给headerView传递模型
    infoHeaerView.modelGrop = self.examInfoData[section];
    
    infoHeaerView.passCountButton.tag = section;
    
    [infoHeaerView.passCountButton addTarget:self action:@selector(pushPassStudentVC:) forControlEvents:UIControlEventTouchUpInside];
    
//    infoHeaerView.backgroundColor = [UIColor whiteColor];
    
    infoHeaerView.nopassView.tag = section;
    infoHeaerView.nopassView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(infoHeaerViewDidClick:)];
    [infoHeaerView.nopassView addGestureRecognizer:tap];

    
    // 3.返回haderView
    return infoHeaerView;
    
}
/// 跳转控制器
-(void)pushPassStudentVC:(NSInteger)buttonTag {
    
    JZExamSummaryInfoData *data = self.examInfoData[buttonTag];

    
    JZPassStudentListController *passVC = [[JZPassStudentListController alloc]init];
    
    passVC.subjectID = data.subject;
    passVC.examDate = data.examdate;
    
    [self.navigationController pushViewController:passVC animated:YES];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    JZExamSummaryInfoData *modelGrop = self.examInfoData[section];

    if (modelGrop.openGroup && self.selectHeaderViewTag == section)
        return self.examListData.count;
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *IDCell = @"cellID";
    JZNopassStudentCell *listCell = [tableView dequeueReusableCellWithIdentifier:IDCell];
    
    if (!listCell) {
        listCell = [[JZNopassStudentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDCell];
    }
//    listCell.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    
    if (_examListData && _examListData.count>0) {
        
        listCell.examListData = _examListData[indexPath.row];
        listCell.userInteractionEnabled = NO;
        
    }
    
    return listCell;
}

- (void)infoHeaerViewDidClick:(UITapGestureRecognizer *)tap
{
    // 将上一个分组关闭
    JZExamSummaryInfoData *modelGrop = self.examInfoData[self.selectHeaderViewTag];
    if (modelGrop.openGroup) {
        modelGrop.openGroup = !modelGrop.openGroup;
        [self.examInfoData replaceObjectAtIndex:self.selectHeaderViewTag withObject:modelGrop];
        [self.tableView reloadData];
        return;
    }
    
    // 打开本分组
    NSInteger selectHeaderViewTag = tap.view.tag;
    NSLog(@"selectHeaderViewTag:%ld",(long)selectHeaderViewTag);
    self.selectHeaderViewTag = selectHeaderViewTag;

    [self getNopassList];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
