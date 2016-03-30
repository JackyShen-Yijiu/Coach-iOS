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

static NSString *addStuCellID = @"addStuCellID";

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
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addStudent)];
    
    rightItem.tintColor = [UIColor whiteColor];
    
    
    
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
        timeViewItem.tag = 2000 + i;
        timeViewItem.selectButton.tag = 1000 + i;
        [timeViewItem.selectButton addTarget:self action:@selector(clickSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
        
#pragma mark - 时间逻辑处理
        // 2016-03-29T22:00:00.000Z
        //11 5
        NSString *starTimeTextData = [NSString getHourLocalDateFormateUTCDate:self.starTimeText];
        NSString *starTimeText1 = [starTimeTextData substringWithRange:NSMakeRange(0, 2)];
        NSString *starTimeText2 = [starTimeTextData substringWithRange:NSMakeRange(2, 3)];
        NSString *starTimeText = [NSString stringWithFormat:@"%zd\%@",starTimeText1.integerValue + i ,starTimeText2];
        
        timeViewItem.starTimeLabel.text = starTimeText;
        
        
        NSString *finishTimeTextData = [NSString getHourLocalDateFormateUTCDate:self.finishTimeText];
        NSString *finishTimeText1 = [finishTimeTextData substringWithRange:NSMakeRange(0, 2)];
        
        
        NSString *finishTimeText2 = [finishTimeTextData substringWithRange:NSMakeRange(2, 3)];
        NSString *finishTimeText = [NSString stringWithFormat:@"%zd\%@",(finishTimeText1.integerValue+i+24)%24,finishTimeText2];
        
        timeViewItem.finishTimeLabel.text = finishTimeText;
        
        [self.timeView addSubview:timeViewItem];
        
    }
    
    //        self.timeView.backgroundColor = [UIColor orangeColor];
    
    
    self.timeView = timeView;
    
    self.tableView.tableHeaderView = self.timeView;
    
    
    
    
    
}

#pragma mark - 点击选择时间的按钮
-(void)clickSelectBtn:(UIButton *)sender{
    
    NSLog(@"--第%zd个按钮--",sender.tag);
    LKAddStudentTimeView *lkView = [_timeView viewWithTag:2001];
    NSLog(@"%@",lkView.starTimeLabel.text);
    
    
    
    
}


#pragma mark - 选择时间界面的行高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return  92;
}

#pragma mark - 点击右侧添加学员
-(void)addStudent {
    
    NSLog(@"点击了右侧添加学员");
}


#pragma mark - 返回的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //    return [[self.arrayList[section] Students] count];
    
    return 100;
}
#pragma mark - 返回的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LKAddStudentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:addStuCellID];
    if (!cell) {
        cell = [[LKAddStudentTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:addStuCellID];
        
    }
    //        StudentGroup *stuGroup = self.arrayList[indexPath.section];
    //        Student *stu = stuGroup.Students[indexPath.row];
    //        cell.studentNameLabel.text = stu.studentNameLabel;
    //        [cell setStudentModel:stu];
    //        cell.studentModel = stuGroup.Students[indexPath.row];
    
    return cell;
}

#pragma mark - 返回的组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.arrayList count];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 返回tableView右边索引栏
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    //   NSArray *indexArr = [self.groupes valueForKeyPath:@"title"];
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:self.arrayList.count];
    //    for (StudentGroup *group in self.arrayList) {
    //        [arrM addObject:group.title];
    //    }
    return arrM;
}

-(NSArray *)arrayList
{
    if (_arrayList == nil) {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"addStudent.plist" ofType:nil];
        NSMutableArray *arrM = [NSMutableArray array];
        NSArray *dictArr = [NSArray arrayWithContentsOfFile:path];
        for (NSDictionary *dict in dictArr) {
            
            
            //                        StudentGroup *stuGroup = [StudentGroup groupWithDict:dict];
            //
            //                        NSArray *students = stuGroup.Students;
            //
            //                        NSMutableArray *stuGrouM = [NSMutableArray array];
            //                        for (NSDictionary *stuDict in students) {
            //                            Student *student = [Student studentWithDict:stuDict];
            //                            [stuGrouM addObject:student];
            //                        }
            //                        stuGroup.Students = stuGrouM;
            //                        [arrM addObject:stuGroup];
            
        }
        _arrayList = arrM;
        
    }
    return _arrayList;
}


#pragma mark - 返回每一组的头部标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.arrayList[section] title];
}



@end
