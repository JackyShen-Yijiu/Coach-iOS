//
//  YBStudentHomeController.m
//  HeiMao_B
//
//  Created by JiangangYang on 16/3/25.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "YBStudentHomeController.h"
#import "JZHomeStudentToolBarView.h"

#define YBRatio 1.15
#define ScreenWidthIs_6Plus_OrWider [UIScreen mainScreen].bounds.size.width >= 414

@interface YBStudentHomeController ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, strong) JZHomeStudentToolBarView *toolBarView;
@end

@implementation YBStudentHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
    [self setNavBar];
    self.myNavigationItem.title = @"学员";
    [self initUI];

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
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 112)];
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
        
        _toolBarView.frame = CGRectMake(0, CGRectGetMaxY(self.segment.frame) + 14, self.view.width, 48);
        _toolBarView.titleNormalColor = JZ_FONTCOLOR_LIGHT;
        _toolBarView.titleSelectColor = JZ_MAIN_COLOR;
        _toolBarView.followBarColor = JZ_MAIN_COLOR;
        
        _toolBarView.layer.shadowColor = [UIColor blackColor].CGColor;
        _toolBarView.layer.shadowOffset = CGSizeMake(0, 2);
        _toolBarView.layer.shadowOpacity = 0.036;
        _toolBarView.layer.shadowRadius = 2;
        _toolBarView.titleFont = [UIFont systemFontOfSize:12];
        _toolBarView.titleArray = @[ @"全部", @"未考",@"约考", @"补考",@"通过" ];
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

@end
