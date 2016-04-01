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

    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    JZExamHeaderView *headerView = [[JZExamHeaderView alloc]init];
    
    self.tableView.tableHeaderView = headerView;
//    self.tableView.tableHeaderView.height = 142;
    
    // 隐藏没有数据的表格
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    // 如果tableView设置为grouped样式时,返回每一组的头部视图的代理方法是从第1组开始的,它把第0组的头部视图留给tableView的tableHeaderView这个属性
//    JZExamHeaderView *headerView = (JZExamHeaderView *)[self tableView:self.tableView viewForHeaderInSection:0];
    headerView.bounds = CGRectMake(0, 0, self.tableView.bounds.size.width, 44);
    self.tableView.tableHeaderView = headerView;
    
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        [self loadData];
        
        
    });
   
    
    
    
    
}

//// 用来返回每一组的头部视图
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    // 1.创建headerView
//    JZExamHeaderView *heaerView = [JZExamHeaderView headerViewWithTableView:tableView];
//    
//    NSLog(@"-----%ld", section);
//    // 2.给headerView传递模型
//    heaerView.group = self.groups[section];
//    // 3.设置代理
//    heaerView.delegate = self;
//    // 给每一个headerView设置一个标识
//    heaerView.tag = section;
//    // 4.返回haderView
//    return heaerView;
//}

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
        
        NSLog(@"======%@=======",self.examInfoData);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        
        NSLog(@"获取学员的考试消息出错啦，错误信息：%@",error);
        
    }];
    
    
    
    
}



#pragma mark - Table view 数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
