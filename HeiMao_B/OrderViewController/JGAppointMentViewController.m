//
//  JGAppointMentViewController.m
//  HeiMao_B
//
//  Created by kequ on 15/10/24.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "JGAppointMentViewController.h"
#import "RefreshTableView.h"
#import "HMCourseModel.h"
#import "CourseSummaryListCell.h"
#import "FDCalendar.h"
#import "CourseSummaryDayCell.h"
#import "CourseDetailViewController.h"
#import "NoContentTipView.h"
#import "VacationViewController.h"
#import "JGvalidationView.h"
#import "JGAppointMentMidView.h"
#import "AppointmentCoachTimeInfoModel.h"
#import "JGAppointMentViewController.h"
#import "JGAppointMentFootView.h"
#import "BLInformationManager.h"
#import "YBSignUpStuentListModel.h"
#import <MessageUI/MessageUI.h>

@interface JGAppointMentViewController () <FDCalendarDelegate,JGAppointMentMidViewDelegate,MFMessageComposeViewControllerDelegate,UIAlertViewDelegate>

// 日历
@property(nonatomic,strong) FDCalendar *calendarHeadView;
// 中间预约时间
@property (nonatomic,strong) JGAppointMentMidView *yuYueheadView;

@property (nonatomic,strong) JGAppointMentFootView *toolView;

@property(nonatomic,strong)NSDateFormatter *dateFormattor;

@property (nonatomic ,strong) NSString *startTimeStr;
@property (nonatomic ,strong) NSString *endTimeStr;
@property (strong, nonatomic) NSString *updateTimeString;

@property (nonatomic,strong) UILabel *firstLabel;
@property (nonatomic,strong) UILabel *secondLabel;

@property (nonatomic,copy) NSString *selectDateStr;

@end

@implementation JGAppointMentViewController

#pragma mark - LoingNotification
- (void)didLoginSucess:(NSNotification *)notification
{
    [self fdCalendar:nil didSelectedDate:[NSDate date]];
}

- (void)didLoginoutSucess:(NSNotification *)notifcation
{

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = RGB_Color(244, 249, 250);
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initUI];
    
    [self addNotification];
    
    if ([BLInformationManager sharedInstance].appointmentUserData) {
        [[BLInformationManager sharedInstance].appointmentUserData removeAllObjects];
    }
    
}

#pragma mark Life Sycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self resetNavBar];
    
    self.myNavigationItem.title = @"学员预约";
    
    self.firstLabel.text = nil;
    self.secondLabel.text = nil;
    
    [self fdCalendar:self.calendarHeadView didSelectedDate:[NSDate date]];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

#pragma mark - initUI

- (void)initNavBar
{
    [self resetNavBar];
    
}

-(void)initUI
{
    
    // 顶部日历
    self.calendarHeadView = [[FDCalendar alloc] initWithCurrentDate:[NSDate date]];
    self.calendarHeadView.delegate = self;
    self.calendarHeadView.frame = CGRectMake(0, 64, self.view.width, 30+65);
    [self.view addSubview:self.calendarHeadView];
    
    // 中间方格
    self.yuYueheadView = [[JGAppointMentMidView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.calendarHeadView.frame), self.view.width, 180)];
    self.yuYueheadView.delegate = self;
    [self.view addSubview:self.yuYueheadView];
    
    // 添加预约框
    self.toolView = [[JGAppointMentFootView alloc] init];
    self.toolView.frame = CGRectMake(0, CGRectGetMaxY(self.yuYueheadView.frame)+10, self.view.width, 90);
    [self.view addSubview:self.toolView];
    self.toolView.parentViewController = self;
    
    // 底部提交按钮
    UIButton *footBtn = [[UIButton alloc] init];
    footBtn.backgroundColor = RGB_Color(31, 124, 235);
    footBtn.frame = CGRectMake(0, self.view.height-50, self.view.width, 50);
    [footBtn setTitle:@"提交" forState:UIControlStateNormal];
    [footBtn setTitle:@"提交" forState:UIControlStateNormal];
    footBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [footBtn addTarget:self action:@selector(footBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:footBtn];
    
    self.firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.toolView.frame)+5, self.view.width, 20)];
    self.firstLabel.backgroundColor = [UIColor clearColor];
    self.firstLabel.textAlignment = NSTextAlignmentLeft;
    self.firstLabel.textColor = [UIColor grayColor];
    self.firstLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:self.firstLabel];
    
    self.secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.firstLabel.frame)+5, self.view.width, 20)];
    self.secondLabel.backgroundColor = [UIColor clearColor];
    self.secondLabel.textAlignment = NSTextAlignmentLeft;
    self.secondLabel.textColor = [UIColor grayColor];
    self.secondLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:self.secondLabel];
    
}

