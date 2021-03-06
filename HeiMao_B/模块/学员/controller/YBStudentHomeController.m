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


#define yinyingH 2

@interface YBStudentHomeController ()<UIScrollViewDelegate,ShowNoDataBG>

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


@property (nonatomic, strong) JZNoDataShowBGView *allnoDataShowBGView;

@property (nonatomic, strong) JZNoDataShowBGView *noexamnoDataShowBGView;

@property (nonatomic, strong) JZNoDataShowBGView *appointnoDataShowBGView;

@property (nonatomic, strong) JZNoDataShowBGView *retestDataShowBGView;

@property (nonatomic, strong) JZNoDataShowBGView *passnoDataShowBGView;



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
//
//    // 设置里面可以更改授课科目 所以在这里要动态的改变segment 和 toolBarView 的位置坐标
    [self changeBgViewFrame];

    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [_allnoDataShowBGView removeFromSuperview];
    [_noexamnoDataShowBGView removeFromSuperview];
    [_appointnoDataShowBGView removeFromSuperview];
    [_retestDataShowBGView removeFromSuperview];
    [_passnoDataShowBGView removeFromSuperview];
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isshowSegment = YES;
    _resultDataArray = [NSMutableArray array];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
  
    [self setNavBar];
//    [self.view addSubview:self.noDataShowBGView];
  
//    [self.view addSubview:self.scrollView];
    
    
}
- (void)changeBgViewFrame{
    
    _isshowSegment = YES;
    self.myNavigationItem.title = @"学员";
    NSArray *sujectArray = [UserInfoModel defaultUserInfo].subject;
    
    if (sujectArray.count == 0) {
        [self showTotasViewWithMes:@"暂无设置授课科目"];
        return;
    }

    if (sujectArray.count == 1) {
        _isshowSegment = NO;
        NSDictionary *dic = sujectArray.firstObject;
        self.myNavigationItem.title = dic[@"name"];
        self.allListView.subjectID = [dic[@"subjectid"] integerValue];
        _subjectID = [dic[@"subjectid"] integerValue];
        self.allListView.studentState = 0;
        NSLog(@"%lu",[dic[@"subjectid"] integerValue]);
        
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
        NSLog(@"subject:%@",subject);
        
        for (NSDictionary *dic in subject) {
            [titleArray addObject:dic[@"subjectid"]];
        }
        
        // 冒泡排序后将_id转化为相应的科目文字
        NSLog(@"-----冒泡排序后将_id转化为相应的科目文字------titleArray:%@",titleArray);
        _subjectIDArray = [self bubbleSort:titleArray];
        NSLog(@"+++++冒泡排序后将_id转化为相应的科目文字++++++");
        NSLog(@"_subjectIDArray:%@",_subjectIDArray);

       _subjectID = [[_subjectIDArray firstObject] integerValue];
        NSLog(@"_subjectID:%ld",(long)_subjectID);

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
        _scrollView.frame = CGRectMake(0, CGRectGetMaxY(self.bgView.frame) + yinyingH , self.view.width, self.view.height - _bgH - 49);
    }else{
        _scrollView.frame = CGRectMake(0, CGRectGetMaxY(self.bgView.frame) + yinyingH, self.view.width, self.view.height - ktopHight -49);
    }
    [self.view addSubview:self.scrollView];
    
    [_scrollView addSubview:self.allListView];
    [_scrollView addSubview:self.noExameListView];
    [_scrollView addSubview:self.retestListView];
    [_scrollView addSubview:self.appointListView];
    [_scrollView addSubview:self.passListView];

    NSLog(@"--------_scrollView.contentOffset.y:%f",_scrollView.contentOffset.y);

    //[self.scrollView addSubview:self.allListView];
    self.allListView.subjectID = _subjectID;
    self.allListView.studentState = 0;
    self.allListView.parementVC = self;
    [self loadNetworkData];
    __weak typeof (self) ws = self;

    self.noExameListView.refreshHeader = nil;
    self.appointListView.refreshHeader = nil;
    self.allListView.refreshHeader = nil;
    self.retestListView.refreshHeader = nil;
    self.passListView.refreshHeader = nil;
    
    self.allListView.refreshFooter.beginRefreshingBlock = ^(){
        [ws moreLoadData];
    };
    self.noExameListView.refreshFooter.beginRefreshingBlock = ^(){
        [ws moreLoadData];
    };
    self.appointListView.refreshFooter.beginRefreshingBlock = ^(){
        [ws moreLoadData];
    };
    self.retestListView.refreshFooter.beginRefreshingBlock = ^(){
        [ws moreLoadData];
    }; self.passListView.refreshFooter.beginRefreshingBlock = ^(){
        [ws moreLoadData];
    };


    
}
- (void)setNavBar{
    self.myNavigationItem.title = nil;
    self.myNavigationItem.titleView = nil;
    self.myNavigationItem.rightBarButtonItem = nil;
    self.myNavigationItem.rightBarButtonItems = nil;
    self.myNavigationItem.leftBarButtonItem = nil;
    self.myNavigationItem.leftBarButtonItems = nil;

}
- (void)loadNetworkData {
    
    CGFloat offSetX = self.scrollView.contentOffset.x;
    CGFloat width = self.scrollView.width;
    
    if (offSetX >= 0 && offSetX < self.scrollView.width) {
        self.allListView.subjectID = self.subjectID;
        self.allListView.studentState = 0;
        [self.allListView networkRequest];
    }else if (offSetX >= width && offSetX < width * 2) {
        self.noExameListView.subjectID = self.subjectID;
        self.noExameListView.studentState = 2;
        [self.noExameListView networkRequest];

        

    }else if (offSetX >= width * 2 && offSetX < width * 3) {
        self.appointListView.subjectID = self.subjectID;
        self.appointListView.studentState = 3;
        [self.appointListView networkRequest];
        
    }else if (offSetX >= width * 3 && offSetX < width * 4) {
        self.retestListView.subjectID = self.subjectID;
        self.retestListView.studentState = 4;
        [self.retestListView networkRequest];
    }else if (offSetX >= width * 4) {
        self.passListView.subjectID = self.subjectID;
        self.passListView.studentState = 5;
        [self.passListView networkRequest];
    }
}
- (void)moreLoadData {
    
    CGFloat offSetX = self.scrollView.contentOffset.x;
    CGFloat width = self.scrollView.width;
    
    if (offSetX >= 0 && offSetX < self.scrollView.width) {
        self.allListView.subjectID = self.subjectID;
        self.allListView.studentState = 0;
        [self.allListView moreData];
    }else if (offSetX >= width && offSetX < width * 2) {
        self.noExameListView.subjectID = self.subjectID;
        self.noExameListView.studentState = 2;
        [self.noExameListView moreData];
        
        
        
    }else if (offSetX >= width * 2 && offSetX < width * 3) {
        self.appointListView.subjectID = self.subjectID;
        self.appointListView.studentState = 3;
        [self.appointListView moreData];
        
    }else if (offSetX >= width * 3 && offSetX < width * 4) {
        self.retestListView.subjectID = self.subjectID;
        self.retestListView.studentState = 4;
        [self.retestListView moreData];
    }else if (offSetX >= width * 4) {
        self.passListView.subjectID = self.subjectID;
        self.passListView.studentState = 5;
        [self.passListView moreData];
    }
}

