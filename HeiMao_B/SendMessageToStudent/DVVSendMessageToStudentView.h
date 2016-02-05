//
//  DVVSendMessageToStudentView.h
//  HeiMao_B
//
//  Created by 大威 on 16/2/3.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVVStudentListViewModel.h"

typedef void(^DVVSendMessageToStudentViewBlock)(UIButton *button, NSArray *mobileArray);

@interface DVVSendMessageToStudentView : UIView

@property (nonatomic, assign) NSUInteger studentType;

@property (nonatomic, strong) DVVStudentListViewModel *viewModel;

// 存储要拨打的学员的电话号码(所有的key)
@property (nonatomic, strong) NSMutableDictionary *mobileDict;

- (void)setSelectButtonTouchUpInsideBlock:(DVVSendMessageToStudentViewBlock)handle;

- (void)beginNetworkRequest;

@end
