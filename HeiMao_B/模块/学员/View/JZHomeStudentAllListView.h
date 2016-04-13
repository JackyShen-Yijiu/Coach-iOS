//
//  JZHomeStudentSubjectOneView.h
//  HeiMao_B
//
//  Created by ytzhang on 16/3/28.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshTableView.h"
#import "JZResultModel.h"

@interface JZHomeStudentAllListView : RefreshTableView

//@property (nonatomic, strong) RefreshTableView *tableView;
//
//@property (nonatomic, strong) NSMutableArray *dataArray;
//
@property (nonatomic, strong) UIViewController *parementVC;
//
@property (nonatomic, assign) NSInteger subjectID;  // 科目的选择
//
@property (nonatomic, assign) NSInteger studentState; // 学员状态的选择

@property (nonatomic, assign) kDateSearchType searchType;

//- (void)setCoachTeacherClickBlock:(void(^)(NSInteger tag))handle;
//
//- (void)setEvaluationClickBlock:(void(^)(NSInteger tag))handle;

// 刷新数据的方法
- (void)refreshUI;

// 请求网络数据的方法
- (void)networkRequest;

// 加载更多
- (void)moreData;
@end
