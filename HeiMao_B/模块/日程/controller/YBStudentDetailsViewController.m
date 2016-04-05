//
//  YBStudentDetailsViewController.m
//  HeiMao_B
//
//  Created by JiangangYang on 16/3/30.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "YBStudentDetailsViewController.h"
#import "YBStudentDetailsRootClass.h"
#import "YYModel.h"
#import "YBStudentDetailsData.h"
#import "YBStudentDetailsCoachcommentinfo.h"
#import "YBStudentDetailsStudentinfo.h"
#import "YBStudentDetailHeadView.h"
#import "YBStudentDetailsStudyProgressCell.h"
#import "YBStudentDetailsExamMessageCell.h"
#import "YBStudentDetailsCommentListCell.h"
#import "YBStudentDetailsStudentinfo.h"
#import "YBStudentDetailsCoachcommentinfo.h"
#import "YBStudentDetailsSubjectfour.h"

#define headerViewH 200

@interface YBStudentDetailsViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
{
    UIImageView*navBarHairlineImageView;
}
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YBStudentDetailHeadView *headerView;

@property (nonatomic,strong) YBStudentDetailsRootClass *rootClass;

@end

@implementation YBStudentDetailsViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.backgroundColor = RGB_Color(232, 232, 237);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (YBStudentDetailHeadView *)headerView {
    if (!_headerView) {
        _headerView = [[YBStudentDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, headerViewH)];
        _headerView.parentViewController = self;
    }
    return _headerView;
}

- (UIImageView*)findHairlineImageViewUnder:(UIView*)view {
    
    if([view isKindOfClass:UIImageView.class] && view.bounds.size.height<=1.0) {
        return(UIImageView*)view;
    }
    for(UIView *subview in view.subviews) {
        UIImageView*imageView = [self findHairlineImageViewUnder:subview];
        if(imageView) {
            return imageView;
        }
    }
    return nil;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 隐藏导航条底部分割线
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navBarHairlineImageView.hidden=YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = RGB_Color(232, 232, 237);
    
    [self loadData];
    
    [self setUpUI];
    
}

- (void)setUpUI
{
    
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.headerView.frame), self.view.width, self.view.height-self.headerView.height);
    
}

