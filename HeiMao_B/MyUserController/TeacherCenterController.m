//
//  UserController.m
//  HeiMao_B
//
//  Created by kequ on 15/10/24.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "TeacherCenterController.h"
#import "UserCenterHeadView.h"
#import "UserCenterCell.h"
#import "EditorUserViewController.h"
#import "LoginViewController.h"
#import "MyWalletViewController.h"
#import "StudentListViewController.h"
#import "VacationViewController.h"
#import "TeachSubjectViewController.h"
#import "QueryViewController.h"
#import "WorkTimeViewController.h"
#import "TrainingGroundViewController.h"
#import "AffiliatedSchoolViewController.h"
#import "ExamClassViewController.h"
#import "SetupViewController.h"
#import "JSONKit.h"

#define kSystemWide [UIScreen mainScreen].bounds.size.width

#define kSystemHeight [UIScreen mainScreen].bounds.size.height

@interface TeacherCenterController ()<UITableViewDataSource,UITableViewDelegate,UserCenterHeadViewDelegte>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *tableHeadView;
@property (strong, nonatomic) UserCenterHeadView *userCenterView;
@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) NSArray *imageArray;
@property (strong, nonatomic) NSArray *displayArray;
@end
@implementation TeacherCenterController

- (NSArray *)dataArray {
    if (_dataArray == nil) {
       
        //_dataArray = @[@[@"所属驾校",@"训练场地",@"工作时间",@"可授科目",@"班型设置"],@[@"休假",@"学员列表",@"钱包"],@[@"设置"]];
        
        _dataArray = @[@[@"所属驾校",@"工作性质",@"训练场地",@"工作时间",@"可授科目",@"授课班型"],@[@"休假",@"学员列表",@"设置"],@[@"钱包"]];

    }
    return _dataArray;
}

#warning 等待更改图片
- (NSArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = @[@[@"dependSchool.png",@"workPropertyImg.png",@"studyGround.png",@"workTime.png",@"teachSubject.png",@"sendMeet.png"],@[@"rest.png",@"studentList.png",@"setting.png"],@[@"wallet.png"]];
    }
    return _imageArray;
}

- (UserCenterHeadView *)userCenterView {
    if (_userCenterView == nil) {
        _userCenterView = [[UserCenterHeadView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 80) withUserPortrait:[UserInfoModel defaultUserInfo].portrait withUserPhoneNum:[UserInfoModel defaultUserInfo].tel withUserIdNum:[UserInfoModel defaultUserInfo].displaycoachid yNum:@"Y码:22222222"];
        _userCenterView.delegate = self;
    }
    return _userCenterView;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight-49) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource  = self;
        _tableView.backgroundColor = RGB_Color(245, 247, 250);
        
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    self.tableView.tableHeaderView = self.userCenterView;
    
}

