//
//  HomeDataDetailViewModel.h
//  Headmaster
//
//  Created by 大威 on 15/12/12.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "YBBaseViewModel.h"
#import "JZResultModel.h"

@interface HomeDataDetailViewModel : YBBaseViewModel

@property (nonatomic, assign) kDateSearchType searchType;

@property (nonatomic, assign) NSInteger subjectID;  // 科目的选择

@property (nonatomic, assign) NSInteger studentState; // 学员状态的选择

@property (nonatomic, strong) NSMutableArray *allListArray;

@property (nonatomic, strong) NSMutableArray *noexamListArray;

@property (nonatomic, strong) NSMutableArray *appiontListArray;

@property (nonatomic, strong) NSMutableArray *retestListArray;

@property (nonatomic, strong) NSMutableArray *passListArray;

@property (nonatomic, assign) NSInteger allIndex;
@property (nonatomic, assign) NSInteger noexamIndex;
@property (nonatomic, assign) NSInteger appiontIndex;
@property (nonatomic, assign) NSInteger retestIndex;
@property (nonatomic, assign) NSInteger passIndex;
@end
