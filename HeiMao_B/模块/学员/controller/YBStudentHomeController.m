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
#import "JZHomeStudentViewModel.h"
//#import <MJRefresh/MJRefresh.h>

#define YBRatio 1.15
#define ScreenWidthIs_6Plus_OrWider [UIScreen mainScreen].bounds.size.width >= 414

#define ktopWith 112

#define ktopSmallWith 65

#define kbottmWith 44

#define ksegmentH 36

@interface YBStudentHomeController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UISegmentedControl *segment;

@property (nonatomic, strong) JZHomeStudentToolBarView *toolBarView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) JZHomeStudentSubjectOneView *subjectOneView; // 科目一

@property (nonatomic, strong) JZHomeStudentSubjectTwoView *subjectTwoView; // 科目二

@property (nonatomic, strong) JZHomeStudentSubjectThreeView *subjectThreeView; // 科目三

@property (nonatomic, strong) JZHomeStudentSubjectFourView *subjectFourView; // 科目四

@property (nonatomic, assign) BOOL isshowSegment; // 是否显示segment控件,当授课科目只有一个时,不显示

@property (nonatomic, assign) CGFloat bgH;


@property (nonatomic, strong) NSString *oneStr;

@property (nonatomic, strong) NSString *twoStr;

@property (nonatomic, strong) NSString *threeStr;

@property (nonatomic, strong) NSString *fourStr;

@property (nonatomic, strong) JZHomeStudentViewModel *studentViewModel;


@end

@implementation YBStudentHomeController
- (void)viewWillAppear:(BOOL)animated{
    // 设置里面可以更改授课科目 所以在这里要动态的改变segment 和 toolBarView 的位置坐标
    [self changeBgViewFrame];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _isshowSegment = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
    [self setNavBar];
    self.myNavigationItem.title = @"学员";
    [self.scrollView addSubview:self.subjectOneView];
    [self.scrollView addSubview:self.subjectTwoView];
    [self.scrollView addSubview:self.subjectThreeView];
    [self.scrollView addSubview:self.subjectFourView];
    [self.view addSubview:self.scrollView];
    
    

}
- (void)initUI{
    
    [_bgView removeFromSuperview];
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, _bgH)];
    _bgView.backgroundColor = [UIColor whiteColor];
    if (_isshowSegment) {
        
        // 显示segmnet
        NSArray *subject =  [UserInfoModel defaultUserInfo].subject;
        NSMutableArray *titleArray = [NSMutableArray array];
        
        for (NSDictionary *dic in subject) {
            [titleArray addObject:dic[@"subjectid"]];
        }
        
        // 冒泡排序后将_id转化为相应的科目文字
        NSArray *resultArray = [self bubbleSort:titleArray];
        NSMutableArray *resultMustArray = [NSMutableArray array];
        NSString *str = nil;
        for (NSNumber *_id in resultArray) {
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
        [_bgView addSubview:_segment];
        
    }
    [self.bgView addSubview:self.toolBarView];
    [self.view addSubview:self.bgView];
    
    // 动态调整UIScroller的frame
    if (!_isshowSegment) {
        
        // 有授课一个科目
        NSLog(@"x = %f,y = %f, w= %f,h = %f",self.view.frame.origin.x,self.view.frame.origin.x,self.view.frame.size.width,self.view.frame.size.height);
        _scrollView.frame = CGRectMake(0, ktopSmallWith, self.view.width, self.view.height - 49);
        _scrollView.contentSize = CGSizeMake(self.view.width, 0);
        _subjectOneView.frame = CGRectMake(0,0,self.view.width, _scrollView.height );
        
    }
    if (_isshowSegment) {
        
        // 授课多个科目
        NSArray *array = [UserInfoModel defaultUserInfo].subject;
        CGFloat systemW = self.view.width;
        
        _scrollView.frame = CGRectMake(0, ktopWith,self.view.width, self.view.height - ktopWith);
        _scrollView.contentSize = CGSizeMake(array.count * self.view.width, 0);
        
        if (4 == array.count) {
            // 授课四个科目
            _subjectOneView.frame = CGRectMake(0,0,self.view.width, self.view.height - ktopWith );
            _subjectTwoView.frame = CGRectMake(systemW,0,self.view.width, self.view.height - ktopWith );
            _subjectThreeView.frame = CGRectMake(2 * systemW,0,self.view.width, self.view.height - ktopWith );
            _subjectFourView.frame = CGRectMake(3 * systemW,0,self.view.width, self.view.height - ktopWith );

        }
        if (3 == array.count) {
            // 授课三个科目
            _subjectOneView.frame = CGRectMake(0,0,self.view.width, self.view.height - ktopWith );
            _subjectTwoView.frame = CGRectMake(systemW,0,self.view.width, self.view.height - ktopWith );
            _subjectThreeView.frame = CGRectMake(2 * systemW,0,self.view.width, self.view.height - ktopWith );
        }
        if (2 == array.count) {
            // 授课二个科目
            _subjectOneView.frame = CGRectMake(0,0,self.view.width, self.view.height - ktopWith );
            _subjectTwoView.frame = CGRectMake(systemW,0,self.view.width, self.view.height - ktopWith );
            
        }

    
    }
    
}
- (void)setNavBar{
    self.myNavigationItem.title = nil;
    self.myNavigationItem.titleView = nil;
    self.myNavigationItem.rightBarButtonItem = nil;
    self.myNavigationItem.rightBarButtonItems = nil;
    self.myNavigationItem.leftBarButtonItem = nil;
    self.myNavigationItem.leftBarButtonItems = nil;

}
- (void)changeBgViewFrame{
    _isshowSegment = YES;
    self.myNavigationItem.title = @"学员";
    NSArray *sujectArray = [UserInfoModel defaultUserInfo].subject;
    if (sujectArray.count == 1) {
        _isshowSegment = NO;
        NSDictionary *dic = sujectArray.firstObject;
        self.myNavigationItem.title = dic[@"name"];

            }
    _isshowSegment ? (_bgH = ktopWith) : (_bgH = ktopSmallWith);
    [self initUI];
}



