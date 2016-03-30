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

@property (nonatomic, strong) UIView *alphaView;

@property (nonatomic, strong) UIImageView *maskView;

@property (nonatomic, copy) NSString *studentID;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UIImageView *bgImageView;

- (void)refreshData:(YBStudentDetailsRootClass *)dmData;

+ (CGFloat)defaultHeight;

@end
