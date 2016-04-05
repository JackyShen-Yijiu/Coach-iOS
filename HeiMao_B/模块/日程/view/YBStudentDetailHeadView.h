//
//  YBStudentDetailHeadView.h
//  HeiMao_B
//
//  Created by JiangangYang on 16/3/30.
//  Copyright © 2016年 ke. All rights reserved.
//  顶部控件

#import <UIKit/UIKit.h>

@class YBStudentDetailsRootClass;

@interface YBStudentDetailHeadView : UIView
// 大背景
@property (nonatomic, strong) UIImageView *bgImageView;
// 阴影
@property (nonatomic, strong) UIImageView *alphaView;
// 头像
@property (nonatomic, strong) UIImageView *iconImageView;
// 浅色条目
@property (nonatomic, strong) UIView *midView;
// 全周班
@property (nonatomic, strong) UILabel *classLabel;
// 聊天
@property (nonatomic,strong) UIButton *chatBtn;
// 打电话
@property (nonatomic,strong) UIButton *callBtn;
// 状态
@property (nonatomic, strong) UIImageView *stateImageView;

@property (nonatomic,strong) YBStudentDetailsRootClass *dmData;

@property (nonatomic,weak) UIViewController *parentViewController;

- (void)refreshData:(YBStudentDetailsRootClass *)dmData;

@end
