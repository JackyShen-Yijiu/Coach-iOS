//
//  AppointmentCollectionViewCell.h
//  BlackCat
//
//  Created by bestseller on 15/10/3.
//  Copyright © 2015年 lord. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppointmentCoachTimeInfoModel;
@interface AppointmentCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UILabel *startTimeLabel;
@property (strong, nonatomic) UILabel *finalTimeLabel;
@property (strong, nonatomic) UILabel *remainingPersonLabel;

// 日程模块
@property (nonatomic,strong) AppointmentCoachTimeInfoModel *coachTimeInfo;
// 预约模块
@property (nonatomic,strong) AppointmentCoachTimeInfoModel *appointInfoModel;

@end
