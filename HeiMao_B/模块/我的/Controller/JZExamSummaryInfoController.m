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


@interface JZExamSummaryInfoController ()
@property (nonatomic, strong) NSMutableArray *examInfoData;
@end

@implementation JZExamSummaryInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.title = @"考试信息";
    self.tableView.sectionHeaderHeight = 142;
    self.tableView.sectionFooterHeight = 10;
    
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10)];
    
    footView.backgroundColor = JZ_FONTCOLOR_DRAK;
    
    self.tableView.tableFooterView = footView;
    self.tableView.tableFooterView.height = 10;

    
    // 监听名字为openGroup的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(haderViewDidOpenGroup:) name:@"openGroup" object:nil];

    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    JZExamHeaderView *headerView = [[JZExamHeaderView alloc]init];
    
    
    // 隐藏没有数据的表格
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    // 如果tableView设置为grouped样式时,返回每一组的头部视图的代理方法是从第1组开始的,它把第0组的头部视图留给tableView的tableHeaderView这个属性
    headerView.bounds = CGRectMake(0, 0, self.tableView.bounds.size.width, 142);
    
    self.tableView.tableHeaderView = headerView;
    
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        [self loadData];
        
        
    });
   
    
    
    
    
}



// 用来返回每一组的头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // 1.创建headerView
    JZExamHeaderView *heaerView = [JZExamHeaderView examHeaderViewWithTableView:tableView];
    
    NSLog(@"-----%ld", section);
    // 2.给headerView传递模型
    heaerView.modelGrop = self.examInfoData[section];
    // 3.设置代理
    
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
            
//            NSLog(@"%ld",(long)data.passrate);
           

            
            
            
            
        }
        [self.tableView reloadData];
        
        NSLog(@"======%@=======",self.examInfoData);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        
        NSLog(@"获取学员的考试消息出错啦，错误信息：%@",error);
        
    }];
    
    
    
}

- (void)haderViewDidOpenGroup:(NSNotification *)note {
    // 刷新表格
    //    [self.tableView reloadData];
    JZExamHeaderView *headerView = note.object;
    // 创建表示第几组的索引集合
    NSLog(@"%ld", headerView.tag);
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:headerView.tag];
    // 刷新指定的组
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
}




#pragma mark - Table view 数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    NSLog(@"%zd",self.examInfoData.count);
    return self.examInfoData.count;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
