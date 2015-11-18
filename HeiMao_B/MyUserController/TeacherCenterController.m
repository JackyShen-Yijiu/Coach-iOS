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
#define kSystemWide [UIScreen mainScreen].bounds.size.width

#define kSystemHeight [UIScreen mainScreen].bounds.size.height

@interface TeacherCenterController ()<UITableViewDataSource,UITableViewDelegate,UserCenterHeadViewDelegte>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *tableHeadView;
@property (strong, nonatomic) UserCenterHeadView *userCenterView;
@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) NSArray *imageArray;

@end
@implementation TeacherCenterController

- (NSArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = @[@[@"挂靠驾校",@"训练场地",@"工作时间",@"可授科目",@"班型设置"],@[@"休假",@"学员列表",@"钱包"],@[@"设置"]];
    }
    return _dataArray;
}
- (NSArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = @[@[@"dependSchool.png",@"studyGround.png",@"workTime.png",@"teachSubject.png",@"sendMeet.png"],@[@"rest.png",@"studentList.png",@"wallet.png"],@[@"setting.png"]];
    }
    return _imageArray;
}
- (UserCenterHeadView *)userCenterView {
    if (_userCenterView == nil) {
        _userCenterView = [[UserCenterHeadView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 80) withUserPortrait:[UserInfoModel defaultUserInfo].portrait withUserPhoneNum:[UserInfoModel defaultUserInfo].tel withUserIdNum:[UserInfoModel defaultUserInfo].displaycoachid];
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
    
    self.tableView.tableFooterView = [self tableFootView];
    
    self.tableView.tableHeaderView = self.userCenterView;
    
}
- (UIButton *)tableFootView {
    UIButton *quit = [UIButton buttonWithType:UIButtonTypeCustom];
    quit.backgroundColor = [UIColor whiteColor];
    [quit setTitle:@"退出" forState:UIControlStateNormal];
    quit.titleLabel.font = [UIFont systemFontOfSize:14];
    [quit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    quit.frame = CGRectMake(0, 0, kSystemWide, 44);
    [quit addTarget:self action:@selector(clickQuit:) forControlEvents:UIControlEventTouchUpInside];
    return quit;
    
}
- (void)clickQuit:(UIButton *)sender {
    [[UserInfoModel defaultUserInfo] loginOut];
    [self.navigationController popToRootViewControllerAnimated:YES];
 
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }else if (section == 1) {
        return 3;
    }else if (section == 2) {
        return 1;
    }
    return 0;
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

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

     if (indexPath.section == 1 && indexPath.row == 2 ) {
        MyWalletViewController *myWallet = [[MyWalletViewController alloc] init];
        [self.navigationController pushViewController:myWallet animated:YES];
     }else if (indexPath.section == 1 && indexPath.row == 1) {
         StudentListViewController *student = [[StudentListViewController alloc] init];
         [self.navigationController pushViewController:student animated:YES];
     }else if (indexPath.section == 1 && indexPath.row == 0) {
         VacationViewController *vacation = [[VacationViewController alloc] init];
         [self.navigationController pushViewController:vacation animated:YES];
     }else if (indexPath.section == 0 && indexPath.row == 3) {
         TeachSubjectViewController *teach = [[TeachSubjectViewController alloc] init];
         [self.navigationController pushViewController:teach animated:YES];
     }else if (indexPath.section == 0 && indexPath.row == 0) {
         AffiliatedSchoolViewController *query = [[AffiliatedSchoolViewController alloc] init];
         [self.navigationController pushViewController:query animated:YES];
     }else if (indexPath.section == 0 && indexPath.row == 2) {
         WorkTimeViewController *workTime = [[WorkTimeViewController alloc] init];
         [self.navigationController pushViewController:workTime animated:YES];
     }else if (indexPath.section == 0 && indexPath.row == 1) {
         if ([UserInfoModel defaultUserInfo].schoolId) {
             TrainingGroundViewController *training = [[TrainingGroundViewController alloc] init];
             [self.navigationController pushViewController:training animated:YES];
         }
     }else if (indexPath.section == 0 && indexPath.row == 4) {
         ExamClassViewController *examClass = [[ExamClassViewController alloc] init];
         [self.navigationController pushViewController:examClass animated:YES];
     }else if (indexPath.section == 2 && indexPath.row == 0) {
         SetupViewController *setUp = [[SetupViewController alloc] init];
         [self.navigationController pushViewController:setUp animated:YES];
     }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
#pragma mark - 更新头像
    [self.userCenterView.userPortrait sd_setImageWithURL:[NSURL URLWithString:[UserInfoModel defaultUserInfo].portrait] placeholderImage:[UIImage imageNamed:@"littleImage.png"]];
    self.userCenterView.userIdNum.text = [UserInfoModel defaultUserInfo].displaycoachid;
    self.userCenterView.userPhoneNum.text = [UserInfoModel defaultUserInfo].tel;
}
@end
