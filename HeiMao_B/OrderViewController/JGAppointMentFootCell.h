//
//  JGAppointMentFootCell.h
//  BlackCat
//
//  Created by bestseller on 15/10/3.
//  Copyright © 2015年 lord. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMCourseModel;
@class PortraitView;

@interface JGAppointMentFootCell : UICollectionViewCell

@property (nonatomic,strong) HMCourseModel *coachTimeInfo;

@property(nonatomic,strong)PortraitView * potraitView;

@property(nonatomic,strong)UILabel * mainTitle;

@property(nonatomic,strong)UILabel * subTitle;

@property(nonatomic,strong)UILabel * countLabel;

@property (strong, nonatomic) UIView *selectedAppView;

@property (nonatomic,strong) UIButton *addBtn;

@end
