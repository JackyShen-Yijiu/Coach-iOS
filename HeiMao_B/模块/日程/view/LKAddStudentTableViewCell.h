//
//  AddStudentTableViewCell.h
//  添加学员
//
//  Created by 雷凯 on 16/3/28.
//  Copyright © 2016年 leifaxian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student.h"

@interface LKAddStudentTableViewCell : UITableViewCell
/// 学员名称 -- UILabel
@property (nonatomic, weak) UILabel *studentNameLabel;
/// 学员学习详情 -- UILabel
@property (nonatomic, weak) UILabel *studyDetilsLabel;
/// 学员头像 -- UIImageView
@property (nonatomic, weak) UIImageView *studentIconView;
/// 拨打学员电话按钮 -- UIButton
@property (nonatomic, weak) UIButton *callStudentButton;
/// 选择学员的按钮 -- UIButton
@property (nonatomic, weak) UIImageView *selectImageView;
//@property (nonatomic, strong) Student *studentModel;

@end
