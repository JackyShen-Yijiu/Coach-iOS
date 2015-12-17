//
//  PicListCell.h
//  HeiMao_B
//
//  Created by kequ on 15/10/28.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickListView.h"

@interface CoursePicListCell : UITableViewCell
@property(nonatomic,strong)PickListView * pickListView;
+ (CGFloat)cellHight:(NSInteger)listCount couleNumber:(NSInteger)couleNumber;
@end
