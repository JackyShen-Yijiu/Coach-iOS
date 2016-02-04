//
//  DVVTheoreticalStudentListCell.h
//  HeiMao_B
//
//  Created by 大威 on 16/2/3.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVVStudentListDMData.h"

@interface DVVTheoreticalStudentListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subjectInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *classHourLabel;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;

- (void)refreshData:(DVVStudentListDMData *)dmData;

@end
