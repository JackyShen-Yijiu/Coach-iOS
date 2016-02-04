//
//  DVVStudentListViewModel.m
//  HeiMao_B
//
//  Created by 大威 on 16/2/3.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "DVVStudentListViewModel.h"
#import "NetWorkEntiry.h"
#import "YYModel.h"

@implementation DVVStudentListViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataArray = [NSMutableArray array];
        // 理论学员：1    上车学员：2    拿证学员：3
        _studentType = 1;
        // 从第一页开始加载（0：请求全部）
        _index = 1;
        
        //
        _defaultIndex = 1;
    }
    return self;
}

- (void)dvvNetworkRequestRefresh {
    _index = _defaultIndex;
    [self dvvNetworkRequestWithIndex:_index isRefresh:YES];
}
- (void)dvvNetworkRequestLoadMore {
    [self dvvNetworkRequestWithIndex:++_index isRefresh:NO];
}

- (void)dvvNetworkRequestWithIndex:(NSUInteger)index isRefresh:(BOOL)isRefresh {
    
    NSString *coachId = [UserInfoModel defaultUserInfo].userID;
//    NSLog(@"student list coachId: %@ token: %@", coachId, [UserInfoModel defaultUserInfo].token);
    [NetWorkEntiry coachStudentListWithCoachId:coachId studentType:_studentType index:_index success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self dvvNetworkCallBack];
        NSLog(@"%@", responseObject);
        DVVStudentListDMRootClass *dmRoot = [DVVStudentListDMRootClass yy_modelWithJSON:responseObject];
        if (0 == dmRoot.type) {
            if (isRefresh) {
                [self dvvRefreshError];
            }else {
                [self dvvLoadMoreError];
            }
            return ;
        }
        if (!dmRoot.data.count) {
            [self dvvNilResponseObject];
            return ;
        }
        
        if (isRefresh) {
            [_dataArray removeAllObjects];
        }
        
        for (NSDictionary *dataDict in dmRoot.data) {
            DVVStudentListDMData *dmData = [DVVStudentListDMData yy_modelWithDictionary:dataDict];
            [_dataArray addObject:dmData];
        }
        if (isRefresh) {
            [self dvvRefreshSuccess];
        }else {
            [self dvvLoadMoreSuccess];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self dvvNetworkCallBack];
        [self dvvNetworkError];
    }];
    
}

@end
