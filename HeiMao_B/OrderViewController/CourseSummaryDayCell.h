//
//  OrderSummaryDayCell.h
//  HeiMao_B
//
//  Created by kequ on 15/10/25.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMCourseModel.h"

@interface CourseSummaryDayCell : UITableViewCell

@property(nonatomic,strong)HMCourseModel * model;

+ (CGFloat)cellHeight;

@end
