//
//  courseDetailCell.h
//  HeiMao_B
//
//  Created by kequ on 15/10/27.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PortraitView.h"
#import "HMCourseModel.h"


@class CourseDetailView;
@protocol CourseDetailViewDelegate <NSObject>
- (void)courseDetailViewDidClickStudentDetail:(CourseDetailView *)view;
- (void)courseDetailViewDidClickAgreeButton:(CourseDetailView *)view;
- (void)courseDetailViewDidClickDisAgreeButton:(CourseDetailView *)view;
- (void)courseDetailViewDidClickWatingToDone:(CourseDetailView*)view;
- (void)courseDetailViewDidClickCanCelButton:(CourseDetailView *)view;
- (void)courseDetailViewDidClickRecommentButton:(CourseDetailView *)view;
@end
@interface CourseDetailView : UIView
@property(nonatomic,strong)HMCourseModel * model;
@property(nonatomic,weak)id<CourseDetailViewDelegate>delegate;
+ (CGFloat)cellHeightWithModel:(HMCourseModel *)model;
- (void)refreshUI;
@end