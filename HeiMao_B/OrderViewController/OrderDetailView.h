//
//  OrderDetailCell.h
//  HeiMao_B
//
//  Created by kequ on 15/10/27.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PortraitView.h"
#import "HMOrderModel.h"


@class OrderDetailView;
@protocol OrderDetailViewDelegate <NSObject>
- (void)orderDetailViewDidClickStudentDetail:(OrderDetailView *)view;
- (void)orderDetailViewDidClickAgreeButton:(OrderDetailView *)view;
- (void)orderDetailViewDidClickDisAgreeButton:(OrderDetailView *)view;
- (void)orderDetailViewDidClickWatingToDone:(OrderDetailView*)view;
- (void)orderDetailViewDidClickCanCelButton:(OrderDetailView *)view;
- (void)orderDetailViewDidClickRecommentButton:(OrderDetailView *)view;
@end
@interface OrderDetailView : UIView
@property(nonatomic,strong)HMOrderModel * model;
@property(nonatomic,weak)id<OrderDetailViewDelegate>delegate;
+ (CGFloat)cellHeight;

@end