#pragma mark ---- segment的点击事件
- (void)didClicksegmentedControlAction:(UISegmentedControl *)Seg {

    NSInteger index = Seg.selectedSegmentIndex;
    // 默认始终显示全部学员
     self.allListView.subjectID = [_subjectIDArray[index] integerValue];
    // 当切换学员状态时因为重新创建UItable,所以重新给subjectID赋值
    self.subjectID = [_subjectIDArray[index] integerValue];
    self.allListView.parementVC = self;
    [_toolBarView selectItem:0];
//    _noDataShowBGView.hidden = YES;
    [self loadNetworkData];
    
}
#pragma mark 筛选条件
- (void)dvvToolBarViewItemSelectedAction:(NSInteger)index {
    
    NSLog(@"11_scrollView.contentOffset.y:%f",_scrollView.contentOffset.y);
    
    /*
     
     学员状态：0 全部学员 1在学学员 2未考学员 3约考学员 4补考学员 5通过学员
     */
    if (0 == index) {
        
        CGFloat contentOffsetX = 0;
        _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);

        self.allListView.studentState = index;
        self.allListView.subjectID = self.subjectID;
        [self.allListView removeFromSuperview];

        self.allListView.frame = CGRectMake(0, 0, self.view.width, self.scrollView.height);
        [self.scrollView addSubview:self.allListView];
        self.allListView.parementVC = self;
       
    }else if (1 == index) {
        CGFloat contentOffsetX = self.view.width;
        _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
 NSLog(@"22_scrollView.contentOffset.y:%f",_scrollView.contentOffset.y);
        [self.noExameListView removeFromSuperview];
        self.noExameListView.frame = CGRectMake(self.view.width, 0, self.view.width, self.scrollView.height);
 NSLog(@"33_scrollView.contentOffset.y:%f",_scrollView.contentOffset.y);
         [self.scrollView addSubview:self.noExameListView];

        self.noExameListView.studentState = index + 1;
         self.noExameListView.subjectID = self.subjectID;
        self.noExameListView.parementVC = self;
         NSLog(@"44_scrollView.contentOffset.y:%f",_scrollView.contentOffset.y);
        
    }else if (2 == index) {
        CGFloat contentOffsetX = 2 * self.view.width;
        _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);

        self.appointListView.subjectID = self.subjectID;
        self.appointListView.studentState = index + 1;
        self.appointListView.parementVC = self;
        
        [self.noExameListView removeFromSuperview];

         [self.scrollView addSubview:self.appointListView];
        self.appointListView.frame = CGRectMake(self.view.width * 2, 0, self.view.width, self.scrollView.height);

        
    }
    else if (3 == index) {
        CGFloat contentOffsetX = 3 * self.view.width;
        _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);

        self.retestListView.subjectID = self.subjectID;
        self.retestListView.studentState = index + 1;
        
        [self.retestListView removeFromSuperview];
        [self.scrollView addSubview:self.retestListView];
        self.retestListView.frame = CGRectMake(self.view.width * 3, 0, self.view.width, self.scrollView.height);
        self.retestListView.parementVC = self;
        
    }else if (4 == index) {
        
        CGFloat contentOffsetX = 4 * self.view.width;
        _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);

        self.passListView.subjectID = self.subjectID;
        self.passListView.studentState = index + 1;
        
        [self.passListView removeFromSuperview];
        
         self.passListView.frame = CGRectMake(self.view.width * 4, 0, self.view.width, self.scrollView.height);
         [self.scrollView addSubview:self.passListView];
        self.passListView.parementVC = self;
       
        
    }
   
    NSLog(@"+++++++_scrollView.contentOffset.y:%f",_scrollView.contentOffset.y);

    [self loadNetworkData];
   
}
#pragma mark --- UIScroller delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat width = self.view.width;
    
    if (0 == scrollView.contentOffset.x) {
       // 全部
         [_toolBarView selectItem:0];
//         self.allListView.frame = CGRectMake(0, -64, self.view.width, self.scrollView.height);
    }
    if (width == scrollView.contentOffset.x) {
        // 未考
        [_toolBarView selectItem:1];
//self.noExameListView.frame = CGRectMake(self.view.width, -64, self.view.width, self.scrollView.height);
        
        
    }
    if (2 * width== scrollView.contentOffset.x) {
        // 约考
        [_toolBarView selectItem:2];
//        self.appointListView.frame = CGRectMake(self.view.width * 2, -64, self.view.width, self.scrollView.height);

    }
    if (3 * width == scrollView.contentOffset.x) {
        // 补考
        [_toolBarView selectItem:3];
//        self.retestListView.frame = CGRectMake(self.view.width * 3, -64, self.view.width, self.scrollView.height);

        
        
    }
    if (4 * width == scrollView.contentOffset.x) {
        // 通过
        [_toolBarView selectItem:4];
//        self.passListView.frame = CGRectMake(self.view.width * 4, -64, self.view.width, self.scrollView.height);
        
        
    }



}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSArray *)bubbleSort:(NSArray *)arg{//冒泡排序算法
    
    NSMutableArray *args = [NSMutableArray arrayWithArray:arg];
    NSLog(@"冒泡排序算法 args:%@",args);
    
    for(int i=0;i<args.count-1;i++){
        
        for(int j=i+1;j<args.count;j++){
            
            if ([args[i] integerValue]  > [args[j] integerValue]){
                
                int temp = [args[i] intValue];
                
                [args replaceObjectAtIndex:i withObject:args[j]];
                
                args[j] = @(temp);
                
            }
        }
    }
    
    NSLog(@"冒泡排序算法之后args:%@",args);
    
    return args;
    
}

