//
//  JZHomeStudentSubjectOneView.h
//  HeiMao_B
//
//  Created by ytzhang on 16/3/28.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshTableView.h"

@interface JZHomeStudentAllListView : UIView

@property (nonatomic, strong) RefreshTableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UIViewController *parementVC;

@property (nonatomic, assign) NSInteger subjectID;  // 科目的选择

@property (nonatomic, assign) NSInteger studentState; // 学员状态的选择


@end
