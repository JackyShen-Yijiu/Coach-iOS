//
//  YBSignUpStudentListViewModel.h
//  HeiMao_B
//
//  Created by ytzhang on 16/2/4.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBSignUpStudentListViewModel : NSObject
@property (nonatomic, strong) NSMutableArray *systemMessageArray;

@property (nonatomic, assign) NSUInteger index;

@property (nonatomic, assign) NSUInteger count;

@property (nonatomic, copy) void (^tableViewNeedReLoad)(void);

@property (nonatomic, copy) void (^showToast)(void);

- (void)networkRequestRefresh;

- (void)networkRequestLoadMore;
@end
