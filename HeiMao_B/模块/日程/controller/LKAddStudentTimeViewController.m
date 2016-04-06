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
#import "BLInformationManager.h"
#import "LKAddStudentNoDataView.h"

static NSString *addStuCellID = @"addStuCellID";

@interface LKAddStudentTimeViewController ()<UITableViewDelegate,UITableViewDataSource>

/// 时间小控件
@property (nonatomic, strong) LKAddStudentTimeView *timeViewItem;

@property (nonatomic, strong) LKAddStudentNoDataView *noDataView;

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

@property (strong, nonatomic) NSMutableArray *upDateArray;
@property (nonatomic ,strong) NSString *startTimeStr;
@property (nonatomic ,strong) NSString *endTimeStr;

@end

@implementation LKAddStudentTimeViewController

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
    
    self.navigationItem.title = @"添加学员";

    self.selectedRows = [NSMutableArray array];

    self.tableView.rowHeight = 80;
    
    
    self.noDataView = [[LKAddStudentNoDataView alloc]initWithFrame:CGRectMake(0, 64 + 48, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64 - 48)];

    self.noDataView.hidden = YES;
    [self.view addSubview:self.noDataView];

    self.myNavigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"添加" highTitle:@"添加" target:self action:@selector(addStudent) isRightItem:YES];

    