#pragma mark - config view model
- (void)configSchoolViewModel {
    
    __weak typeof(self) ws = self;
    _studentViewModel = [JZHomeStudentViewModel new];
    
    [_studentViewModel dvv_setRefreshSuccessBlock:^{
        [ws.subjectOneView.tableView reloadData];
    }];
    [_studentViewModel dvv_setLoadMoreSuccessBlock:^{
        
        [ws.subjectOneView.tableView reloadData];
    }];
    [_studentViewModel dvv_setNilResponseObjectBlock:^{
        if (ws.studentViewModel.dataArray.count) {
            
//            [ws obj_showTotasViewWithMes:@"已经全部加载完毕"];
//            ws.subjectOneView.tableView.mj_footer.state = MJRefreshStateNoMoreData;
        }else {
            //            if (!((NSMutableArray *)[ws dvv_unarchiveFromCacheWithFileName:ArchiverName_SchoolDataArray]).count) {
            //                ws.noDataPromptView.titleLabel.text = @"暂无合作驾校信息";
            //                ws.noDataPromptView.subTitleLabel.text = @"请切换合作城市";
            //                [ws.tableView addSubview:ws.noDataPromptView];
            //            }
        
        }
    }];
    [_studentViewModel dvv_setNetworkCallBackBlock:^{
//        [ws.subjectOneView.tableView.mj_header endRefreshing];
//        [ws.subjectOneView.tableView.mj_footer endRefreshing];
       
    }];
    [_studentViewModel dvv_setNetworkErrorBlock:^{
//        if (!((NSMutableArray *)[ws dvv_unarchiveFromCacheWithFileName:ArchiverName_SchoolDataArray]).count) {
//            ws.noDataPromptView.titleLabel.text = @"网络错误";
//            ws.noDataPromptView.subTitleLabel.text = @"";
//            [ws.tableView addSubview:ws.noDataPromptView];
//        }
//        [ws obj_showTotasViewWithMes:@"网络错误"];
    }];
}

