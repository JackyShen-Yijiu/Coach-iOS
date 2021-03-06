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
#import "LKAddStudentNoDataView.h"

@interface JZExamSummaryInfoController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *examInfoData;
@property (nonatomic, strong) NSMutableArray *examListData;

@property (nonatomic,assign) NSInteger selectHeaderViewTag;

@property (nonatomic, strong) LKAddStudentNoDataView *noDataView;

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation JZExamSummaryInfoController

- (UITableView *)tableView
{
    if (_tableView==nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"考试信息";
    self.tableView.sectionHeaderHeight = 150.5;
    
    if (YBIphone6Plus) {
        
        UIColor * color = [UIColor whiteColor];
        UIFont *font = [UIFont systemFontOfSize:JZNavBarTitleFont];
        
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        [dict setObject:color forKey:NSForegroundColorAttributeName];
        [dict setObject:font forKey:NSFontAttributeName];
        
        self.navigationController.navigationBar.titleTextAttributes = dict;
        
    }

    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 监听名字为openGroup的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(haderViewDidOpenGroup:) name:@"openGroup" object:nil];

    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.view.backgroundColor = RGB_Color(226, 226, 232);
    self.tableView.backgroundColor = RGB_Color(226, 226, 232);
    [self.view addSubview:self.tableView];
    
    self.noDataView = [[LKAddStudentNoDataView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
//    self.noDataView.backgroundColor = [UIColor redColor];
    self.noDataView.hidden = YES;
    [self.view addSubview:self.noDataView];
    
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
        
        NSDictionary *param = responseObject;
        
        if ([param[@"type"] integerValue] == 1) {
            
            NSArray *array = param[@"data"];
            if (array.count) {
                
                NSLog(@"result = %@",param);
                
                NSArray *stundentData = param[@"data"];
                
                for (NSDictionary *dict in stundentData) {
                    
                    JZExamSummaryInfoData *data = [JZExamSummaryInfoData yy_modelWithDictionary:dict];
                    
                    [self.examInfoData addObject:data];
                    
                }
                [self.tableView reloadData];
                
            }else{
             
                self.noDataView.hidden = NO;
                
            }
            
        }else{
           
            self.noDataView.hidden = NO;
            self.noDataView.noDataLabel.text = @"";
            self.noDataView.noDataImageView.image = [UIImage imageNamed:@"net_null"];

        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        self.noDataView.hidden = NO;
        self.noDataView.noDataLabel.text = @"";
        self.noDataView.noDataImageView.image = [UIImage imageNamed:@"net_null"];
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
    JZExamHeaderView *infoHeaerView = [JZExamHeaderView examHeaderViewWithTableView:tableView withTag:section];
    
    
    // 2.给headerView传递模型
    infoHeaerView.modelGrop = self.examInfoData[section];
    
    infoHeaerView.passCountButton.tag = section;
    
    [infoHeaerView.passCountButton addTarget:self action:@selector(pushPassStudentVC:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *bjView = [[UIView alloc]initWithFrame:infoHeaerView.bounds];
    bjView.backgroundColor = [UIColor whiteColor];
    
    infoHeaerView.backgroundView = bjView;
    
    infoHeaerView.nopassView.tag = section;
    infoHeaerView.nopassView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(infoHeaerViewDidClick:)];
    [infoHeaerView.nopassView addGestureRecognizer:tap];

    
    // 3.返回haderView
    return infoHeaerView;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *infoFootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10)];
    infoFootView.backgroundColor = RGB_Color(226, 226, 232);
    
    return infoFootView;
}
/// 跳转控制器
-(void)pushPassStudentVC:(UIButton *)button {
    
    JZExamSummaryInfoData *data = self.examInfoData[button.tag];
    NSLog(@"self.examInfoData[buttonTag] = %@",self.examInfoData[button.tag]);
    
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
