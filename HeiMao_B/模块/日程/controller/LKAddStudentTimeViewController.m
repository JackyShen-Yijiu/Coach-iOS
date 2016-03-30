//
//  ViewController.m
//  添加学员
//
//  Created by 雷凯 on 16/3/28.
//  Copyright © 2016年 leifaxian. All rights reserved.
//

#import "LKAddStudentTimeViewController.h"
#import "LKAddStudentTableViewCell.h"
#import "LKAddStudentTimeView.h"
#import "YYModel.h"
#import "LKAddStudentData.h"
#import "YBCourseData.h"

static NSString *addStuCellID = @"addStuCellID";

@interface LKAddStudentTimeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) LKAddStudentTimeView *timeViewItem;
@property (nonatomic, strong) UIView *timeView;
///  记录选中的cell
@property (nonatomic, strong) NSMutableArray *selectedRows;

@property (nonatomic, strong) NSMutableArray *stundentDataArrM;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LKAddStudentTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
_stundentDataArrM = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *timeView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 92)];
    
    [self.view addSubview:timeView];
    
    self.timeView = timeView;
    
   
    UITableView  *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64 + 92, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-64-92)];

    self.tableView = tableView;
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:tableView];


//    [UserInfoModel defaultUserInfo].subject 
//
    self.navigationItem.title = @"添加学员";
/////  允许cell多选
    self.tableView.allowsMultipleSelection = YES;
//
    self.selectedRows = [NSMutableArray array];
//
//    // Do any additional setup after loading the view, typically from a nib.
//    [self.tableView registerClass:[LKAddStudentTableViewCell class] forCellReuseIdentifier:addStuCellID];
    self.tableView.rowHeight = 80;
//    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
//    //    self.edgesForExtendedLayout = UIRectEdgeNone;
//    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addStudent)];

    rightItem.tintColor = [UIColor whiteColor];

    
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        
         [self initData];
    });

#pragma mark - 顶部时间按钮栏

    
    CGFloat y = 0;
    CGFloat w = [UIScreen mainScreen].bounds.size.width/4;
    CGFloat h = 92;
    for (NSInteger i=0; i<_dataArray.count; i++) {
        
        
        LKAddStudentTimeView *timeViewItem = [[LKAddStudentTimeView alloc]initWithFrame:CGRectMake(i*w, y, w, h)];
        timeViewItem.tag = 2000 + i;
        timeViewItem.selectButton.tag = 1000 + i;
        [timeViewItem.selectButton addTarget:self action:@selector(clickSelectBtn:) forControlEvents:UIControlEventTouchUpInside];

        YBCourseData *data = self.dataArray[i];
        
        timeViewItem.starTimeLabel.text = [NSString getHourLocalDateFormateUTCDate:data.coursebegintime];
        
        timeViewItem.finishTimeLabel.text = [NSString getHourLocalDateFormateUTCDate:data.courseendtime];
        
        [self.timeView addSubview:timeViewItem];

    }
    
    NSLog(@"%@",self.studentDataM);
    
    self.timeView = timeView;
  
}
#pragma mark - 取消选择的cell

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    LKAddStudentTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //如果取消已选择的cell,从记录移除
    [self.selectedRows removeObject:indexPath];

    
    NSLog(@"%@",indexPath);
}
- (void)initData{
//如果教练是什么都交  返回 -1   不是返回交的课程
    
    [NetWorkEntiry addstudentsListwithCoachid:self.coachidStr subjectID:(NSString *)@(-1) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        id result = responseObject;
        
//        NSLog(@"类型----%@",[result class]);
        
//        NSLog(@"返回的数据%@",result);
        
        
        NSArray *stundentData = result[@"data"];
        
        for (NSDictionary *dict in stundentData) {
            
            LKAddStudentData *data = [LKAddStudentData yy_modelWithDictionary:dict];
            
            NSLog(@"名字 ==== == = %@",data.name);
            
            
            [self.stundentDataArrM addObject:data];
            
        }
        [self.tableView reloadData];
        
//        NSLog(@"数组-----%@",stundentData);
//        NSLog(@"名字=====%@",stundentData[0][@"name"]);
  
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
    }
#pragma mark - 选择cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    LKAddStudentTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (![self.selectedRows containsObject:indexPath] && self.selectedRows.count < 7) {
        
//        cell.backgroundColor = [UIColor grayColor];
        
        [self.selectedRows addObject:indexPath];
    }
}

#pragma mark - 点击选择时间的按钮
-(void)clickSelectBtn:(UIButton *)sender{
    
    NSLog(@"--第%zd个按钮--",sender.tag);
    LKAddStudentTimeView *lkView = [_timeView viewWithTag:2001];
    NSLog(@"%@",lkView.starTimeLabel.text);

}



#pragma mark - 点击右侧添加学员
-(void)addStudent {
    
    NSLog(@"点击了右侧添加学员");
}


#pragma mark - 返回的行数
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    
//    //    return [[self.arrayList[section] Students] count];
//    
//    return 100;
//}
//
//#pragma mark - 返回的组数
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//        return [self.studentDataM count];
//    
//    return 1;
//}
#pragma mark - tableView数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.stundentDataArrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
        LKAddStudentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:addStuCellID];
        if (!cell) {
            cell = [[LKAddStudentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addStuCellID];
    
        }
    
    cell.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"%@",self.stundentDataArrM);
        LKAddStudentData *data = self.stundentDataArrM[indexPath.row];
    NSLog(@"名字333333 ==== == = %@",data.name);
    
//    cell.studentNameLabel.text = data.name;
    
    
        
        return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 返回tableView右边索引栏
//- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    //   NSArray *indexArr = [self.groupes valueForKeyPath:@"title"];
//    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:self.arrayList.count];
    //    for (StudentGroup *group in self.arrayList) {
    //        [arrM addObject:group.title];
    //    }
//    return arrM;
//}

#pragma mark - 返回每一组的头部标题
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
////    return [self.arrayList[section] title];
//}



@end