//    [self showTotasViewWithMes:@"加载中"];
    
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
        
        data.indexPath = i;
        
        if ((self.courseStudentCountInt - self.selectedstudentconutInt) > 0) {
            

            [timeViewItem.selectButton setImage:[UIImage imageNamed:@"sendmsg_normal_icon"] forState:UIControlStateNormal];
            
            
            [timeViewItem.selectButton setImage:[UIImage imageNamed:@"sendmsg_selected_icon"] forState:UIControlStateSelected];
            
            
        }else if ((self.courseStudentCountInt - self.selectedstudentconutInt) <= 0){
            [timeViewItem.selectButton setTitle:@"已满" forState:UIControlStateNormal];
            [timeViewItem.selectButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

            self.navigationItem.hidesBackButton = YES;
            self.navigationItem.rightBarButtonItem.customView.hidden=YES;
            
        
            [self.tableView setUserInteractionEnabled:NO];
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
        
        NSLog(@"有数据吗有数据吗-%@",(NSDictionary *)result);
        
        NSDictionary *param = responseObject;
        if ([param[@"type"] integerValue] == 1) {
            
            
            NSArray *stundentData = result[@"data"];
            
            if (stundentData.count) {
                

            
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

            }else{
                
                self.navigationItem.rightBarButtonItem.customView.hidden=YES;

                 self.tableView.hidden = YES;
                
                self.noDataView.hidden = NO;
                self.noDataView.noDataLabel.text = @"您暂时没有可预约的学员";

            }
            
        }else{
            self.navigationItem.rightBarButtonItem.customView.hidden=YES;
           
            self.tableView.hidden = YES;
            self.noDataView.hidden = NO;
            self.noDataView.noDataLabel.text = @"您暂时没有可预约的学员";
        }

     
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//           [self showTotasViewWithMes:@"网络错误"];
        self.navigationItem.rightBarButtonItem.customView.hidden=YES;

        self.noDataView.hidden = NO;
         self.tableView.hidden = YES;
        self.noDataView.noDataLabel.text = @"网络出错啦，请查看网络后再次尝试";


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
   
    cell.callStudentButton.tag = data.mobile.integerValue;
    
    [cell.callStudentButton addTarget:self action:@selector(callStudentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
   
    
    [cell.studentIconView sd_setImageWithURL:iconUrl placeholderImage:[UIImage imageNamed:@"JZCoursehead_null"]];
    
    return cell;
}

-(void)callStudentButtonClick:(UIButton*)sender {

    if (sender.tag) {
        NSString * telNum = [NSString stringWithFormat:@"telprompt://%zd",sender.tag];
        
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telNum]];
    
    }else{
            [self showTotasViewWithMes:@"无该用户手机号码"];
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *str = [[self.LetterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    
    LKAddStudentData *data = [self.dataDict objectForKey:str];
    
    if (!data.isSelect) {
        // 继续选择
        if (self.selectedIndexPaths.count>=1) {
            [self showPopAlerViewWithMes:@"您每次最多可以添加一名学员"];
            return;
        }
    }
    
    self.userid = data.userid.copy;
    
    data.isSelect = !data.isSelect;
    
    if (data == nil) {
        [self showTotasViewWithMes:@"该学员信息未完善"];
        
    }else{
        [self.dataDict setObject:data forKey:str];
    }
    
    
    
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
    
    YBCourseData *model = self.dataArray[sender.tag-1000];
    
    if (model.is_selected == NO) {
        
        if (self.upDateArray.count == 0) {
            
            sender.selected = !sender.selected;
            model.is_selected = YES;
            [self.upDateArray addObject:model];
            [self.dataArray replaceObjectAtIndex:sender.tag-1000 withObject:model];
            [BLInformationManager sharedInstance].appointmentData = self.upDateArray;
            
            return;
        }
        
        for (YBCourseData *UpDatemodel in self.upDateArray) {
            
            if ((model.indexPath + 1 == UpDatemodel.indexPath )|| (model.indexPath-1 == UpDatemodel.indexPath)) {
                
                sender.selected = !sender.selected;
                model.is_selected = YES;
                [self.upDateArray addObject:model];
                [self.dataArray replaceObjectAtIndex:sender.tag-1000 withObject:model];
                [BLInformationManager sharedInstance].appointmentData = self.upDateArray;
                
                return;
            }
        }
        
        
        ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:@"请选择连续的时间"];
        [alertView show];
        
    }else if (model.is_selected == YES) {
        
        NSArray *array = [BLInformationManager sharedInstance].appointmentData;
        
        NSArray *resultArray = [array sortedArrayUsingComparator:^NSComparisonResult(YBCourseData *  _Nonnull obj1, YBCourseData *  _Nonnull obj2) {
            //obj1.coursetime.numMark < obj2.coursetime.numMark
            return obj1.coursetime.timeid > obj2.coursetime.timeid ;
        }];
        YBCourseData *fistModel = resultArray.firstObject;
        YBCourseData *lastModel = resultArray.lastObject;
        
        if ([fistModel._id isEqualToString:model._id]||[lastModel._id isEqualToString:model._id]) {
            
            sender.selected = !sender.selected;
            model.is_selected = NO;
            [self.upDateArray removeObject:model];
            [self.dataArray replaceObjectAtIndex:sender.tag-1000 withObject:model];
            [BLInformationManager sharedInstance].appointmentData = self.upDateArray;
            
            return;
            
        }else {
            
            ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:@"操作会造成预约时间不连续"];
            [alertView show];
            
            return;
        }
       
        sender.selected = !sender.selected;
        model.is_selected = NO;
        [self.upDateArray removeObject:model];
        [self.dataArray replaceObjectAtIndex:sender.tag-1000 withObject:model];
        [BLInformationManager sharedInstance].appointmentData = self.upDateArray;
        
    }
    
}

- (int)chagetime:(NSString *)timeStr data:(NSString *)dataStr {
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    //设置格式
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss.0";
    
    //将符合格式的字符串转成NSDate对象
    NSDate *date = [df dateFromString:[NSString stringWithFormat:@"%@ %@",dataStr,timeStr]];
    NSLog(@"chagetime date:%@",date);
    
    //计算一个时间和系统当前时间的时间差
    int second = [date timeIntervalSince1970];
    
    return second;
    
}

#pragma mark - 点击右侧添加学员
-(void)addStudent {
    
    
    
    NSArray *array = [BLInformationManager sharedInstance].appointmentData;
    NSLog(@"%@",array);
    if (array&&array.count==0) {
        [self showTotasViewWithMes:@"请选择预约时间"];
        
        
        
        return;
    }
    
    // 数组排序
    NSArray *resultArray = [array sortedArrayUsingComparator:^NSComparisonResult(YBCourseData *  _Nonnull obj1, YBCourseData *  _Nonnull obj2) {
        
        return obj1.coursetime.timeid > obj2.coursetime.timeid ;
        
    }];
    NSLog(@"appointmentData resultArray:%@",resultArray);
    
    YBCourseData *firstModel = resultArray.firstObject;
    YBCourseData *lastModel = resultArray.lastObject;
    
    NSLog(@"firstModel.coursetime.begintime:%@",firstModel.coursetime.begintime);
    NSLog(@"lastModel.coursetime.endtime:%@",lastModel.coursetime.endtime);
    
    NSMutableString *courselistStr = [NSMutableString string];
    for (int i = 0; i<resultArray.count; i++) {
        
        YBCourseData *model = resultArray[i];
        
        NSString *courseID = model._id;
        NSLog(@"courseID:%@",courseID);
        
        if (i==resultArray.count-1) {
            NSString *lastID = ((YBCourseData *)[resultArray lastObject])._id;
            [courselistStr appendString:[NSString stringWithFormat:@"%@",lastID]];
        }else{
            [courselistStr appendString:[NSString stringWithFormat:@"%@,",courseID]];
        }
        
    }

    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    params[@"userid"] = self.userid;
    params[@"coachid"] = [[UserInfoModel defaultUserInfo] userID];
    params[@"courselist"] = courselistStr;
    params[@"is_shuttle"] = @"1";
    params[@"address"] = @"";
    params[@"begintime"] = [NSString stringWithFormat:@"%@ %@",self.selectData,firstModel.coursetime.begintime];//[NSString stringWithFormat:@"%d",[self chagetime:firstModel.coursetime.begintime data:self.selectData]];
    params[@"endtime"] = [NSString stringWithFormat:@"%@ %@",self.selectData,lastModel.coursetime.endtime];//[NSString stringWithFormat:@"%d",[self chagetime:lastModel.coursetime.endtime data:self.selectData]];

    NSLog(@"返回给后台的数据=====%@=====",params);

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
        [self showTotasViewWithMes:@"网络出错，添加失败"];
        
    }];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)upDateArray {
    if (_upDateArray == nil) {
        _upDateArray = [[NSMutableArray alloc] init];
    }
    return _upDateArray;
}

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



@end
