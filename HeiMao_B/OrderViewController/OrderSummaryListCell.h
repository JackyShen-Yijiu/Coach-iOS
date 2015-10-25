//
//  OrderSummaryListCell.h
//  HeiMao_B
//
//  Created by kequ on 15/10/25.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PortraitView.h"
#import "HMOrderModel.h"

@interface OrderSummaryListCell : UITableViewCell
@property(nonatomic,strong)HMOrderModel * model;

+ (CGFloat)cellHeight;

@end
