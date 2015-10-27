//
//  OrderDetailViewController.m
//  HeiMao_B
//
//  Created by kequ on 15/10/27.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailView.h"

@interface OrderDetailViewController()<OrderDetailViewDelegate>
@property(nonatomic,strong)OrderDetailView* detailView;
@end
@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark Life Sycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initNavBar];
}




#pragma mark - initUI

- (void)initNavBar
{
    [self resetNavBar];
    self.title = @"预约详情";
}

-(void)setOrderModel:(HMOrderModel *)orderModel
{
    _orderModel = orderModel;
    self.detailView.model = orderModel;
}

- (OrderDetailView *)detailView
{
    if (!_detailView) {
        _detailView = [[OrderDetailView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, [OrderDetailView cellHeight])];
        _detailView.delegate = self;
        [self.view addSubview:_detailView];
    }
    return _detailView;
}
#pragma mark - LoadData
- (void)refreshUI
{
    
}

#pragma mark - Action
- (void)orderDetailViewDidClickAgreeButton:(OrderDetailView *)view
{
    //同意
    _orderModel.orderStatue = KOrderStatueUnderWay;
    self.orderModel = _orderModel;
}

- (void)orderDetailViewDidClickDisAgreeButton:(OrderDetailView *)view
{
    //拒绝
}

- (void)orderDetailViewDidClickCanCelButton:(OrderDetailView *)view
{
    //取消
}

- (void)orderDetailViewDidClickWatingToDone:(OrderDetailView *)view
{
    //确定学完
}

- (void)orderDetailViewDidClickRecommentButton:(OrderDetailView *)view
{
    //评论
}

- (void)orderDetailViewDidClickStudentDetail:(OrderDetailView *)view
{
    //学员信息
}

@end
