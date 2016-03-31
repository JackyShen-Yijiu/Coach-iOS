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
#import "ChineseString.h"

static NSString *addStuCellID = @"addStuCellID";

@interface LKAddStudentTimeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) LKAddStudentTimeView *timeViewItem;
@property (nonatomic, strong) UIView *timeView;
///  记录选中的cell
@property (nonatomic, strong) NSMutableArray *selectedRows;

@property (nonatomic, strong) NSMutableArray *stundentDataArrM;

@property (nonatomic, strong) UITableView *tableView;

/// 选择按钮的数组
@property (nonatomic, strong) NSMutableArray *selectBtnArrM;

///按钮状态
@property (nonatomic, assign) BOOL buttonType;

@property(nonatomic, strong)NSMutableArray *selectedIndexPaths;

@property (nonatomic,weak) UIButton *selectBtn;

/// 开始时间
@property (nonatomic, copy) NSString * begintime;
/// 结束时间
@property (nonatomic, copy) NSString * endtime;



/// 添加学员数据
@property (nonatomic, strong) NSMutableArray *arrMData;

@property(nonatomic,strong)NSMutableArray *indexArray;

@property(nonatomic,retain)NSMutableArray *LetterResultArr;

@property(nonatomic,retain) NSMutableDictionary *dataDict;


@end

@implementation LKAddStudentTimeViewController
- (NSMutableArray *)indexArray
{
    if (_indexArray==nil) {
        _indexArray = [NSMutableArray array];
    }
    return _indexArray;
}
- (NSMutableArray *)LetterResultArr
{
    if (_LetterResultArr==nil) {
        _LetterResultArr = [NSMutableArray array];
    }
    return _LetterResultArr;
}
- (NSMutableDictionary *)dataDict
{
    if (_dataDict==nil) {
        _dataDict = [NSMutableDictionary dictionary];
    }
    return _dataDict;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _stundentDataArrM = [NSMutableArray array];
    
    self.selectedIndexPaths = [NSMutableArray array];
    
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
//    self.tableView.allowsMultipleSelection = YES;
    //
    self.selectedRows = [NSMutableArray array];
    //
    //    // Do any additional setup after loading the view, typically from a nib.
    //    [self.tableView registerClass:[LKAddStudentTableViewCell class] forCellReuseIdentifier:addStuCellID];
    self.tableView.rowHeight = 80;
    //    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    //    //    self.edgesForExtendedLayout = UIRectEdgeNone;
    //

    self.myNavigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"添加" highTitle:@"添加" target:self action:@selector(addStudent) isRightItem:YES];

    
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
        
    
        
        if ((self.courseStudentCountInt - self.selectedstudentconutInt) > 0) {
            
            [timeViewItem.selectButton setImage:[UIImage imageNamed:@"sendmsg_normal_icon"]  forState:UIControlStateNormal];
            
            
            [timeViewItem.selectButton setImage:[UIImage imageNamed:@"sendmsg_selected_icon"] forState:UIControlStateSelected];
            
            
        }else if ((self.courseStudentCountInt - self.selectedstudentconutInt) <= 0){
            [timeViewItem.selectButton setTitle:@"已满" forState:UIControlStateNormal];
            [timeViewItem.selectButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        }

        
        timeViewItem.starTimeLabel.text = [NSString getHourLocalDateFormateUTCDate:data.coursebegintime];
        
        timeViewItem.finishTimeLabel.text = [NSString getHourLocalDateFormateUTCDate:data.courseendtime];
        
        [self.timeView addSubview:timeViewItem];
        
    }
    
    NSLog(@"%@",self.studentDataM);
    
    self.timeView = timeView;
    
}
#pragma mark - 取消选择的cell

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//   
//    LKAddStudentTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    //如果取消已选择的cell,从记录移除
//    [self.selectedRows removeObject:indexPath];
//    
//    [self.selectedIndexPaths removeObject:indexPath];
//     [self.selectedRows replaceObjectAtIndex:indexPath.row withObject:self.selectedRows];
//    
    //    NSLog(@"%@",indexPath);
}

#pragma mark - 数据获取
- (void)initData{
    //如果教练是什么都交  返回 -1   不是返回交的课程
    
    [NetWorkEntiry addstudentsListwithCoachid:self.coachidStr subjectID:(NSString *)@(-1) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        id result = responseObject;
        
        
        NSArray *stundentData = result[@"data"];
        
        for (NSDictionary *dict in stundentData) {
            
            LKAddStudentData *data = [LKAddStudentData yy_modelWithDictionary:dict];

            [self.stundentDataArrM addObject:data];
            
        }
        
        NSMutableArray *nameArray = [NSMutableArray array];
        for (LKAddStudentData *data in self.stundentDataArrM) {
            
            [nameArray addObject:data.name];
            
            [self.dataDict setObject:data forKey:data.name];
            
        }
        
        // 返回tableview右方 indexArray
        self.indexArray = [ChineseString IndexArray:nameArray];
        
        // 返回联系人
        self.LetterResultArr = [ChineseString LetterSortArray:nameArray];
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"LKAddStudentTimeViewController--数据获取出错，错误:%@",error);
        
    }];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.indexArray.count;
}

