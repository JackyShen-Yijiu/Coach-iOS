//
//  DVVSendMessageToStudentController.m
//  HeiMao_B
//
//  Created by 大威 on 16/2/3.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "DVVSendMessageToStudentController.h"
#import "DVVToolBarView.h"
#import "DVVSendMessageToStudentView.h"

@interface DVVSendMessageToStudentController ()<UIScrollViewDelegate>

@property (nonatomic, strong) DVVToolBarView *dvvToolBarView;
@property (nonatomic, strong) UIView *toolBarBottomLineView;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) DVVSendMessageToStudentView *theoreticalView;
@property (nonatomic, strong) DVVSendMessageToStudentView *drivingView;
@property (nonatomic, strong) DVVSendMessageToStudentView *licensingView;

@property (nonatomic, strong) UIButton *senderMessagebutton;

@end

@implementation DVVSendMessageToStudentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"群发短信";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.senderMessagebutton];
    self.navigationItem.rightBarButtonItem = item;
    
    [self.view addSubview:self.dvvToolBarView];
    [self.view addSubview:self.toolBarBottomLineView];
    [self.view addSubview:self.scrollView];
    [_scrollView addSubview:self.theoreticalView];
    [_scrollView addSubview:self.drivingView];
    [_scrollView addSubview:self.licensingView];
    [self configUI];
    
    // 请求数据
    [_theoreticalView beginNetworkRequest];
    [_drivingView beginNetworkRequest];
    [_licensingView beginNetworkRequest];
}

#pragma mark - action
- (void)theoreticalSelectButtonAction:(UIButton *)sender mobileArray:(NSArray *)array {
    NSLog(@"1===%@", array);
}
- (void)drivingSelectButtonAction:(UIButton *)sender mobileArray:(NSArray *)array {
    NSLog(@"2===%@", array);
}
- (void)licensingSelectButtonAction:(UIButton *)sender mobileArray:(NSArray *)array {
    NSLog(@"3===%@", array);
}
- (void)sendMessageButtonAction:(UIButton *)sender {
    
}

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
- (DVVSendMessageToStudentView *)theoreticalView {
    if (!_theoreticalView) {
        _theoreticalView = [DVVSendMessageToStudentView new];
        _theoreticalView.studentType = 1;
        __weak typeof(self) ws = self;
        [_theoreticalView setSelectButtonTouchUpInsideBlock:^(UIButton *button, NSArray *mobileArray) {
            [ws theoreticalSelectButtonAction:button mobileArray:mobileArray];
        }];
    }
    return _theoreticalView;
}
- (DVVSendMessageToStudentView *)drivingView {
    if (!_drivingView) {
        _drivingView = [DVVSendMessageToStudentView new];
        _drivingView.studentType = 2;
        __weak typeof(self) ws = self;
        [_drivingView setSelectButtonTouchUpInsideBlock:^(UIButton *button, NSArray *mobileArray) {
            [ws drivingSelectButtonAction:button mobileArray:mobileArray];
        }];
    }
    return _drivingView;
}
- (DVVSendMessageToStudentView *)licensingView {
    if (!_licensingView) {
        _licensingView = [DVVSendMessageToStudentView new];
        _licensingView.studentType = 3;
        __weak typeof(self) ws = self;
        [_licensingView setSelectButtonTouchUpInsideBlock:^(UIButton *button, NSArray *mobileArray) {
            [ws licensingSelectButtonAction:button mobileArray:mobileArray];
        }];
    }
    return _licensingView;
}
- (UIButton *)senderMessagebutton {
    if (!_senderMessagebutton) {
        _senderMessagebutton = [UIButton new];
        [_senderMessagebutton setTitle:@"发送" forState:UIControlStateNormal];
        _senderMessagebutton.titleLabel.font = [UIFont systemFontOfSize:14];
        _senderMessagebutton.bounds = CGRectMake(0, 0, 14 * 2, 44);
        [_senderMessagebutton addTarget:self action:@selector(sendMessageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _senderMessagebutton;
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
