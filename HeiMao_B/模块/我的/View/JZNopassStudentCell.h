//
//  JZNopassStudentCell.h
//  HeiMao_B
//
//  Created by 雷凯 on 16/4/1.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZExamStudentListData.h"

@interface JZNopassStudentCell : UITableViewCell

/// 未通过学生头像
@property (nonatomic, strong) UIImageView *studentIcon;

/// 未通过学生名字
@property (nonatomic, strong) UILabel *studentName;

/// 未通过学员姓名
@property (nonatomic, strong) UILabel *StudentScore;
@property (nonatomic, strong) JZExamStudentListData *examListData;





@end
