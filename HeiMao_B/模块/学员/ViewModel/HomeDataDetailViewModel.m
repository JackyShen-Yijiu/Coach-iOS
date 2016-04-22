//
//  HomeDataDetailViewModel.m
//  Headmaster
//
//  Created by 大威 on 15/12/12.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HomeDataDetailViewModel.h"
#import <YYModel.h>
@implementation HomeDataDetailViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _allListArray = [NSMutableArray array];
        _noexamListArray = [NSMutableArray array];
        _appiontListArray = [NSMutableArray array];
        _retestListArray = [NSMutableArray array];
        _passListArray = [NSMutableArray array];
        _allIndex = 1;
        _noexamIndex = 1;
        _appiontIndex = 1;
        _passIndex = 1;
        _retestIndex = 1;
        
    }
    return self;
}
- (void)networkRequestRefresh {
    _allIndex = 1;
    _noexamIndex = 1;
    _appiontIndex = 1;
    _passIndex = 1;
    _retestIndex = 1;

    NSInteger index = 0;
    if (_searchType == kDateSearchTypeToday) {
        index = _allIndex;
    }
    if (_searchType == kDateSearchTypeYesterday) {
        index = _noexamIndex;
    }
    
    if (_searchType == kDateSearchTypeWeek) {
       index = _appiontIndex;
    }
    
    if (_searchType == kDateSearchTypeMonth) {
        index = _retestIndex;
    }
    if (_searchType == kDateSearchTypeYear) {
        index = _passIndex;
    }
    
    [NetWorkEntiry coachStudentListWithCoachId:[[UserInfoModel defaultUserInfo] userID] subjectID:(NSString *)@(self.subjectID) studentID:(NSString *)@(self.studentState) index:index count:10 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject=%@ subjectID=%@ State == %@  ",responseObject, (NSString *)@(self.subjectID),(NSString *)@(self.studentState) );
        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        NSArray *data = [responseObject objectArrayForKey:@"data"];
        if (type == 1) {
            
            [self.allListArray removeAllObjects];
            [self.noexamListArray removeAllObjects];
            [self.appiontListArray removeAllObjects];
            [self.retestListArray removeAllObjects];
            [self.passListArray removeAllObjects];
            
            if (data.count == 0) {
               
            }
        
            for (NSDictionary *dic in data) {
                JZResultModel *model = [JZResultModel yy_modelWithDictionary:dic];
                if (_searchType == kDateSearchTypeToday) {
                    [_allListArray addObject:model];
                }
                if (_searchType == kDateSearchTypeYesterday) {
                    [_noexamListArray addObject:model];
                }

                if (_searchType == kDateSearchTypeWeek) {
                    [_appiontListArray addObject:model];
                }

                if (_searchType == kDateSearchTypeMonth) {
                    [_retestListArray addObject:model];
                }
                if (_searchType == kDateSearchTypeYear) {
                    [_passListArray addObject:model];
                }

               
            }
            
           [self successRefreshBlock];
            
            
        }else{
           
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"网络错误!"];
        [alertView show];

    }];

}
- (void)networkRequestLoadMore{
    
    NSInteger index = 0;
    if (_searchType == kDateSearchTypeToday) {
        index = ++_allIndex;
    }
    if (_searchType == kDateSearchTypeYesterday) {
        index = ++_noexamIndex;
    }
    
    if (_searchType == kDateSearchTypeWeek) {
        index = ++_appiontIndex;
    }
    
    if (_searchType == kDateSearchTypeMonth) {
        index = ++_retestIndex;
    }
    if (_searchType == kDateSearchTypeYear) {
        index = ++_passIndex;
    }

    
    
    
    
    [NetWorkEntiry coachStudentListWithCoachId:[[UserInfoModel defaultUserInfo] userID] subjectID:(NSString *)@(self.subjectID) studentID:(NSString *)@(self.studentState) index:index count:10 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject=%@ subjectID=%@ State == %@ _titleIndex_titleIndex = %lu ",responseObject, (NSString *)@(self.subjectID),(NSString *)@(self.studentState),index);
        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        NSArray *data = [responseObject objectArrayForKey:@"data"];
        if (type == 1) {
            
            if (data.count == 0) {
            
                [self successLoadMoreBlockAndNoData];
            }
            
            for (NSDictionary *dic in data) {
                JZResultModel *model = [JZResultModel yy_modelWithDictionary:dic];
                if (_searchType == kDateSearchTypeToday) {
                    [_allListArray addObject:model];
                }
                if (_searchType == kDateSearchTypeYesterday) {
                    [_noexamListArray addObject:model];
                }
                
                if (_searchType == kDateSearchTypeWeek) {
                    [_appiontListArray addObject:model];
                }
                
                if (_searchType == kDateSearchTypeMonth) {
                    [_retestListArray addObject:model];
                }
                if (_searchType == kDateSearchTypeYear) {
                    [_passListArray addObject:model];
                }
                
                
            }
            
            [self successLoadMoreBlock];
        }else{
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"网络错误!"];
        [alertView show];
        
    }];

}




- (void)showAlert:(NSString *)title {
    ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:title];
    [alertView show];
}

@end