#pragma mark Load Data
- (void)dealErrorResponseWithTableView:(RefreshTableView *)tableview info:(NSDictionary *)dic
{
    [self showTotasViewWithMes:[dic objectForKey:@"msg"]];
    [tableview.refreshHeader endRefreshing];
    [tableview.refreshFooter endRefreshing];
}

- (void)netErrorWithTableView:(RefreshTableView*)tableView
{
    [self showTotasViewWithMes:@"网络异常，稍后重试"];
    [tableView.refreshHeader endRefreshing];
    [tableView.refreshFooter endRefreshing];
}

#pragma mark LoadDayData
- (void)fdCalendar:(FDCalendar *)calendar didSelectedDate:(NSDate *)date
{
    NSLog(@"切换日历代理方法 %s",__func__);
    
    
    if (!self.dateFormattor) {
        self.dateFormattor = [[NSDateFormatter alloc] init];
        [self.dateFormattor setDateFormat:@"yyyy-M-d"];
    }

    NSString * dataStr = [self.dateFormattor stringFromDate:date];
    self.selectDateStr = dataStr;

    // 加载中间预约时间
    [self loadMidYuyueTimeData:dataStr];
    
    // 设置中间筛选框数据
    [self.toolView receiveCoachTimeData:[BLInformationManager sharedInstance].appointmentUserData];
    
    // 设置顶部标题
    self.myNavigationItem.title = [NSString stringWithFormat:@"%@",[self.dateFormattor stringFromDate:date]];
    
}

