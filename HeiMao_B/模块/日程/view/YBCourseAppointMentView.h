//
//  YBCourseAppointMentView.h
//  HeiMao_B
//
//  Created by JiangangYang on 16/3/28.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBCourseData.h"

@interface YBCourseAppointMentView : UIView

@property(nonatomic,strong)YBCourseData * model;

@property (nonatomic,strong) UIViewController *parentViewController;

- (CGFloat)courseAppointMentViewWithCourseData:(YBCourseData *)model;

@end