#pragma mark --- 显示占位图片Delegate
- (void)initWithDataSearchType:(kDateSearchType)dataSearchType{
    
    
    [_allnoDataShowBGView removeFromSuperview];
    [_noexamnoDataShowBGView removeFromSuperview];
    [_appointnoDataShowBGView removeFromSuperview];
    [_retestDataShowBGView removeFromSuperview];
    [_passnoDataShowBGView removeFromSuperview];
    
    if (dataSearchType == kDateSearchTypeToday) {
        _appointnoDataShowBGView = [[JZNoDataShowBGView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.scrollView.height)];
        [self.scrollView addSubview:_allnoDataShowBGView];
        
        
        
        
    }

    if (dataSearchType == kDateSearchTypeYesterday) {
        _appointnoDataShowBGView = [[JZNoDataShowBGView alloc] initWithFrame:CGRectMake(self.view.width, 0, self.view.width, self.scrollView.height)];
        [self.scrollView addSubview:_noexamnoDataShowBGView];
    }

    if (dataSearchType == kDateSearchTypeWeek) {
       _appointnoDataShowBGView = [[JZNoDataShowBGView alloc] initWithFrame:CGRectMake(self.view.width * 2, 0, self.view.width, self.scrollView.height)];
        [self.scrollView addSubview:_appointnoDataShowBGView];
    }
    if (dataSearchType == kDateSearchTypeMonth) {
       _retestDataShowBGView = [[JZNoDataShowBGView alloc] initWithFrame:CGRectMake(self.view.width * 3, 0, self.view.width, self.scrollView.height)];
        [self.scrollView addSubview:_retestDataShowBGView];
    }
    if (dataSearchType == kDateSearchTypeYear) {
        _appointnoDataShowBGView = [[JZNoDataShowBGView alloc] initWithFrame:CGRectMake(self.view.width * 4, 0, self.view.width, self.scrollView.height)];
        [self.scrollView addSubview:_passnoDataShowBGView];
    }


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
//    _toolBarView.titleNormalColor = [UIColor redColor];
        _toolBarView.titleNormalColor = JZ_FONTCOLOR_LIGHT;
        _toolBarView.titleSelectColor = JZ_MAIN_COLOR;
        _toolBarView.followBarColor = JZ_MAIN_COLOR;
    
        _toolBarView.titleFont = [UIFont systemFontOfSize:12];
        _toolBarView.titleArray = @[ @"全部", @"未考",@"约考", @"补考",@"通过" ];
        _toolBarView.imgNormalArray = @[@"student_all_off",@"student_study_off",@"student_exam_off",@"student_examed_off",@"student_pass_off"];
    _toolBarView.imgSelectArray = @[@"student_all_on",@"student_study_on",@"student_exam_on",@"student_examed_on",@"student_pass_on"];
    
        __weak typeof(self) ws = self;
        [_toolBarView dvvToolBarViewItemSelected:^(UIButton *button) {
            NSLog(@"%f",self.scrollView.contentOffset.y);
            [ws dvvToolBarViewItemSelectedAction:button.tag];
        }];
    
        if (ScreenWidthIs_6Plus_OrWider) {
            _toolBarView.titleFont = [UIFont systemFontOfSize:14];
        }
    return _toolBarView;
}
// 全部学员
- (JZHomeStudentAllListView *)allListView{
    if (_allListView == nil) {
        _allListView = [[JZHomeStudentAllListView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.scrollView.height)];
        _allListView.backgroundColor = [UIColor clearColor];
        _allListView.searchType = kDateSearchTypeToday;
        _allListView.refreshHeader = nil;
        
    }
    return _allListView;
}
// 未考学员
- (JZHomeStudentAllListView *)noExameListView{
    if (_noExameListView == nil) {
        _noExameListView = [[JZHomeStudentAllListView alloc] initWithFrame:CGRectMake(self.view.width, 0, self.view.width, self.scrollView.height)];
        _noExameListView.backgroundColor = [UIColor clearColor];
        _noExameListView.searchType = kDateSearchTypeYesterday;
        _noExameListView.refreshHeader = nil;
    }
    return _noExameListView;
}

