//
//  JGYuYueHeadView.h
//  BlackCat
//
//  Created by bestseller on 15/10/3.
//  Copyright © 2015年 lord. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppointmentCoachTimeInfoModel;

@protocol JGYuYueHeadViewDelegate <NSObject>

// 日程选中的代理方法，刷新日程模块底部列表数据
- (void)JGYuYueHeadViewWithCollectionViewDidSelectItemAtIndexPath:(NSIndexPath *)indexPath timeInfo:(AppointmentCoachTimeInfoModel *)model;

@end

@interface JGYuYueHeadView : UIView

// 刷新数据源
- (void)receiveCoachTimeData:(NSArray *)coachTimeData;

@property (weak, nonatomic) id <JGYuYueHeadViewDelegate>delegate;

// 点击选中的数据
@property (strong, nonatomic) NSMutableArray *upDateArray;

@property (nonatomic,weak) UIViewController *parentViewController;

@end
