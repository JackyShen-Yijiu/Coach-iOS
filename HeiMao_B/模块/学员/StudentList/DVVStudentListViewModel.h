//
//  DVVStudentListViewModel.h
//  HeiMao_B
//
//  Created by 大威 on 16/2/3.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "DVVBaseViewModel.h"
#import "DVVStudentListDMRootClass.h"

@interface DVVStudentListViewModel : DVVBaseViewModel

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSUInteger studentType;
@property (nonatomic, assign) NSUInteger index;

// 因为发送短信时要一次加载全部（index = 0），所以定义这个变量来区分
@property (nonatomic, assign) NSUInteger defaultIndex;

@end
