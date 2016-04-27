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
@property (weak, nonatomic) IBOutlet UIButton *studentCountButton;




///// 通过数量--按钮
@property (weak, nonatomic) IBOutlet UIButton *passCountButton;



///// 缺考学生数量
@property (weak, nonatomic) IBOutlet UIButton *missExamStudentButton;



///未通过下拉
@property (weak, nonatomic) IBOutlet UIView *nopassView;

/// 未通过图片
@property (weak, nonatomic) IBOutlet UIImageView *nopassDownImg;

/// 未通过人数
@property (weak, nonatomic) IBOutlet UILabel *nopassCountLabel;

@property (nonatomic, strong) JZExamSummaryInfoData *modelGrop;
@property (weak, nonatomic) IBOutlet UILabel *passTitle;


/// 创建examHeaderView
+ (instancetype)examHeaderViewWithTableView:(UITableView *)tableView withTag:(NSInteger)tag ;



@end