- (void)footBtnDidClick
{
    
    NSArray *array = [BLInformationManager sharedInstance].appointmentData;
    if (array&&array.count==0) {
        [self showTotasViewWithMes:@"请选择预约时间"];
        return;
    }
    
    NSArray *userArray = [BLInformationManager sharedInstance].appointmentUserData;
    if (userArray&&userArray.count==0) {
        [self showTotasViewWithMes:@"请选择预约学员"];
        return;
    }
    
    
    // 数组排序
    NSArray *resultArray = [array sortedArrayUsingComparator:^NSComparisonResult(AppointmentCoachTimeInfoModel *  _Nonnull obj1, AppointmentCoachTimeInfoModel *  _Nonnull obj2) {
        //obj1.coursetime.numMark < obj2.coursetime.numMark
        return obj1.coursetime.numMark > obj2.coursetime.numMark ;
        
    }];
    NSLog(@"appointmentData resultArray:%@",resultArray);

    AppointmentCoachTimeInfoModel *firstModel = resultArray.firstObject;
    AppointmentCoachTimeInfoModel *lastModel = resultArray.lastObject;
    
    NSArray *beginArray = [firstModel.coursetime.begintime componentsSeparatedByString:@":"];
    NSString *beginString = beginArray.firstObject;
    _startTimeStr = [NSString stringWithFormat:@"%d",[self chagetime:beginString data:_updateTimeString]];
    
    NSArray *endArray = [lastModel.coursetime.endtime componentsSeparatedByString:@":"];
    NSString *endString = endArray.firstObject;
    _endTimeStr = [NSString stringWithFormat:@"%d",[self chagetime:endString data:_updateTimeString]];
    
    NSLog(@"self.selectDateStr:%@",self.selectDateStr);
    NSLog(@"firstModel.coursetime.begintime:%@",firstModel.coursetime.begintime);
    NSLog(@"lastModel.coursetime.endtime:%@",lastModel.coursetime.endtime);
    
    NSMutableString *courselistStr = [NSMutableString string];
    for (int i = 0; i<resultArray.count; i++) {
        
        AppointmentCoachTimeInfoModel *model = resultArray[i];
        
        NSString *courseID = model.infoId;
        NSLog(@"courseID:%@",courseID);
        
        if (i==resultArray.count-1) {
            NSString *lastID = ((AppointmentCoachTimeInfoModel *)[resultArray lastObject]).infoId;
            [courselistStr appendString:[NSString stringWithFormat:@"%@",lastID]];
        }else{
            [courselistStr appendString:[NSString stringWithFormat:@"%@,",courseID]];
        }

    }
        
    /*
     
     "userid": "560539bea694336c25c3acb9",（用户id）
     
     "coachid": "5616352721ec29041a9af889",（教练id）
     
     "courselist": "5616352721ec29041a9af889, 5616352721ec29041a9af889",（课程id列表）
     
     "is_shuttle": 1,（是否接送1接送0不接送）
     
     "address": "sdfsdfsdfdsfdssf",（接送地址）
     
     "begintime": "2015-09-10 10:00:00",（课程的开始时间
     
     "endtime": "2015-09-10 14:00:00"（课程结束时间）
     
     */
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userid"] = ((YBSignUpStuentListModel *)[BLInformationManager sharedInstance].appointmentUserData[0]).userInfooModel._id;
    params[@"coachid"] = [[UserInfoModel defaultUserInfo] userID];
    params[@"courselist"] = courselistStr;
    params[@"is_shuttle"] = @"1";
    params[@"address"] = @"";
    params[@"begintime"] = [NSString stringWithFormat:@"%@ %@",self.selectDateStr,firstModel.coursetime.begintime];
    params[@"endtime"] = [NSString stringWithFormat:@"%@ %@",self.selectDateStr,lastModel.coursetime.endtime];
    
    NSLog(@"预约params:%@",params);
    
    [NetWorkEntiry postcourseinfoUserreservationcourseWithParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"params:%@ responseObject:%@",params,responseObject);
        
        /*
         
         params:{
             address = "";
             begintime = "2016-2-5 10:00:00";
             coachid = 564227ec1eb4017436ade69c;
             courselist = "56b2c0c43b91852651223d29,56b2c0c43b91852651223d2a,56b2c0c43b91852651223d2b,56b2c0c43b91852651223d2c";
             endtime = "2016-2-5 14:00:00";
             "is_shuttle" = 1;
             userid = 564cba5cd3714e510b0d8333;
         } responseObject:{
             data = success;
             msg = "";
             type = 1;
         }
         
         */
        NSDictionary *param = responseObject;
        
        NSString *type = [NSString stringWithFormat:@"%@",param[@"type"]];
        NSString *message = [NSString stringWithFormat:@"%@",param[@"msg"]];

        if ([type isEqualToString:@"1"]) {
            
            UIAlertView * alerView = [[UIAlertView alloc] initWithTitle:nil message:@"恭喜您预约成功，是否短信通知学员" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
            
            [alerView show];
     
        }else {
            
            NSLog(@"预约失败");
            [self showPopAlerViewWithMes:message];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error.debugDescription:%@",error.debugDescription);
        
    }];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSLog(@"buttonIndex:%ld",(long)buttonIndex);
    
    if (buttonIndex==0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (buttonIndex==1){
        
        if (((YBSignUpStuentListModel *)[BLInformationManager sharedInstance].appointmentUserData[0]).userInfooModel.mobile && [((YBSignUpStuentListModel *)[BLInformationManager sharedInstance].appointmentUserData[0]).userInfooModel.mobile length]!=0) {
    
            NSString *mobil = ((YBSignUpStuentListModel *)[BLInformationManager sharedInstance].appointmentUserData[0]).userInfooModel.mobile;
    
//            params[@"begintime"] = [NSString stringWithFormat:@"%@ %@",self.selectDateStr,firstModel.coursetime.begintime];
//            params[@"endtime"] = [NSString stringWithFormat:@"%@ %@",self.selectDateStr,lastModel.coursetime.endtime];
//            
            [self showMessageView:[NSArray arrayWithObjects:mobil, nil] title:nil body:nil];
    
        }
        [self.navigationController popViewControllerAnimated:YES];
    
    }

}


// 群发短信功能
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    //    [self.dismissViewControllerAnimated:YEScompletion:nil];
    
    switch(result){
            
        caseMessageComposeResultSent:
            
            //信息传送成功
            
            break;
            
        caseMessageComposeResultFailed:
            
            //信息传送失败
            
            break;
            
        caseMessageComposeResultCancelled:
            
            //信息被用户取消传送
            
            break;
            
        default:
            
            break;
            
    }
    
}

-(void)showMessageView:(NSArray*)phones title:(NSString*)title body:(NSString*)body
{
    
    NSLog(@"phones:%@",phones);
    
    if([MFMessageComposeViewController canSendText])
    {
        MFMessageComposeViewController*controller=[[MFMessageComposeViewController alloc]init];
        controller.recipients=phones;
        controller.navigationBar.tintColor=[UIColor redColor];
        controller.body=body;
        controller.messageComposeDelegate=self;
        [self presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers] lastObject]navigationItem]setTitle:title];//修改短信界面标题
    }
    else
    {
        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"提示信息"
                                                    message:@"该设备不支持短信功能"
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil,nil];
        [alert show];
    }
}