// 约考学员
- (JZHomeStudentAllListView *)appointListView{
    if (_appointListView == nil) {
        _appointListView = [[JZHomeStudentAllListView alloc] initWithFrame:CGRectMake(2 * self.view.width, 0, self.view.width, self.scrollView.height) ];
        _appointListView.backgroundColor = [UIColor clearColor];
        _appointListView.searchType = kDateSearchTypeWeek;
        _appointListView.showNodataDelegate = self;
        
    }
    return _appointListView;
}
// 补考学员
- (JZHomeStudentAllListView *)retestListView{
    if (_retestListView == nil) {
        _retestListView = [[JZHomeStudentAllListView alloc] initWithFrame:CGRectMake(3 * self.view.width, 0, self.view.width, self.scrollView.height) ];
        _retestListView.backgroundColor = [UIColor clearColor];
        _retestListView.searchType = kDateSearchTypeMonth;
        _retestListView.showNodataDelegate = self;
    }
    return _retestListView;
}


// 通过学员
- (JZHomeStudentAllListView *)passListView{
    if (_passListView == nil) {
        _passListView = [[JZHomeStudentAllListView alloc] initWithFrame:CGRectMake(4 * self.view.width, 0, self.view.width, self.scrollView.height)];
        _passListView.backgroundColor = [UIColor clearColor];
        _passListView.searchType = kDateSearchTypeYear;
        
    }
    return _passListView;
}
- (UIScrollView *)scrollView{
    
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bgView.frame) + yinyingH, self.view.width, self.view.height - _bgH - 49)];
        _scrollView.contentSize = CGSizeMake(5 * self.view.width, 0);
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.userInteractionEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
    }
    return _scrollView;
}
@end
