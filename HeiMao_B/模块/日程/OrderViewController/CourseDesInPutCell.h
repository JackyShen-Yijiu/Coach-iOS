//
//  GoodsDesInPutCell.h
//  JewelryApp
//
//  Created by kequ on 15/5/9.
//  Copyright (c) 2015年 jewelry. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CourseDesInPutCell;
@protocol CourseDesInPutCellDelegate <NSObject>
- (void)courseDesInPutCellDidTextViewWillChangeToString:(NSString *)str;
@end
@interface CourseDesInPutCell : UITableViewCell
+ (CGFloat)cellHeight;
@property(nonatomic,weak)id<CourseDesInPutCellDelegate>delegate;
@property(nonatomic,strong)UITextView * textView;
@property(nonatomic,strong)UILabel * placeLabel;
@end
