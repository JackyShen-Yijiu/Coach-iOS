//
//  JZHomeStudentViewModel.m
//  
//
//  Created by ytzhang on 16/3/29.
//
//

#import "JZHomeStudentViewModel.h"
#import "JENetwoking.h"
#import "JZHomeStudetModelClassRoot.h"
#import "YYModel.h"
#import "JZResultModel.h"
@implementation JZHomeStudentViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _dataArray = [NSMutableArray array];
        _coachid = [UserInfoModel defaultUserInfo].userID;
        _index = 1;
        _count = 10;
    }
    return self;
}
- (void)dvv_networkRequestRefreshwithSubjectID:(NSString *)subjectid withStudentState:(NSString *)studentState {
    _index = 1;
    _subjectid = subjectid;
    _studentState = studentState;
    [self dvv_networkRequestWithIndex:_index isRefresh:YES];
}
- (void)dvv_networkRequestLoadMorewithSubjectID:(NSString *)subjectid withStudentState:(NSString *)studentState {
    _subjectid = subjectid;
    _studentState = studentState;
    [self dvv_networkRequestWithIndex:++_index isRefresh:NO];
}
- (void)dvv_networkRequestWithIndex:(NSUInteger)index isRefresh:(BOOL)isRefresh {
    
    [NetWorkEntiry coachStudentListWithCoachId:_coachid subjectID:_subjectid studentID:_studentState index:_index count:_count success:^(AFHTTPRequestOperation *operation, id responseObject) {
         [self dvv_networkCallBack];
        JZHomeStudetModelClassRoot *dmRoot = [JZHomeStudetModelClassRoot yy_modelWithJSON:responseObject];
        if (0 == dmRoot.type) {
            if (isRefresh) {
                [self dvv_refreshError];
            }else {
                [self dvv_loadMoreError];
            }
            return ;
        }
        if (!dmRoot.data.count) {
        [self dvv_nilResponseObject];
            return ;
        }
        
        if (isRefresh) {
            [_dataArray removeAllObjects];
        }
        
        for (NSDictionary *dict in dmRoot.data) {
            JZResultModel *dmData = [JZResultModel yy_modelWithDictionary:dict];
            [_dataArray addObject:dmData];
        }
        
        if (isRefresh) {
            [self dvv_refreshSuccess];
        }else {
            [self dvv_loadMoreSuccess];
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self dvv_networkCallBack];
        [self dvv_networkError];
    }];
    
}

@end