- (void)userCenterClick {
    EditorUserViewController *editor = [[EditorUserViewController alloc] init];
    [self.navigationController pushViewController:editor animated:YES];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = RGB_Color(245, 247, 250);
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *dictArray = self.dataArray[section];
    
    return dictArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"cell";
    UserCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UserCenterCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.contentLabel.text = self.dataArray[indexPath.section][indexPath.row];
    
    cell.leftImageView.image = [UIImage imageNamed:self.imageArray[indexPath.section][indexPath.row]];
    
    cell.contentDetail.text = self.displayArray[indexPath.section][indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0 && indexPath.row == 0) {// @"所属驾校"
        AffiliatedSchoolViewController *query = [[AffiliatedSchoolViewController alloc] init];
        [self.navigationController pushViewController:query animated:YES];
    }else if (indexPath.section == 0 && indexPath.row == 1){//// new @"工作性质"
        NSLog(@"工作性质");
    }else if (indexPath.section == 0 && indexPath.row == 2) {// @"训练场地"
        if ([UserInfoModel defaultUserInfo].schoolId) {
            TrainingGroundViewController *training = [[TrainingGroundViewController alloc] init];
            [self.navigationController pushViewController:training animated:YES];
        }
    }else if (indexPath.section == 0 && indexPath.row == 3) {// @"工作时间"
        WorkTimeViewController *workTime = [[WorkTimeViewController alloc] init];
        [self.navigationController pushViewController:workTime animated:YES];
    }else if (indexPath.section == 0 && indexPath.row == 4) {// @"可授科目"
        TeachSubjectViewController *teach = [[TeachSubjectViewController alloc] init];
        [self.navigationController pushViewController:teach animated:YES];
    }else if (indexPath.section == 0 && indexPath.row == 5) {// @"授课班型"
        ExamClassViewController *examClass = [[ExamClassViewController alloc] init];
        [self.navigationController pushViewController:examClass animated:YES];
    }
    
    else if (indexPath.section == 1 && indexPath.row == 0) {// @"休假"
        VacationViewController *vacation = [[VacationViewController alloc] init];
        [self.navigationController pushViewController:vacation animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 1) {// @"学员列表"
        StudentListViewController *student = [[StudentListViewController alloc] init];
        [self.navigationController pushViewController:student animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 2) {// @"设置"
        SetupViewController *setUp = [[SetupViewController alloc] init];
        [self.navigationController pushViewController:setUp animated:YES];
    }
    
    else if (indexPath.section == 2 && indexPath.row == 0) {// @"钱包"
        MyWalletViewController *myWallet = [[MyWalletViewController alloc] init];
        [self.navigationController pushViewController:myWallet animated:YES];
    }
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
#pragma mark - 更新头像
    [self.userCenterView.userPortrait sd_setImageWithURL:[NSURL URLWithString:[UserInfoModel defaultUserInfo].portrait] placeholderImage:[UIImage imageNamed:@"littleImage.png"]];
    self.userCenterView.userIdNum.text = [UserInfoModel defaultUserInfo].displaycoachid;
    self.userCenterView.userPhoneNum.text = [UserInfoModel defaultUserInfo].tel;
    [self initNavBar];
    
   
    // "所属驾校"
    NSString * driveSname = [[UserInfoModel defaultUserInfo].driveschoolinfo objectStringForKey:@"name"];
    // "工作性质"
#warning 通过接口调用
    NSString * workProperty = [[UserInfoModel defaultUserInfo].driveschoolinfo objectStringForKey:@"name"];

    NSString * trainName = [[UserInfoModel defaultUserInfo].trainfieldlinfo objectStringForKey:@"name"];
    NSArray * weekArray = [[UserInfoModel defaultUserInfo] workweek];
    NSString * workSetDes = @"未设置";
    if (weekArray.count) {
        workSetDes = @"已设置";
    }
    
    //可授科目
    NSArray *array = [UserInfoModel defaultUserInfo].subject;
    NSMutableString *string = [[NSMutableString alloc] init];
    if (array.count == 0) {
        [string appendString:@"未设置"];
    }else if(array.count == 1){
        [string appendString:[[array firstObject] objectForKey:@"name"]];
    }else{
        [string appendString:@"已设置"];
    }
    
    //班型设置
    NSString * carName =  [[UserInfoModel defaultUserInfo] setClassMode] ? @"已设置" : @"未设置";
    
    // "休假"
#warning 通过接口调用
    NSString * vacationStr =  [[UserInfoModel defaultUserInfo] setClassMode] ? @"已设置" : @"未设置";
    
    self.displayArray = @[@[
                            [self strTolerance:driveSname],//"所属驾校"
                            [self strTolerance:workProperty],//new - "工作性质"
                            [self strTolerance:trainName],//"训练场地"
                            [self strTolerance:workSetDes],//"工作时间"
                            [self strTolerance:string],//"可授科目"
                            [self strTolerance:carName]//"班型设置"
                          ],
                          @[
                            [self strTolerance:vacationStr],//new - "休假"
                            [self strTolerance:@""],// 学员列表
                            [self strTolerance:@""]// 设置
                            ],
                          @[[self strTolerance:@""]]//钱包
                          ];
  
    [self.tableView reloadData];
}

#pragma mark - initUI

- (void)initNavBar
{
    [self resetNavBar];
    self.myNavigationItem.title = @"我的";
}

@end
