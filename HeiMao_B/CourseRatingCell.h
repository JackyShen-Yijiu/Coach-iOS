//
//  CourseRatingCell.h
//  HeiMao_B
//
//  Created by kequ on 15/10/29.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,KRateType) {
    KRateTypeAll,
    KRateTypeTime,
    KRateTypeAttitude,
    KRateTypeAbility
};

@class CourseRatingCell;
@protocol CourseRatingCellDelegate <NSObject>
- (void)courseRatingCell:(CourseRatingCell *)cell DidChangeValue:(CGFloat)value;
@end

@interface CourseRatingModel : NSObject
@property(nonatomic,strong)NSString * title;
@property(nonatomic,assign)CGFloat rating;
@property(nonatomic,assign)KRateType type; //扩展字段
@end

@interface CourseRatingCell : UITableViewCell
@property(nonatomic,strong)CourseRatingModel * model;
@property(nonatomic,assign)id<CourseRatingCellDelegate> delegate;
@property(nonatomic,assign)BOOL makeLineAligent;
@property(nonatomic,strong)UIView * bottonLineView;
+ (CGFloat)cellHigth;
@end
