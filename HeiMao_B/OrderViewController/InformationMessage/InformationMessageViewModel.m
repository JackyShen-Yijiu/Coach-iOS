//
//  InformationMessageViewModel.m
//  HeiMao_B
//
//  Created by ytzhang on 16/1/13.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "InformationMessageViewModel.h"
#import "InformationMessageModelRootClass.h"
#import "InformationMessageModel.h"

@implementation InformationMessageViewModel
- (void)networkRequestRefresh{
    [NetWorkEntiry getInformationMessageSeqindex:0 withCount:10 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 检测是否有数据
        if ([self checkErrorWithData:responseObject]) {
            [self.informationArray removeAllObjects];
            if (_tableViewNeedReLoad) {
                _tableViewNeedReLoad();
            }
            return ;
        }
        [self.informationArray removeAllObjects];
        InformationMessageModelRootClass *informationMessageModel = [[InformationMessageModelRootClass alloc] initWithJsonDict:responseObject];
         _informationArray = [[NSMutableArray alloc] initWithArray:informationMessageModel.data];
        if (_tableViewNeedReLoad) {
            _tableViewNeedReLoad();
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (_showToast) {
            _showToast();
        }

    }];
    
}
- (void)networkRequestLoadMore {
    InformationMessageModel *model = [self.informationArray lastObject];
    _index =[model.seqindex integerValue];
    
    [NetWorkEntiry getInformationMessageSeqindex:_index withCount:10 success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        InformationMessageModelRootClass *informationMessageModel = [[InformationMessageModelRootClass alloc] initWithJsonDict:responseObject];
            _informationArray = [[NSMutableArray alloc] initWithArray:informationMessageModel.data];
        if (_tableViewNeedReLoad) {
            _tableViewNeedReLoad();
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
}
#pragma mark 检测是否有数据
- (BOOL)checkErrorWithData:(id)data {
    
//    DYNSLog(@"%@",data);
    if (!data) {
        return YES;
    }
    NSDictionary *dict = data;
    if (![dict isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    if (![[dict objectForKey:@"type"] integerValue]) {
        return YES;
    }
    if (![[dict objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
        return YES;
    }
    NSArray *array = [dict objectForKey:@"data"];
    if (!array.count) {
        return YES;
    }
    
    return NO;
}
- (void)showMsg:(NSString *)message {
    
    ToastAlertView *toast = [[ToastAlertView alloc] initWithTitle:message];
    [toast show];
}

@end
