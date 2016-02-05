//
//  DVVStudentListController.m
//  HeiMao_B
//
//  Created by 大威 on 16/2/2.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "DVVStudentListController.h"
#import "DVVToolBarView.h"
#import "DVVTheoreticalStudentListView.h"
#import "DVVDrivingStudentListView.h"
#import "DVVLicensingStudentListView.h"

@interface DVVStudentListController ()<UIScrollViewDelegate>

@property (nonatomic, strong) DVVToolBarView *dvvToolBarView;
@property (nonatomic, strong) UIView *toolBarBottomLineView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) DVVTheoreticalStudentListView *theoreticalView;
@property (nonatomic, strong) DVVDrivingStudentListView *drivingView;
@property (nonatomic, strong) DVVLicensingStudentListView *licensingView;

@end

@implementation DVVStudentListController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"学员列表";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.dvvToolBarView];
    [self.view addSubview:self.toolBarBottomLineView];
    [self.view addSubview:self.scrollView];
    [_scrollView addSubview:self.theoreticalView];
    self.theoreticalView.parentViewController = self;
    
    [_scrollView addSubview:self.drivingView];
    self.drivingView.parentViewController = self;
    
    [_scrollView addSubview:self.licensingView];
    self.licensingView.parentViewController = self;
    
    [self configUI];
    
    // 请求数据
    [_theoreticalView beginNetworkRequest];
    [_drivingView beginNetworkRequest];
    [_licensingView beginNetworkRequest];
}

#pragma mark - action
- (void)toolBarItemSelectedAction:(UIButton *)sender {
    
    [self changeScrollViewOffSetX:sender.tag];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSUInteger tag = scrollView.contentOffset.x / CGRectGetWidth(_scrollView.frame);
    [self changeScrollViewOffSetX:tag];
    [_dvvToolBarView selectItem:tag];
}

#pragma mark - public
- (void)changeScrollViewOffSetX:(NSUInteger)tag {
    [UIView animateWithDuration:0.3 animations:^{
        _scrollView.contentOffset = CGPointMake(CGRectGetWidth(_scrollView.frame) * tag, 0);
    }];
}

#pragma mark - configUI
- (void)configUI {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat toolBarHeight = 40;
    
    _dvvToolBarView.frame = CGRectMake(0, 64, screenSize.width, toolBarHeight);
    _toolBarBottomLineView.frame = CGRectMake(0, 64 + toolBarHeight, screenSize.width, 1);
    
    _scrollView.frame = CGRectMake(0, 64 + toolBarHeight + 1, screenSize.width, screenSize.height - 64 - toolBarHeight);
    _scrollView.contentSize = CGSizeMake(screenSize.width * 3, 0);
    
    _theoreticalView.frame = CGRectMake(0, 0, screenSize.width, CGRectGetHeight(_scrollView.frame));
    _drivingView.frame = CGRectMake(screenSize.width, 0, screenSize.width, CGRectGetHeight(_scrollView.frame));
    _licensingView.frame = CGRectMake(screenSize.width * 2, 0, screenSize.width, CGRectGetHeight(_scrollView.frame));
    
//    _theoreticalView.backgroundColor = [UIColor redColor];
//    _drivingView.backgroundColor = [UIColor orangeColor];
//    _licensingView.backgroundColor = [UIColor magentaColor];
}

#pragma mark - lazy load
- (DVVToolBarView *)dvvToolBarView {
    if (!_dvvToolBarView) {
        _dvvToolBarView = [DVVToolBarView new];
        _dvvToolBarView.titleArray = @[ @"理论学员", @"上车学员", @"领证学员" ];
        __weak typeof(self) ws = self;
        [_dvvToolBarView dvvSetItemSelectedBlock:^(UIButton *button) {
            [ws toolBarItemSelectedAction:button];
        }];
        _dvvToolBarView.backgroundColor = [UIColor whiteColor];
    }
    return _dvvToolBarView;
}
- (UIView *)toolBarBottomLineView {
    if (!_toolBarBottomLineView) {
        _toolBarBottomLineView = [UIView new];
        _toolBarBottomLineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _toolBarBottomLineView;
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.bounces = NO;
    }
    return _scrollView;
}
- (DVVTheoreticalStudentListView *)theoreticalView {
    if (!_theoreticalView) {
        _theoreticalView = [DVVTheoreticalStudentListView new];
    }
    return _theoreticalView;
}
- (DVVDrivingStudentListView *)drivingView {
    if (!_drivingView) {
        _drivingView = [DVVDrivingStudentListView new];
    }
    return _drivingView;
}
- (DVVLicensingStudentListView *)licensingView {
    if (!_licensingView) {
        _licensingView = [DVVLicensingStudentListView new];
    }
    return _licensingView;
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
