//
//  YBStudentHomeController.m
//  HeiMao_B
//
//  Created by JiangangYang on 16/3/25.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "YBStudentHomeController.h"
#import "JZHomeStudentToolBarView.h"

#import "JZHomeStudentAllListView.h"
#import "JZHomeStudentNoExameListView.h"
#import "JZHomeStudentAppointView.h"
#import "JZHomeStudentRetestView.h"
#import "JZHomeStudentPassView.h"


#import "JZHomeStudentViewModel.h"
#import "RefreshTableView.h"
#import "JZHomeStudentListCell.h"
#import "MJRefreshFooter.h"
#import "MJRefreshHeader.h"
#import "MJRefresh.h"
#import "JZResultModel.h"
#import <YYModel.h>
#import "BLPFAlertView.h"
#import "JZCompletionConfirmationContriller.h"
#import "YBStudentDetailsViewController.h"
#import "ChatViewController.h"
#import "JZNoDataShowBGView.h"

#define YBRatio 1.15
#define ScreenWidthIs_6Plus_OrWider [UIScreen mainScreen].bounds.size.width >= 414

#define ktopHight 112

#define ktopSmallHight 65

#define kbottmWith 44

#define ksegmentH 36

@interface YBStudentHomeController ()<UIScrollViewDelegate>

@property (nonatomic, strong) JZHomeStudentAllListView *allListView;
@property (nonatomic, strong) JZHomeStudentAllListView *noExameListView;
@property (nonatomic, strong) JZHomeStudentAllListView *retestListView;
@property (nonatomic, strong) JZHomeStudentAllListView *appointListView;
@property (nonatomic, strong) JZHomeStudentAllListView *passListView;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UISegmentedControl *segment;

@property (nonatomic, strong) JZHomeStudentToolBarView *toolBarView;

@property (nonatomic, assign) BOOL isshowSegment; // 是否显示segment控件,当授课科目只有一个时,不显示

@property (nonatomic, assign) CGFloat bgH;

@property (nonatomic, strong) NSString *oneStr;

@property (nonatomic, strong) NSString *twoStr;

@property (nonatomic, strong) NSString *threeStr;

@property (nonatomic, strong) NSString *fourStr;

@property (nonatomic, strong) JZHomeStudentViewModel *studentViewModel;

@property (nonatomic, strong) NSMutableArray *resultDataArray;


@property (nonatomic, strong) NSArray *subjectIDArray;   // 根据教练授课科目 排序好的subjectID

@property (nonatomic, strong) JZNoDataShowBGView *noDataShowBGView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) NSInteger subjectID;
@end

@implementation YBStudentHomeController
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.myNavigationItem.rightBarButtonItem = nil;
    self.myNavigationItem.leftBarButtonItem = nil;
    self.myNavigationItem.title = nil;
    self.myNavigationItem.titleView = nil;
    
    // 设置里面可以更改授课科目 所以在这里要动态的改变segment 和 toolBarView 的位置坐标
    [self changeBgViewFrame];

    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   
    
}
- (void)viewWillDisappear:(BOOL)animated{
    _noDataShowBGView.hidden = YES;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    _isshowSegment = YES;
    _resultDataArray = [NSMutableArray array];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
    [self setNavBar];
    [self.view addSubview:self.noDataShowBGView];
//    [self.tableView.header beginRefreshing];
    [self.view addSubview:self.scrollView];
    
    
}
- (void)changeBgViewFrame{
    _isshowSegment = YES;
    self.myNavigationItem.title = @"学员";
    NSArray *sujectArray = [UserInfoModel defaultUserInfo].subject;
    if (sujectArray.count == 1) {
        _isshowSegment = NO;
        NSDictionary *dic = sujectArray.firstObject;
        self.myNavigationItem.title = dic[@"name"];
        self.allListView.subjectID = [dic[@"subjectid"] integerValue];
        
    }
    _isshowSegment ? (_bgH = ktopHight) : (_bgH = ktopSmallHight);
    [self initUI];
}

