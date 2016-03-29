//
//  ViewController.m
//  添加学员
//
//  Created by 雷凯 on 16/3/28.
//  Copyright © 2016年 leifaxian. All rights reserved.
//

#import "LKAddStudentTimeViewController.h"
#import "LKAddStudentTableViewCell.h"
//#import "Student.h"
//#import "StudentGroup.h"
#import "LKAddStudentTimeView.h"


@interface LKAddStudentTimeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *arrayList;
@property (nonatomic, strong) LKAddStudentTimeView *timeViewItem;
@property (nonatomic, strong) UIView *timeView;



@end

@implementation LKAddStudentTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"添加学员";
    
    // Do any additional setup after loading the view, typically from a nib.
    [self.tableView registerClass:[LKAddStudentTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight = 80;
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(testLog)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
#pragma mark - 顶部时间按钮栏

    UIView *timeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 92)];
    self.timeView = timeView;
//    self.timeView.backgroundColor = [UIColor yellowColor];
    
    CGFloat y = 0;
    CGFloat w = [UIScreen mainScreen].bounds.size.width/4;
    CGFloat h = 92;
    for (NSInteger i=0; i<4; i++) {
        
        
        LKAddStudentTimeView *timeViewItem = [[LKAddStudentTimeView alloc]initWithFrame:CGRectMake(i*w, y, w, h)];
        timeViewItem.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0)green:((float)arc4random_uniform(256) / 255.0)blue:((float)arc4random_uniform(256) / 255.0)alpha:
                                        1.0];
        
        [self.timeView addSubview:timeViewItem];
        
        
    }
    
//    self.timeView.backgroundColor = [UIColor orangeColor];
    
    
    self.timeView = timeView;

   

    self.tableView.tableHeaderView = self.timeView;
    



    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return  92;
}
-(void)testLog {
    
    NSLog(@"点击了右侧添加学员");
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    return [[self.arrayList[section] Students] count];
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LKAddStudentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[LKAddStudentTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
    }
//    StudentGroup *stuGroup = self.arrayList[indexPath.section];
//    Student *stu = stuGroup.Students[indexPath.row];
//    cell.studentNameLabel.text = stu.studentNameLabel;
    //    [cell setStudentModel:stu];
    //    cell.studentModel = stuGroup.Students[indexPath.row];
    
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.arrayList count];
}// Default is 1 if not implemented
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 返回tableView右边索引栏
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    //   NSArray *indexArr = [self.groupes valueForKeyPath:@"title"];
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:self.arrayList.count];
//    for (StudentGroup *group in self.arrayList) {
//        [arrM addObject:group.title];
//    }
    return arrM;
}

//-(UIView *)timeView{
//    
//    
//    if (!_timeView) {
//        
////        UIView *timeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 92)];
//        
//        CGFloat y = 0;
//        CGFloat w = [UIScreen mainScreen].bounds.size.width *0.25;
//        CGFloat h = 184;
//        for (NSInteger i=0; i<4; i++) {
//            
//            
//            LKAddStudentTimeView *timeViewItem = [[LKAddStudentTimeView alloc]initWithFrame:CGRectMake(i*w, y, w, h)];
//            
//            
//            timeViewItem.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0)green:((float)arc4random_uniform(256) / 255.0)blue:((float)arc4random_uniform(256) / 255.0)alpha:
//                                            1.0];
//            
//            [self.timeView addSubview:timeViewItem];
//
//        }
//        
//        
//    }
//    return _timeView;
//    
//    
//}
-(NSArray *)arrayList
{
    if (_arrayList == nil) {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"addStudent.plist" ofType:nil];
        NSMutableArray *arrM = [NSMutableArray array];
        NSArray *dictArr = [NSArray arrayWithContentsOfFile:path];
        for (NSDictionary *dict in dictArr) {
            
            
//            StudentGroup *stuGroup = [StudentGroup groupWithDict:dict];
//            
//            NSArray *students = stuGroup.Students;
//            
//            NSMutableArray *stuGrouM = [NSMutableArray array];
//            for (NSDictionary *stuDict in students) {
//                Student *student = [Student studentWithDict:stuDict];
//                [stuGrouM addObject:student];
//            }
//            stuGroup.Students = stuGrouM;
//            [arrM addObject:stuGroup];
            
        }
        _arrayList = arrM;
        
    }
    return _arrayList;
}



// 返回每一组的头部标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.arrayList[section] title];
}



@end
