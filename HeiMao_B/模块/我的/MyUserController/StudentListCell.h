//
//  StudentListCell.h
//  HeiMao_B
//
//  Created by bestseller on 15/11/16.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMStudentModel.h"

@interface StudentListCell : UITableViewCell
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UIImageView *leftImageView;
@property (strong, nonatomic) UILabel *detailContentLabel;

@property (strong, nonatomic) HMStudentModel * stuModel;
@end