- (void)didClicksegmentedControlAction:(UISegmentedControl *)Seg {
    NSInteger index = Seg.selectedSegmentIndex;
    if (0 == index) {
        // 科目一
        CGFloat contentOffsetX = 0;
        [UIView animateWithDuration:0.5 animations:^{
            _scrollView.contentOffset = CGPointMake(contentOffsetX, -64);
        }];

    }
    if (1 == index) {
        // 科目二
        CGFloat contentOffsetX = self.view.width;
        [UIView animateWithDuration:0.5 animations:^{
            _scrollView.contentOffset = CGPointMake(contentOffsetX, -64);
        }];

    }
    if (2 == index) {
        // 科目三
        CGFloat contentOffsetX = 2 * self.view.width;
        [UIView animateWithDuration:0.5 animations:^{
            _scrollView.contentOffset = CGPointMake(contentOffsetX, -64);
        }];

    }
    if (3 == index) {
        // 科目四
        CGFloat contentOffsetX = 3 * self.view.width;
        [UIView animateWithDuration:0.5 animations:^{
            _scrollView.contentOffset = CGPointMake(contentOffsetX, -64);
        }];

    }
    
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

#pragma mark -- UIScrollerView 的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat width = self.view.frame.size.width;
    if (0 == scrollView.contentOffset.x) {
        // 科目一
        _segment.selectedSegmentIndex = 0;
        
    }
    if (width == scrollView.contentOffset.x) {
        // 科目二
        _segment.selectedSegmentIndex = 1;
        [_toolBarView selectItem:0];
    
    }
    if (2 * width == scrollView.contentOffset.x) {
        // 科目三
         _segment.selectedSegmentIndex = 2;
        [_toolBarView selectItem:0];
    }
    if (3 * width == scrollView.contentOffset.x) {
        // 科目四
         _segment.selectedSegmentIndex = 3;
        [_toolBarView selectItem:0];
    }
    
}

//- (UIView *)bgView{
//    if (_bgView == nil) {
//       
//    }
//    return _bgView;
//}
//- (UISegmentedControl *)segment {
//    if (!_segment) {
//       
//    }
//    return _segment;
//}
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
- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, ktopWith,self.view.width, self.view.height - ktopWith - 64)];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(4 * self.view.width, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.backgroundColor = [UIColor cyanColor];
    }
    return _scrollView;
}
- (JZHomeStudentSubjectOneView *)subjectOneView{
    if (_subjectOneView == nil) {
        _subjectOneView = [[JZHomeStudentSubjectOneView alloc] initWithFrame:CGRectMake(0,0,self.view.width, self.view.height - ktopWith - 64 - 54 )];
    }
    return _subjectOneView;
}
- (JZHomeStudentSubjectTwoView *)subjectTwoView{
    if (_subjectTwoView == nil) {
        CGFloat systemW = self.view.width;
        _subjectTwoView = [[JZHomeStudentSubjectTwoView alloc] initWithFrame:CGRectMake(systemW,0,self.view.width, self.view.height - ktopWith - 64 - 54)];
    }
    return _subjectTwoView;
}

- (JZHomeStudentSubjectThreeView *)subjectThreeView{
    if (_subjectThreeView == nil) {
        CGFloat systemW = self.view.width;
        _subjectThreeView = [[JZHomeStudentSubjectThreeView alloc] initWithFrame:CGRectMake(systemW * 2,0,self.view.width, self.view.height - ktopWith - 64 - 54)];
    }
    return _subjectThreeView;
}

- (JZHomeStudentSubjectFourView *)subjectFourView{
    if (_subjectFourView == nil) {
        CGFloat systemW = self.view.width;
        _subjectFourView = [[JZHomeStudentSubjectFourView alloc] initWithFrame:CGRectMake(systemW * 3,0,self.view.width, self.view.height - ktopWith - 64 - 54)];

    }
    return _subjectFourView;
}

@end