- (void)initUI{
    
    [_bgView removeFromSuperview];
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, _bgH)];
    _bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    _bgView.layer.shadowOffset = CGSizeMake(0, 2);
    _bgView.layer.shadowOpacity = 0.072;
    _bgView.layer.shadowRadius = 2;
    _bgView.backgroundColor = [UIColor whiteColor];
    if (_isshowSegment) {
        
        // 显示segmnet
        NSArray *subject =  [UserInfoModel defaultUserInfo].subject;
        NSMutableArray *titleArray = [NSMutableArray array];
        
        for (NSDictionary *dic in subject) {
            [titleArray addObject:dic[@"subjectid"]];
        }
        
        // 冒泡排序后将_id转化为相应的科目文字
        _subjectIDArray = [self bubbleSort:titleArray];
       _subjectID = [[_subjectIDArray firstObject] integerValue];
        self.allListView.studentState = 0;
        NSMutableArray *resultMustArray = [NSMutableArray array];
        NSString *str = nil;
        for (NSNumber *_id in _subjectIDArray) {
            
            if ( [_id isEqualToNumber:@1]) {
                str = @"科目一";
                _oneStr = str;
                [resultMustArray addObject:str];
            }
            if ( [_id isEqualToNumber:@2]) {
                str = @"科目二";
                _twoStr = str;
                [resultMustArray addObject:str];
            }
            if ( [_id isEqualToNumber:@3]) {
                str = @"科目三";
                _threeStr = str;
                [resultMustArray addObject:str];
            }
            if ( [_id isEqualToNumber:@4]) {
                str = @"科目四";
                _fourStr = str;
                [resultMustArray addObject:str];
            }
        }
        _segment = [[UISegmentedControl alloc] initWithItems:resultMustArray];
        // segmnetW 根据 教练所授课科目自由伸缩;
        CGFloat segmentX  = 50;
        CGFloat segmentW = (self.view.width - segmentX * 2) * resultMustArray.count / 3;
        CGFloat segmentH = ksegmentH;
        _segment.frame = CGRectMake(0, 10, segmentW, segmentH);
        _segment.centerX = self.view.centerX;
        _segment.tintColor = JZ_MAIN_COLOR;
        [_segment addTarget:self action:@selector(didClicksegmentedControlAction:) forControlEvents:UIControlEventValueChanged];
        _segment.selectedSegmentIndex = 0;
        
        // 添加segment 控件
        [_bgView addSubview:_segment];
        
    }
    // 不显示时不添加 segment 控件
    [self.bgView addSubview:self.toolBarView];
    [self.view addSubview:self.bgView];
    if (!_isshowSegment) {
        _scrollView.frame = CGRectMake(0, _bgH + 64, self.view.width, self.view.height - _bgH - 45);
    }else{
        _scrollView.frame = CGRectMake(0, ktopHight + 64, self.view.width, self.view.height - ktopHight - 64);
    }
    [self.scrollView addSubview:self.allListView];
    self.allListView.subjectID = _subjectID;
    self.allListView.studentState = 0;
    [self.allListView.tableView.refreshHeader  beginRefreshing];
    
    
    
    
}
- (void)setNavBar{
    self.myNavigationItem.title = nil;
    self.myNavigationItem.titleView = nil;
    self.myNavigationItem.rightBarButtonItem = nil;
    self.myNavigationItem.rightBarButtonItems = nil;
    self.myNavigationItem.leftBarButtonItem = nil;
    self.myNavigationItem.leftBarButtonItems = nil;

}

