//
//  JZExamHeaderView.h
//  HeiMao_B
//
//  Created by 雷凯 on 16/4/1.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZExamSummaryInfoData.h"
@interface JZExamHeaderView : UITableViewHeaderFooterView


///// 日期控件
@property (weak, nonatomic) IBOutlet UILabel *examDataLabel;

///// 考试科目控件
@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;

///// 通过率 “百分比”
@property (weak, nonatomic) IBOutlet UILabel *passrateCountLabel;

///// 报考数量
@property (weak, nonatomic) IBOutlet UILabel *studentCountLabel;

///// 通过数量--按钮
@property (weak, nonatomic) IBOutlet UIButton *passCountButton;

///// 未通过数量
@property (weak, nonatomic) IBOutlet UILabel *nopassCountLabel;

///// 缺考学生数量
@property (weak, nonatomic) IBOutlet UILabel *missExamStudentLabel;

///未通过下拉(需要添加点击事件)
@property (weak, nonatomic) IBOutlet UIView *nopassDown;



@property (nonatomic, strong) JZExamSummaryInfoData *modelGrop;


/// 创建examHeaderView
+ (instancetype)examHeaderViewWithTableView:(UITableView *)tableView;



@end
