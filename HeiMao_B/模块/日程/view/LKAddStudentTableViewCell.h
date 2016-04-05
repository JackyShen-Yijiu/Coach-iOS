//
//  AddStudentTableViewCell.h
//  添加学员
//
//  Created by 雷凯 on 16/3/28.
//  Copyright © 2016年 leifaxian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LKAddStudentData.h"
//#import "Student.h"

@interface LKAddStudentTableViewCell : UITableViewCell
/// 学员名称 -- UILabel
//@property (nonatomic, strong) UILabel *studentNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *studentNameLabel;


/// 学员学习详情 -- UILabel
//@property (nonatomic, strong) UILabel *studyDetilsLabel;
@property (weak, nonatomic) IBOutlet UILabel *studyDetilsLabel;

/// 学员头像 -- UIImageView
//@property (nonatomic, strong) UIImageView *studentIconView;
@property (weak, nonatomic) IBOutlet UIImageView *studentIconView;

/// 拨打学员电话按钮 -- UIButton
//@property (nonatomic, strong) UIButton *callStudentButton;

@property (weak, nonatomic) IBOutlet UIButton *callStudentButton;

/// 选择学员的按钮 -- UIImageView
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;
//@property (nonatomic, strong) UIImageView *selectImageView;
//@property (nonatomic, strong) Student *studentModel;

@property (nonatomic, strong) LKAddStudentData *model;


@end
