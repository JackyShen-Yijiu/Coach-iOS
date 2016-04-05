//
//  ScheduleViewController.m
//  HeiMao_B
//
//  Created by kequ on 15/10/24.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "ScheduleViewController.h"
#import "HMCourseModel.h"
#import "CourseSummaryListCell.h"
#import "VacationViewController.h"
#import "JGvalidationView.h"
#import "JGAppointMentViewController.h"
#import "ScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "BLPFAlertView.h"
#import "YBStudentDetailsViewController.h"

#import "YBHomeLeftViewController.h"
#import "YBHomeRightViewController.h"

typedef NS_ENUM(NSInteger, kControllerType) {
    leftVc,
    rightVc
};

@interface ScheduleViewController () 

// 教练资格审核提示框
@property (nonatomic,strong)JGvalidationView*bgView;

@property (nonatomic, strong) UISegmentedControl *segment;

@property (nonatomic,strong) YBHomeLeftViewController *leftVc;

@property (nonatomic,strong) YBHomeRightViewController *rightVc;

@property (nonatomic,assign) kControllerType controllerType;

@end

@implementation ScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.leftVc = [[YBHomeLeftViewController alloc] init];
    self.leftVc.view.frame = self.view.bounds;
    self.leftVc.parentViewController = self;
    [self.view addSubview:self.leftVc.view];
    
    self.rightVc = [[YBHomeRightViewController alloc] init];
    self.rightVc.view.frame = self.view.bounds;
    self.rightVc.parentViewController = self;
    [self.view addSubview:self.rightVc.view];
        
}

#pragma mark Life Sycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    [self resetNavBar];
   
    [self initNavigationItem];
    
    self.myNavigationItem.titleView = self.segment;

    [self didClicksegmentedControlAction:self.segment];
    
    if ([UserInfoModel defaultUserInfo].userID && [UserInfoModel defaultUserInfo].is_validation==NO) {
        _bgView = [[JGvalidationView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 80)];
        [self.myNavController.view addSubview:_bgView];
    }
    
}

- (UISegmentedControl *)segment {
    if (!_segment) {
        _segment = [[UISegmentedControl alloc] initWithItems:@[ @"时间", @"列表 " ]];
        _segment.frame = CGRectMake(100, 100, 100, 30);
        _segment.tintColor = [UIColor whiteColor];
        [_segment addTarget:self action:@selector(didClicksegmentedControlAction:) forControlEvents:UIControlEventValueChanged];
        _segment.selectedSegmentIndex = 0;
    }
    return _segment;
}

- (void)initNavigationItem
{
    self.myNavigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"JZCoursescan" highIcon:@"JZCoursescan" target:self action:@selector(rightBarBtnDidClick)];
    
    self.myNavigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"今天" highTitle:@"今天" target:self action:@selector(leftBarBtnDidClick) isRightItem:NO];
    
}

- (void)didClicksegmentedControlAction:(UISegmentedControl *)seg{
    
    [self.leftVc hiddenOpenCalendar];
    
    self.controllerType = seg.selectedSegmentIndex;
    
    if (0 == seg.selectedSegmentIndex) {

        self.leftVc.view.hidden = NO;
        self.rightVc.view.hidden = YES;
        
        [self initNavigationItem];
        
        [self.leftVc modifyVacation:[NSDate date]];
        
    }else if (1 == seg.selectedSegmentIndex) {
        
        self.leftVc.view.hidden = YES;
        self.rightVc.view.hidden = NO;
        self.myNavigationItem.leftBarButtonItem = nil;
        self.myNavigationItem.rightBarButtonItem = nil;

    }
    
}


- (void)rightBarBtnDidClick
{
    // 检测摄像头的状态
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusDenied) {
        // 用户拒绝App使用
        
        [BLPFAlertView showAlertWithTitle:@"相机不可用" message:@"请在设置中开启相机服务" cancelButtonTitle:@"知道了" otherButtonTitles:@[ @"去设置" ] completion:^(NSUInteger selectedOtherButtonIndex) {
            
            if (0 == selectedOtherButtonIndex) {
                // 打开应用设置面板
                NSURL *appSettingUrl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                [[UIApplication sharedApplication] openURL:appSettingUrl];
            }
            
        }];
        
        return ;
    }
    
    ScanViewController *vc = [[ScanViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)leftBarBtnDidClick
{
    [self.leftVc today];
}


@end