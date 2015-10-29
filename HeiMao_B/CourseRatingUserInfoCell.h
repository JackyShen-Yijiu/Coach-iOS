//
//  CourseRatingUserInfoCell.h
//  HeiMao_B
//
//  Created by kequ on 15/10/29.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HMStudentModel.h"

@interface CourseRatingUserInfoCell : UITableViewCell

@property(nonatomic,strong)HMStudentModel * model;

+ (CGFloat)cellHeigth;

@end
