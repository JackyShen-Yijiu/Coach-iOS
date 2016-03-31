//
//  OrderSummaryDayCell.h
//  HeiMao_B
//
//  Created by kequ on 15/10/25.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBCourseData.h"
@interface CourseSummaryDayCell : UITableViewCell

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) NSInteger selectIndex;

@property (nonatomic, copy) NSString *selectData;

@property(nonatomic,strong)YBCourseData * model;
@property (nonatomic,strong) UIViewController *parentViewController;

+ (CGFloat)cellHeightWithModel:(YBCourseData *)model;

@end