#pragma mark ---- segment的点击事件
- (void)didClicksegmentedControlAction:(UISegmentedControl *)Seg {

    NSInteger index = Seg.selectedSegmentIndex;
    // 默认始终显示全部学员
     self.allListView.subjectID = [_subjectIDArray[index] integerValue];
    // 当切换学员状态时因为重新创建UItable,所以重新给subjectID赋值
    self.subjectID = [_subjectIDArray[index] integerValue];
    
    [_toolBarView selectItem:0];
    _noDataShowBGView.hidden = YES;
    [self.allListView.tableView.refreshHeader  beginRefreshing];
    
}
#pragma mark 筛选条件
- (void)dvvToolBarViewItemSelectedAction:(NSInteger)index {
    /*
     
     学员状态：0 全部学员 1在学学员 2未考学员 3约考学员 4补考学员 5通过学员
     */
    if (0 == index) {
        CGFloat contentOffsetX = 0;
        [UIView animateWithDuration:0.5 animations:^{
            _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
        }];

        self.allListView.studentState = index;
        self.allListView.subjectID = self.subjectID;
        [self.scrollView addSubview:self.allListView];
        [self.allListView.tableView.refreshHeader  beginRefreshing];
        
    }else if (1 == index) {
        CGFloat contentOffsetX = self.view.width;
        [UIView animateWithDuration:0.5 animations:^{
            _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
        }];
         [self.scrollView addSubview:self.noExameListView];

        self.noExameListView.studentState = index + 1;
         self.noExameListView.subjectID = self.subjectID;
        
        [self.noExameListView.tableView.refreshHeader  beginRefreshing];
       
    }else if (2 == index) {
        CGFloat contentOffsetX = 2 * self.view.width;
        [UIView animateWithDuration:0.5 animations:^{
            _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
        }];
        self.appointListView.subjectID = self.subjectID;
        self.appointListView.studentState = index + 1;
         [self.scrollView addSubview:self.appointListView];
        [self.appointListView.tableView.refreshHeader  beginRefreshing];
        
    }
    else if (3 == index) {
        CGFloat contentOffsetX = 3 * self.view.width;
        [UIView animateWithDuration:0.5 animations:^{
            _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
        }];
        self.retestListView.subjectID = self.subjectID;
        self.retestListView.studentState = index + 1;
         [self.scrollView addSubview:self.retestListView];
        [self.retestListView.tableView.refreshHeader  beginRefreshing];
        
    }else if (4 == index) {
        CGFloat contentOffsetX = 4 * self.view.width;
        [UIView animateWithDuration:0.5 animations:^{
            _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
        }];
        self.passListView.subjectID = self.subjectID;
        self.passListView.studentState = index + 1;
         [self.scrollView addSubview:self.passListView];
        [self.passListView.tableView.refreshHeader  beginRefreshing];
        
    }
    _noDataShowBGView.hidden = YES;
   
}
#pragma mark --- UIScroller delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat width = self.view.width;
    
    if (0 == scrollView.contentOffset.x) {
       // 全部
         [_toolBarView selectItem:0];
    }
    if (width == scrollView.contentOffset.x) {
        // 未考
        [_toolBarView selectItem:1];

        
        
    }
    if (2 * width== scrollView.contentOffset.x) {
        // 约考
        [_toolBarView selectItem:2];

    }
    if (3 * width == scrollView.contentOffset.x) {
        // 补考
        [_toolBarView selectItem:3];

        
        
    }
    if (4 * width == scrollView.contentOffset.x) {
        // 通过
        [_toolBarView selectItem:4];
        
        
    }



}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (NSArray *)bubbleSort:(NSArray *)arg{//冒泡排序算法
    
    NSMutableArray *args = [NSMutableArray arrayWithArray:arg];
    
    for(int i=0;i<args.count-1;i++){
        
        for(int j=i+1;j<args.count;j++){
            
            if (args[i]>args[j]){
                
                int temp = [args[i] intValue];
                
                [args replaceObjectAtIndex:i withObject:args[j]];
                
                args[j] = @(temp);
                
            }
        }
    }
    return args;
}
- (JZHomeStudentToolBarView *)toolBarView {
    
    // 这里没有用懒加载, 因为当设置里面的科目相应更改后, 这样要动态的调整
    [_toolBarView removeFromSuperview];
        _toolBarView = [JZHomeStudentToolBarView new];
    if (!_isshowSegment) {
         _toolBarView.frame = CGRectMake(0, 14, self.view.width, 52);
    }
    if (_isshowSegment) {
        _toolBarView.frame = CGRectMake(0, CGRectGetMaxY(self.segment.frame) + 14, self.view.width, 52);
    }
        _toolBarView.titleNormalColor = JZ_FONTCOLOR_LIGHT;
        _toolBarView.titleSelectColor = JZ_MAIN_COLOR;
        _toolBarView.followBarColor = JZ_MAIN_COLOR;
        
        _toolBarView.layer.shadowColor = [UIColor blackColor].CGColor;
        _toolBarView.layer.shadowOffset = CGSizeMake(0, 2);
        _toolBarView.layer.shadowOpacity = 0.036;
        _toolBarView.layer.shadowRadius = 2;
        _toolBarView.titleFont = [UIFont systemFontOfSize:12];
        _toolBarView.titleArray = @[ @"全部", @"未考",@"约考", @"补考",@"通过" ];
        _toolBarView.imgNormalArray = @[@"student_all_off",@"student_study_off",@"student_exam_off",@"student_examed_off",@"student_pass_off"];
    _toolBarView.imgSelectArray = @[@"student_all_on",@"student_study_on",@"student_exam_on",@"student_examed_on",@"student_pass_on"];
    
        __weak typeof(self) ws = self;
        [_toolBarView dvvToolBarViewItemSelected:^(UIButton *button) {
            [ws dvvToolBarViewItemSelectedAction:button.tag];
        }];
        
        if (ScreenWidthIs_6Plus_OrWider) {
            _toolBarView.titleFont = [UIFont systemFontOfSize:14*YBRatio];
        }
    return _toolBarView;
}
// 全部学员
- (JZHomeStudentAllListView *)allListView{
    if (_allListView == nil) {
        _allListView = [[JZHomeStudentAllListView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 45 - ktopHight - 64)];
        _allListView.backgroundColor = [UIColor clearColor];
        
    }
    return _allListView;
}
// 未考学员
- (JZHomeStudentAllListView *)noExameListView{
    if (_noExameListView == nil) {
        _noExameListView = [[JZHomeStudentAllListView alloc] initWithFrame:CGRectMake(self.view.width, 0, self.view.width, self.view.height - 45 - ktopHight - 64)];
        _noExameListView.backgroundColor = [UIColor clearColor];

    }
    return _noExameListView;
}

