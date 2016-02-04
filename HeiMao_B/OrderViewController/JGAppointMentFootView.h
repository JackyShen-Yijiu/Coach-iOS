//
//  JGAppointMentFootView.h
//  BlackCat
//
//  Created by bestseller on 15/10/3.
//  Copyright © 2015年 lord. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppointmentCoachTimeInfoModel;

@protocol JGAppointMentFootViewDelegate <NSObject>

// 日程选中的代理方法
- (void)JGAppointMentFootViewWithCollectionViewDidSelectItemAtIndexPath:(NSIndexPath *)indexPath timeInfo:(AppointmentCoachTimeInfoModel *)model;

@end

@interface JGAppointMentFootView : UIView

// 刷新数据源
// coachTimeData数组是HMCourseModel模型
- (void)receiveCoachTimeData:(NSArray *)coachTimeData;

@property (weak, nonatomic) id <JGAppointMentFootViewDelegate>delegate;

@property (nonatomic,weak) UIViewController *parentViewController;

@end