- (void)loadData
{
    
    [NetWorkEntiry getStudentDetailswithuserid:_studentID success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.rootClass = [YBStudentDetailsRootClass yy_modelWithJSON:responseObject];
        
        NSLog(@"rootClass.data.studentinfo.name:%@",self.rootClass.data.studentinfo.name);
        
        [self.tableView reloadData];
        [self.headerView refreshData:self.rootClass];
        self.title = self.rootClass.data.studentinfo.name;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    if (section==0){
        return 1;
    }else if (section==1){
        return 0;
    }else if (section==2){
        return 4;
    }
    return self.rootClass.data.coachcommentinfo.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10+44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        // 学车进度
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 54)];
        headView.backgroundColor = [UIColor whiteColor];

        UIView *delive = [[UIView alloc] initWithFrame:CGRectMake(16, 53.5, self.view.width-16, 0.5)];
        delive.backgroundColor = [UIColor lightGrayColor];
        delive.alpha = 0.3;
        [headView addSubview:delive];
        
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headView.width, 10)];
        topView.backgroundColor = RGB_Color(232, 232, 237);
        [headView addSubview:topView];
        
        UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 10, 65, headView.height-10)];
        headLabel.font = [UIFont boldSystemFontOfSize:14];
        headLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
        headLabel.textAlignment = NSTextAlignmentLeft;
        headLabel.text = @"学车进度:";
        [headView addSubview:headLabel];
        
        UILabel *headcountentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headLabel.frame)+7, 10, headView.width-CGRectGetMaxX(headLabel.frame)-headLabel.width, headView.height-10)];
        headcountentLabel.font = [UIFont systemFontOfSize:14];
        headcountentLabel.textColor = [UIColor lightGrayColor];
        headcountentLabel.textAlignment = NSTextAlignmentLeft;
        
        NSString *str = [[NSString alloc] init];
        if (self.rootClass.data.studentinfo.subject.subjectid==1) {
            str = self.rootClass.data.studentinfo.subjectone.progress;
        }else if (self.rootClass.data.studentinfo.subject.subjectid==2){
            str = self.rootClass.data.studentinfo.subjecttwo.progress;
        }else if (self.rootClass.data.studentinfo.subject.subjectid==3){
            str = self.rootClass.data.studentinfo.subjectthree.progress;
        }else if (self.rootClass.data.studentinfo.subject.subjectid==4){
            str = self.rootClass.data.studentinfo.subjectfour.progress;
        }
        
        headcountentLabel.text = str;
        [headView addSubview:headcountentLabel];
        
        return headView;
        
    }else if (section==1){
        // 常用地址
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 54)];
        headView.backgroundColor = [UIColor whiteColor];
        
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headView.width, 10)];
        topView.backgroundColor = RGB_Color(232, 232, 237);
        [headView addSubview:topView];
        
        UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 10, 65, headView.height-10)];
        headLabel.font = [UIFont boldSystemFontOfSize:14];
        headLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
        headLabel.textAlignment = NSTextAlignmentLeft;
        headLabel.text = @"常用地址";
        [headView addSubview:headLabel];
        
        UILabel *headcountentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headLabel.frame)+14, 10, headView.width-CGRectGetMaxX(headLabel.frame)-headLabel.width, headView.height-10)];
        headcountentLabel.font = [UIFont systemFontOfSize:14];
        headcountentLabel.textColor = [UIColor lightGrayColor];
        headcountentLabel.textAlignment = NSTextAlignmentLeft;
        headcountentLabel.text = self.rootClass.data.studentinfo.address;
        [headView addSubview:headcountentLabel];
        
        return headView;
        
    }else if (section==2){
        // 考试信息
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 54)];
        headView.backgroundColor = [UIColor whiteColor];
        
        UIView *delive = [[UIView alloc] initWithFrame:CGRectMake(0, 53.5, self.view.width, 0.5)];
        delive.backgroundColor = [UIColor lightGrayColor];
        delive.alpha = 0.3;
        [headView addSubview:delive];
        
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headView.width, 10)];
        topView.backgroundColor = RGB_Color(232, 232, 237);
        [headView addSubview:topView];
        
        UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 10, 65, headView.height-10)];
        headLabel.font = [UIFont boldSystemFontOfSize:14];
        headLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
        headLabel.textAlignment = NSTextAlignmentLeft;
        headLabel.text = @"考试信息";
        [headView addSubview:headLabel];
        
        return headView;
        
    }else if (section==3){
        // 教练评价
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 54)];
        headView.backgroundColor = [UIColor whiteColor];
        
        UIView *delive = [[UIView alloc] initWithFrame:CGRectMake(0, 53.5, self.view.width, 0.5)];
        delive.backgroundColor = [UIColor lightGrayColor];
        delive.alpha = 0.3;
        [headView addSubview:delive];
        
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headView.width, 10)];
        topView.backgroundColor = RGB_Color(232, 232, 237);
        [headView addSubview:topView];
        
        UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 10, 65, headView.height-10)];
        headLabel.font = [UIFont boldSystemFontOfSize:14];
        headLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
        headLabel.textAlignment = NSTextAlignmentLeft;
        headLabel.text = @"教练评价";
        [headView addSubview:headLabel];
        
        return headView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
        return 60;
    }else if (indexPath.section==2){
        return 44;
    }else if (indexPath.section==3){
        NSDictionary *dict = self.rootClass.data.coachcommentinfo[indexPath.row];
        return [YBStudentDetailsCommentListCell heightWithModel:dict];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
        
        YBStudentDetailsStudyProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YBStudentDetailsStudyProgressCell"];
        if (!cell) {
            cell = [[YBStudentDetailsStudyProgressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YBStudentDetailsStudyProgressCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSInteger guidingStr;
        NSInteger wanchengStr;
        NSInteger goumaiStr;
        NSInteger yixueStr;
        if (self.rootClass.data.studentinfo.subject.subjectid==1) {
            guidingStr = self.rootClass.data.studentinfo.subjectone.officialhours;
            wanchengStr = self.rootClass.data.studentinfo.subjectone.officialfinishhours;
            goumaiStr = self.rootClass.data.studentinfo.subjectone.totalcourse;
            yixueStr = self.rootClass.data.studentinfo.subjectone.finishcourse;
        }else if (self.rootClass.data.studentinfo.subject.subjectid==2){
            guidingStr = self.rootClass.data.studentinfo.subjecttwo.officialhours;
            wanchengStr = self.rootClass.data.studentinfo.subjecttwo.officialfinishhours;
            goumaiStr = self.rootClass.data.studentinfo.subjecttwo.totalcourse;
            yixueStr = self.rootClass.data.studentinfo.subjecttwo.finishcourse;
        }else if (self.rootClass.data.studentinfo.subject.subjectid==3){
            guidingStr = self.rootClass.data.studentinfo.subjectthree.officialhours;
            wanchengStr = self.rootClass.data.studentinfo.subjectthree.officialfinishhours;
            goumaiStr = self.rootClass.data.studentinfo.subjectthree.totalcourse;
            yixueStr = self.rootClass.data.studentinfo.subjectthree.finishcourse;
        }else if (self.rootClass.data.studentinfo.subject.subjectid==4){
            guidingStr = self.rootClass.data.studentinfo.subjectfour.officialhours;
            wanchengStr = self.rootClass.data.studentinfo.subjectfour.officialfinishhours;
            goumaiStr = self.rootClass.data.studentinfo.subjectfour.totalcourse;
            yixueStr = self.rootClass.data.studentinfo.subjectfour.finishcourse;
        }
        
        cell.topLabel.text = [NSString stringWithFormat:@"规定:%ld学时   完成:%ld学时",(long)guidingStr,(long)wanchengStr];
        
        cell.bottomLabel.text = [NSString stringWithFormat:@"购买:%ld课时   已学:%ld课时",(long)goumaiStr,(long)yixueStr];
        
        return cell;
        
    }else if (indexPath.section==2){
        
        YBStudentDetailsExamMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YBStudentDetailsExamMessageCell"];
        if (!cell) {
            cell = [[YBStudentDetailsExamMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YBStudentDetailsExamMessageCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        if (indexPath.row==0) {
            
            cell.leftLabel.text = [NSString stringWithFormat:@"科目一  %@",[NSString getYearLocalDateFormateUTCDate:self.rootClass.data.studentinfo.examinationinfo.subjectone.examinationdate]];
            if (self.rootClass.data.studentinfo.examinationinfo.subjectone.examinationdate==nil) {
                cell.leftLabel.text = @"科目一";
            }
            
            cell.midLabel.text = [NSString stringWithFormat:@"%ld分",(long)self.rootClass.data.studentinfo.examinationinfo.subjectone.score];
            
            cell.rightLabel.text = [NSString stringWithFormat:@"%@",self.rootClass.data.studentinfo.examinationinfo.subjectone.examinationresultdesc];
            
        }else if (indexPath.row==1){
            
            cell.leftLabel.text = [NSString stringWithFormat:@"科目二  %@",[NSString getYearLocalDateFormateUTCDate:self.rootClass.data.studentinfo.examinationinfo.subjecttwo.examinationdate]];
            if (self.rootClass.data.studentinfo.examinationinfo.subjecttwo.examinationdate==nil) {
                cell.leftLabel.text = @"科目二";
            }
            
            cell.midLabel.text = [NSString stringWithFormat:@"%ld分",(long)self.rootClass.data.studentinfo.examinationinfo.subjecttwo.score];
            
            cell.rightLabel.text = [NSString stringWithFormat:@"%@",self.rootClass.data.studentinfo.examinationinfo.subjecttwo.examinationresultdesc];
            
        }else if (indexPath.row==2){
            
            cell.leftLabel.text = [NSString stringWithFormat:@"科目三  %@",[NSString getYearLocalDateFormateUTCDate:self.rootClass.data.studentinfo.examinationinfo.subjectthree.examinationdate]];
            if (self.rootClass.data.studentinfo.examinationinfo.subjectthree.examinationdate==nil) {
                cell.leftLabel.text = @"科目三";
            }
            
            cell.midLabel.text = [NSString stringWithFormat:@"%ld分",(long)self.rootClass.data.studentinfo.examinationinfo.subjectthree.score];
            
            cell.rightLabel.text = [NSString stringWithFormat:@"%@",self.rootClass.data.studentinfo.examinationinfo.subjectthree.examinationresultdesc];
            
        }else if (indexPath.row==3){
            
            cell.leftLabel.text = [NSString stringWithFormat:@"科目四  %@",[NSString getYearLocalDateFormateUTCDate:self.rootClass.data.studentinfo.examinationinfo.subjectfour.examinationdate]];
            if (self.rootClass.data.studentinfo.examinationinfo.subjectfour.examinationdate==nil) {
                cell.leftLabel.text = @"科目四";
            }
            
            cell.midLabel.text = [NSString stringWithFormat:@"%ld分",(long)self.rootClass.data.studentinfo.examinationinfo.subjectfour.score];
            
            cell.rightLabel.text = [NSString stringWithFormat:@"%@",self.rootClass.data.studentinfo.examinationinfo.subjectfour.examinationresultdesc];
            
        }
        
        return cell;
        
    }else if (indexPath.section==3){
        
        YBStudentDetailsCommentListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YBStudentDetailsCommentListCell"];
        if (cell==nil) {
            cell = [[YBStudentDetailsCommentListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YBStudentDetailsCommentListCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSDictionary *dict = self.rootClass.data.coachcommentinfo[indexPath.row];
        
        cell.dataDict = dict;
        
        return cell;
        
    }
    
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    NSLog(@"offsetY: %f",  offsetY);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
