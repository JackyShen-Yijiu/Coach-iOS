//
//  courseDetailViewController.m
//  HeiMao_B
//
//  Created by kequ on 15/10/27.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "CourseDetailViewController.h"
#import "CourseDetailView.h"
#import "SutdentHomeController.h"
#import "CourseCancelController.h"
#import "CoureseRatingController.h"

@interface CourseDetailViewController()<CourseDetailViewDelegate>
@property(nonatomic,strong)CourseDetailView* detailView;
@end
@implementation CourseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark Life Sycle
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self initNavBar];
}
#pragma mark - initUI

- (void)initNavBar
{
    [self resetNavBar];
    self.myNavigationItem.title = @"预约详情";
}

-(void)setCouresID:(NSString *)couresID
{
    _couresID = couresID;
    [self refreshData];
}

- (CourseDetailView *)detailView
{
    if (!_detailView) {
        _detailView = [[CourseDetailView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, [CourseDetailView cellHeight])];
        _detailView.delegate = self;
        [self.view addSubview:_detailView];
    }
    return _detailView;
}
#pragma mark - LoadData
- (void)refreshData
{
    self.detailView.model = self.model;
}

#pragma mark - Action
- (void)courseDetailViewDidClickAgreeButton:(CourseDetailView *)view
{
    //同意
    self.detailView.model.courseStatue = KCourseStatueUnderWay;
    [self.detailView refreshUI];
}

- (void)courseDetailViewDidClickDisAgreeButton:(CourseDetailView *)view
{
    //拒绝
    CourseCancelController * cour = [[CourseCancelController alloc] init];
    cour.controllerType = KControllTypeReject;
    cour.courseId = self.model.courseId;
    [self.navigationController pushViewController:cour animated:YES];
}

- (void)courseDetailViewDidClickCanCelButton:(CourseDetailView *)view
{
    //取消
    CourseCancelController * cour = [[CourseCancelController alloc] init];
    cour.courseId = self.model.courseId;
    cour.controllerType = KControllTypeCancel;
    [self.navigationController pushViewController:cour animated:YES];
}

- (void)courseDetailViewDidClickWatingToDone:(CourseDetailView *)view
{
    //确定学完
}

- (void)courseDetailViewDidClickRecommentButton:(CourseDetailView *)view
{
    //评论
    CoureseRatingController * crc = [[CoureseRatingController alloc] init];
    crc.courseId = self.model.courseId;
    crc.studentModel = self.model.studentInfo;
    [self.navigationController pushViewController:crc animated:YES];
}


- (void)courseDetailViewDidClickStudentDetail:(CourseDetailView *)view
{
    //学员信息
    SutdentHomeController * sudH = [[SutdentHomeController alloc] init];
    sudH.studentId = self.detailView.model.studentInfo.userId;
    [self.navigationController pushViewController:sudH animated:YES];
}

@end
