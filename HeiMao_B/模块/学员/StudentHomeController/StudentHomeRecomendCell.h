//
//  StudentHomeRecomendCell.h
//  HeiMao_B
//
//  Created by kequ on 15/10/28.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMRecomendModel.h"

@interface StudentHomeRecomendCell : UITableViewCell
@property(nonatomic,strong)HMRecomendModel * model;
+ (CGFloat)cellHigthWithModel:(HMRecomendModel *)model;
@end