#pragma mark - table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self.LetterResultArr objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LKAddStudentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:addStuCellID];
    if (!cell) {
        cell = [[LKAddStudentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addStuCellID];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    NSLog(@"%@",self.stundentDataArrM);
    
    
//    LKAddStudentData *data = self.stundentDataArrM[indexPath.row];
    
    NSString *str = [[self.LetterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    
    LKAddStudentData *data = [self.dataDict objectForKey:str];
    
    if (data.isSelect) {
        
        cell.selectImageView.image = [UIImage imageNamed:@"sendmsg_selected_icon"];
        
    }else{
        
        cell.selectImageView.image = [UIImage imageNamed:@"sendmsg_normal_icon"];
        
    }
    
    cell.studentNameLabel.text = data.name;
    
    if (data.subject.subjectid == 2) {
        cell.studyDetilsLabel.text = data.subjecttwo.progress;
        
    } else if (data.subject.subjectid == 3) {
        cell.studyDetilsLabel.text = data.subjectthree.progress;
        
    }
    
    
    NSURL *iconUrl = [NSURL URLWithString:data.headportrait.originalpic];
    NSLog(@"bfsbff%@",iconUrl);
    
    [cell.studentIconView sd_setImageWithURL:iconUrl placeholderImage:[UIImage imageNamed:@"JZCoursenull_student"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *str = [[self.LetterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    
    LKAddStudentData *data = [self.dataDict objectForKey:str];
    
    if (!data.isSelect) {
        // 继续选择
        if (self.selectedIndexPaths.count>=1) {
            [self showPopAlerViewWithMes:@"您最多可以添加一名学员"];
            return;
        }
    }
    
    self.userid = data.userid.copy;
    
    data.isSelect = !data.isSelect;
    
    [self.dataDict setObject:data forKey:str];
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    if (data.isSelect) {
        [self.selectedIndexPaths addObject:data];
    }else{
        [self.selectedIndexPaths removeAllObjects];
    }
    
    
}

#pragma mark -Section的Header的值
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
#pragma mark - Section header view
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 20)];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, 320, 20)];
    [view addSubview:lab];
    view.backgroundColor = RGB_Color(239, 239, 243);
    
    if (self.indexArray.count==section) {
        
    }
    else
    {
        lab.text = [self.indexArray objectAtIndex:section];
    }
    
    lab.textColor = [UIColor lightGrayColor];
    
    return view;
}

#pragma mark -设置右方表格的索引数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexArray;
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}











#pragma mark - 点击选择时间的按钮
-(void)clickSelectBtn:(UIButton *)sender{
    
    self.selectBtn.selected = !self.selectBtn;
    
    sender.selected = !sender.selected;
    
    self.selectBtn = sender;
    
//    NSLog(@"--第%zd个按钮--",sender.tag);
    LKAddStudentTimeView *lkView = [_timeView viewWithTag:2001];

    self.begintime =lkView.starTimeLabel.text;
    self.endtime = lkView.finishTimeLabel.text;

    //点击时间按钮后，刷新表格数据
    [self.tableView reloadData];
    
}



#pragma mark - 点击右侧添加学员
-(void)addStudent {
    
//    NSLog(@"点击了右侧添加学员");
    
    
    NSString *dataSring = [self.UTCData substringWithRange:NSMakeRange(0, 10)];
/// 开始时间
    NSString *bjBeginDataStr = [NSString stringWithFormat:@"%@ %@",dataSring,self.begintime];
/// 结束时间
    NSString *bjEndDataStr = [NSString stringWithFormat:@"%@ %@",dataSring,self.endtime];

    NSString *courseListID = self.courseList;
    

    NSString *userID = self.userid;
    
    
//    if ((self.courseStudentCountInt - self.selectedstudentconutInt) <= 0) {
         if (self.selectedRows.count > 1) {
    
    [self showPopAlerViewWithMes:@"您最多可以添加一名学员"];

         }


    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    
    
    
    params[@"userid"] = userID;
    params[@"coachid"] = [[UserInfoModel defaultUserInfo] userID];
    params[@"courselist"] = courseListID;
    params[@"is_shuttle"] = @"1";
    params[@"address"] = @"";
    params[@"begintime"] = bjBeginDataStr;
    params[@"endtime"] = bjEndDataStr;

//    NSLog(@"返回给后台的数据=====%@=====",params);
//
    [NetWorkEntiry postcourseinfoUserreservationcourseWithParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"LKAddStudentTimeViewController--添加学员成功");
        NSInteger type = [responseObject[@"type"] integerValue];
        if (type) {
            [self showTotasViewWithMes:@"添加成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            NSString *message = [NSString stringWithFormat:@"%@",responseObject[@"msg"]];
            [self showTotasViewWithMes:message];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"LKAddStudentTimeViewController--添加学员失败--error:%@",error);
        
    }];


}


//
//#pragma mark - tableView数据源方法
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    
//    
//    return self.stundentDataArrM.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    LKAddStudentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:addStuCellID];
//    if (!cell) {
//        cell = [[LKAddStudentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addStuCellID];
//        
//    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    
//    
//    NSLog(@"%@",self.stundentDataArrM);
//    
//    
//    LKAddStudentData *data = self.stundentDataArrM[indexPath.row];
//    
//    if (data.isSelect) {
//        
//        cell.selectImageView.image = [UIImage imageNamed:@"sendmsg_selected_icon"];
//        
//    }else{
//        
//        cell.selectImageView.image = [UIImage imageNamed:@"sendmsg_normal_icon"];
//        
//    }
//    
//    cell.studentNameLabel.text = data.name;
//    
//    if (data.subject.subjectid == 2) {
//        cell.studyDetilsLabel.text = data.subjecttwo.progress;
//        
//    } else if (data.subject.subjectid == 3) {
//        cell.studyDetilsLabel.text = data.subjectthree.progress;
//        
//    }
//    
//    
//    NSURL *iconUrl = [NSURL URLWithString:data.headportrait.originalpic];
//    NSLog(@"bfsbff%@",iconUrl);
//    
//    [cell.studentIconView sd_setImageWithURL:iconUrl placeholderImage:[UIImage imageNamed:@"JZCoursenull_student"]];
//    
//    
//    
//    return cell;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
