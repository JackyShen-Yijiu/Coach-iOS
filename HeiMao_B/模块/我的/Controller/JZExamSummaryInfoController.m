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


@interface JZExamSummaryInfoController ()
@property (nonatomic, strong) NSMutableArray *examInfoData;
@property (nonatomic, strong) NSMutableArray *examListData;

@property (nonatomic, strong) JZExamHeaderView *infoHeaerView;


@end

@implementation JZExamSummaryInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"考试信息";
    self.tableView.sectionHeaderHeight = 150.5;
//    self.tableView.sectionFooterHeight = 10;
    
    // 监听名字为openGroup的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(haderViewDidOpenGroup:) name:@"openGroup" object:nil];

    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    
//    self.tableView.backgroundColor = RGB_Color(232, 232, 237);
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        [self loadData];
        
        
    });
   
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

// 用来返回每一组的头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // 1.创建headerView
    JZExamHeaderView *heaerView = [JZExamHeaderView examHeaderViewWithTableView:tableView];
    
    self.infoHeaerView = heaerView;
    NSLog(@"-----%ld", section);
    // 2.给headerView传递模型
    heaerView.modelGrop = self.examInfoData[section];
    // 3.设置代理
    
    heaerView.backgroundColor = [UIColor whiteColor];
    
    // 给每一个headerView设置一个标识
//    heaerView.tag = section;
    
    // 4.返回haderView
    return heaerView;
    
}
-(NSMutableArray *)examInfoData {
    
    if (_examInfoData ==  nil) {
        
        _examInfoData = [[NSMutableArray alloc]init];
    }
    return _examInfoData;
}
-(NSMutableArray *)examListData {
    
    if (_examInfoData == nil) {
        
        _examInfoData = [[NSMutableArray alloc]init];
    }
    
    return _examInfoData;
    
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
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        [self showTotasViewWithMes:@"网络错误"];
        
        NSLog(@"获取学员的考试消息出错啦，错误信息：%@",error);
        
    }];
    
    
}

#pragma mark - 点击下拉菜单请求数据
-(void)getNopassList{
    
    [NetWorkEntiry getPassListStudentWihtCoachID:[UserInfoModel defaultUserInfo].userID subjectID:_infoHeaerView.modelGrop.subject examDate:_infoHeaerView.modelGrop.examdate examState:(NSString *)@(2) success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSLog(@"%@",responseObject);
        
        NSDictionary *param = responseObject;
        if ([param[@"type"] integerValue] == 1) {
            NSArray *array = param[@"data"];
            if (array.count) {
                for (NSDictionary *dict in array) {
                    JZExamStudentListData *listModel = [JZExamStudentListData yy_modelWithDictionary:dict];
                    [self.examInfoData addObject:listModel];
                    
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
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        static NSString *IDCell = @"cellID";
         JZNopassStudentCell *listCell = [tableView dequeueReusableCellWithIdentifier:IDCell];
        if (!listCell) {
            listCell = [[JZNopassStudentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDCell];
        }
        listCell.examListData = _examInfoData[indexPath.row];
    
        return listCell;
    }

#pragma mark - Table view 数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    NSLog(@"返回了几个%zd",self.examInfoData.count);
    return self.examInfoData.count;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