// 约考学员
- (JZHomeStudentAllListView *)appointListView{
    if (_appointListView == nil) {
        _appointListView = [[JZHomeStudentAllListView alloc] initWithFrame:CGRectMake(2 * self.view.width, 0, self.view.width, self.view.height - 45 - ktopHight - 64) ];
        _appointListView.backgroundColor = [UIColor clearColor];
    }
    return _appointListView;
}
// 补考学员
- (JZHomeStudentAllListView *)retestListView{
    if (_retestListView == nil) {
        _retestListView = [[JZHomeStudentAllListView alloc] initWithFrame:CGRectMake(3 * self.view.width, 0, self.view.width, self.view.height - 45 - ktopHight - 64) ];
        _retestListView.backgroundColor = [UIColor clearColor];
    
    }
    return _retestListView;
}


// 通过学员
- (JZHomeStudentAllListView *)passListView{
    if (_passListView == nil) {
        _passListView = [[JZHomeStudentAllListView alloc] initWithFrame:CGRectMake(4 * self.view.width, 0, self.view.width, self.view.height - 45 - ktopHight - 64)];
        _passListView.backgroundColor = [UIColor clearColor];
        
    }
    return _passListView;
}


- (JZNoDataShowBGView *)noDataShowBGView{
    if (_noDataShowBGView == nil) {
        _noDataShowBGView = [[JZNoDataShowBGView alloc] initWithFrame:CGRectMake(0, ktopHight, self.view.width, self.view.height - ktopHight)];
        _noDataShowBGView.imgStr = @"people_null";
        _noDataShowBGView.titleStr = @"暂无数据";
        _noDataShowBGView.titleColor  = JZ_FONTCOLOR_DRAK;
        _noDataShowBGView.fontSize = 14.f;
        _noDataShowBGView.hidden = YES;
    }
    return _noDataShowBGView;
}
- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, ktopHight + 64, self.view.width, self.view.height - 45 - ktopHight - 64)];
        _scrollView.contentSize = CGSizeMake(5 * self.view.width, 0);
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.userInteractionEnabled = YES;
        _scrollView.delegate = self;
    }
    return _scrollView;
}
@end
