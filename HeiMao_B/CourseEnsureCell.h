//
//  CourseEnsureCell.h
//  HeiMao_B
//
//  Created by kequ on 15/10/29.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMButton.h"

@class CourseEnsureCell;
@protocol CourseEnsureCellDelegate <NSObject>
- (void)courseCellDidEnstureClick:(CourseEnsureCell *)cell;
@end

@interface CourseEnsureCell : UITableViewCell
@property(nonatomic,weak)id<CourseEnsureCellDelegate>delegate;
@property(nonatomic,strong)HMButton * ensurebutton;

+ (CGFloat)cellHeigthWithTitle:(BOOL)isShowTitle;

- (void)setTitle:(NSString *)title;

@end