#pragma mark ---- 修改UI
- (void)kCellChange
{
    
    NSArray *array = [BLInformationManager sharedInstance].appointmentData;
    if (array&&array.count==0) {
        [self showTotasViewWithMes:@"请选择预约时间"];
        return;
    }
    
    NSArray *userArray = [BLInformationManager sharedInstance].appointmentUserData;
    if (userArray&&userArray.count==0) {
        [self showTotasViewWithMes:@"请选择预约学员"];
        return;
    }
    
    
    // 数组排序
    NSArray *resultArray = [array sortedArrayUsingComparator:^NSComparisonResult(AppointmentCoachTimeInfoModel *  _Nonnull obj1, AppointmentCoachTimeInfoModel *  _Nonnull obj2) {
        //obj1.coursetime.numMark < obj2.coursetime.numMark
        return obj1.coursetime.numMark > obj2.coursetime.numMark ;
        
    }];
    
    AppointmentCoachTimeInfoModel *firstModel = resultArray.firstObject;
    AppointmentCoachTimeInfoModel *lastModel = resultArray.lastObject;
    
    NSArray *beginArray = [firstModel.coursetime.begintime componentsSeparatedByString:@":"];
    NSString *beginString = beginArray.firstObject;
    _startTimeStr = [NSString stringWithFormat:@"%d",[self chagetime:beginString data:_updateTimeString]];
    
    NSArray *endArray = [lastModel.coursetime.endtime componentsSeparatedByString:@":"];
    NSString *endString = endArray.firstObject;
    _endTimeStr = [NSString stringWithFormat:@"%d",[self chagetime:endString data:_updateTimeString]];
    
    
    NSLog(@"self.selectDateStr:%@",self.selectDateStr);
    NSLog(@"firstModel.coursetime.begintime:%@",firstModel.coursetime.begintime);
    NSLog(@"lastModel.coursetime.endtime:%@",lastModel.coursetime.endtime);
    
    if ([BLInformationManager sharedInstance].appointmentUserData && [BLInformationManager sharedInstance].appointmentUserData.count!=0) {
        self.firstLabel.text = [NSString stringWithFormat:@"  当前预约为%@",((YBSignUpStuentListModel *)[BLInformationManager sharedInstance].appointmentUserData[0]).courseprocessdesc];
    }
    if ([BLInformationManager sharedInstance].appointmentUserData && [BLInformationManager sharedInstance].appointmentUserData.count!=0) {
        if (((YBSignUpStuentListModel *)[BLInformationManager sharedInstance].appointmentUserData[0]).confirmhours&&[((YBSignUpStuentListModel *)[BLInformationManager sharedInstance].appointmentUserData[0]).confirmhours length]!=0) {
            self.secondLabel.text = [NSString stringWithFormat:@"  已确认练车课时为%@课时",((YBSignUpStuentListModel *)[BLInformationManager sharedInstance].appointmentUserData[0]).confirmhours];
        }
    }
    
}

- (int)chagetime:(NSString *)timeStr data:(NSString *)dataStr {
    NSLog(@"%@%@",timeStr,dataStr);
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    //设置格式
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss.0";
    //将符合格式的字符串转成NSDate对象
    NSDate *date = [df dateFromString:[NSString stringWithFormat:@"%@ %@:00:00",dataStr,timeStr]];
    //计算一个时间和系统当前时间的时间差
    int second = [date timeIntervalSince1970];
    return second;
}

#pragma mark --- 中间日程点击事件
- (void)JGAppointMentMidViewWithCollectionViewDidSelectItemAtIndexPath:(NSIndexPath *)indexPath timeInfo:(AppointmentCoachTimeInfoModel *)model
{
    NSLog(@"刷新底部数据");
}

- (void)loadMidYuyueTimeData:(NSString *)dataStr
{
    
    NSLog(@"loadMidYuyueTimeData dataStr:%@",dataStr);
    
    NSString *userId = [[UserInfoModel defaultUserInfo] userID];
    if (userId==nil) {
        return;
    }
    
    WS(ws);
    [NetWorkEntiry getAllCourseTimeWithUserId:userId DayTime:dataStr success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"loadMidYuyueTimeData responseObject:%@",responseObject);
        
        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        
        if (type == 1) {
            
            NSError *error=nil;
            
            NSArray *dataArray = [MTLJSONAdapter modelsOfClass:AppointmentCoachTimeInfoModel.class fromJSONArray:responseObject[@"data"] error:&error];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [ws.yuYueheadView receiveCoachTimeData:dataArray];
                
            });
            
        }else{
            
            [ws dealErrorResponseWithTableView:nil info:responseObject];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [ws netErrorWithTableView:nil];
        
    }];
    
}


#pragma mark -
//其他页面预约状态发生变化，通知本页面更新
- (void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(needRefresh:) name:KCourseViewController_NeedRefresh object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLoginSucess:) name:@"kLoginSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLoginoutSucess:) name:@"kLoginoutSuccess" object:nil];

    // 预约接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kCellChange) name:@"kCellChange" object:nil];

}

- (void)needRefresh:(NSNotification *)notification
{
//    [self.courseDayTableView reloadData];
}

@end