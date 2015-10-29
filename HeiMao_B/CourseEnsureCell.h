//
//  CourseEnsureCell.h
//  HeiMao_B
//
//  Created by kequ on 15/10/29.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CourseEnsureCell;
@protocol CourseEnsureCellDelegate <NSObject>
- (void)courseCellDidEnstureClick:(CourseEnsureCell *)cell;
@end

@interface CourseEnsureCell : UITableViewCell
@property(nonatomic,weak)id<CourseEnsureCellDelegate>delegate;

+ (CGFloat)cellHeigthWithTitle:(BOOL)isShowTitle;

- (void)setTitle:(NSString *)title;

@end
