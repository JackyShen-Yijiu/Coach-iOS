//
//  YBStudentHomeController.m
//  HeiMao_B
//
//  Created by JiangangYang on 16/3/25.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "YBStudentHomeController.h"
#import "JZHomeStudentToolBarView.h"

#import "JZHomeStudentSubjectOneView.h"
#import "JZHomeStudentSubjectTwoView.h"
#import "JZHomeStudentSubjectThreeView.h"
#import "JZHomeStudentSubjectFourView.h"

#define YBRatio 1.15
#define ScreenWidthIs_6Plus_OrWider [UIScreen mainScreen].bounds.size.width >= 414

#define ktopWith 112

#define kbottmWith 44

@interface YBStudentHomeController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UISegmentedControl *segment;

@property (nonatomic, strong) JZHomeStudentToolBarView *toolBarView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) JZHomeStudentSubjectOneView *subjectOneView; // 科目一

@property (nonatomic, strong) JZHomeStudentSubjectTwoView *subjectTwoView; // 科目二

@property (nonatomic, strong) JZHomeStudentSubjectThreeView *subjectThreeView; // 科目三

@property (nonatomic, strong) JZHomeStudentSubjectFourView *subjectFourView; // 科目四

@end

@implementation YBStudentHomeController
- (void)viewWillAppear:(BOOL)animated{
    [self initUI];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
    [self setNavBar];
    self.myNavigationItem.title = @"学员";
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.subjectOneView];
    [self.scrollView addSubview:self.subjectTwoView];
    [self.scrollView addSubview:self.subjectThreeView];
    [self.scrollView addSubview:self.subjectFourView];
    
    

}
- (void)initUI{
    [self.bgView addSubview:self.segment];
    [self.bgView addSubview:self.toolBarView];
    [self.view addSubview:self.bgView];
    
}
- (void)setNavBar{
    self.myNavigationItem.title = nil;
    self.myNavigationItem.titleView = nil;
    self.myNavigationItem.rightBarButtonItem = nil;
    self.myNavigationItem.rightBarButtonItems = nil;
    self.myNavigationItem.leftBarButtonItem = nil;
    self.myNavigationItem.leftBarButtonItems = nil;

}
- (void)didClicksegmentedControlAction:(UISegmentedControl *)Seg {
}
#pragma mark 筛选条件
- (void)dvvToolBarViewItemSelectedAction:(NSInteger)index {
    NSInteger orderType;
    if (0 == index) {
        orderType = 2;
    }else if (1 == index) {
        orderType = 3;
    }else if (2 == index) {
        orderType = 0;
    }
//    _schoolViewModel.orderType = orderType;
//    _coachViewModel.orderType = orderType;
//    [self cancelSearch];
//    [self beginRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, ktopWith)];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
- (UISegmentedControl *)segment {
    if (!_segment) {
        _segment = [[UISegmentedControl alloc] initWithItems:@[ @"科目一", @"科目二",@"科目三", @"科目四"]];
        CGFloat segmentX  = 50;
        CGFloat segmentW = self.view.width - segmentX * 2;
        CGFloat segmentH = 36;
        _segment.frame = CGRectMake(segmentX, 10, segmentW, segmentH);
        _segment.tintColor = JZ_MAIN_COLOR;
        [_segment addTarget:self action:@selector(didClicksegmentedControlAction:) forControlEvents:UIControlEventValueChanged];
        _segment.selectedSegmentIndex = 0;
    }
    return _segment;
}
- (JZHomeStudentToolBarView *)toolBarView {
    if (!_toolBarView) {
        _toolBarView = [JZHomeStudentToolBarView new];
        _toolBarView.frame = CGRectMake(0, CGRectGetMaxY(self.segment.frame) + 14, self.view.width, 52);
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
    }
    return _toolBarView;
}
- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, ktopWith + 64,self.view.width, self.view.height - ktopWith )];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(4 * self.view.width, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.backgroundColor = [UIColor cyanColor];
    }
    return _scrollView;
}
- (JZHomeStudentSubjectOneView *)subjectOneView{
    if (_subjectOneView == nil) {
        _subjectOneView = [[JZHomeStudentSubjectOneView alloc] initWithFrame:CGRectMake(0,0,self.view.width, self.scrollView.frame.size.height)];
    }
    return _subjectOneView;
}
- (JZHomeStudentSubjectTwoView *)subjectTwoView{
    if (_subjectTwoView == nil) {
        CGFloat systemW = self.view.width;
        _subjectTwoView = [[JZHomeStudentSubjectTwoView alloc] initWithFrame:CGRectMake(systemW,0,self.view.width, self.scrollView.frame.size.height)];
    }
    return _subjectTwoView;
}

- (JZHomeStudentSubjectThreeView *)subjectThreeView{
    if (_subjectThreeView == nil) {
        CGFloat systemW = self.view.width;
        _subjectThreeView = [[JZHomeStudentSubjectThreeView alloc] initWithFrame:CGRectMake(systemW * 2,0,self.view.width, self.scrollView.frame.size.height)];
    }
    return _subjectThreeView;
}

- (JZHomeStudentSubjectFourView *)subjectFourView{
    if (_subjectFourView == nil) {
        CGFloat systemW = self.view.width;
        _subjectFourView = [[JZHomeStudentSubjectFourView alloc] initWithFrame:CGRectMake(systemW * 3,0,self.view.width, self.scrollView.frame.size.height)];
    }
    return _subjectFourView;
}

@end
