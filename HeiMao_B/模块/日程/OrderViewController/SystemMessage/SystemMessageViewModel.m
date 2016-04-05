//
//  SystemMessageViewModel.m
//  HeiMao_B
//
//  Created by ytzhang on 16/1/14.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "SystemMessageViewModel.h"
#import "SystemMessageModel.h"
#import "SystemMessageModelRootClass.h"

@implementation SystemMessageViewModel
- (void)networkRequestRefresh{
    
    NSString *coachid = [UserInfoModel defaultUserInfo].userID;
   [NetWorkEntiry getSystemMessageCoachid:coachid withSeqindex:1 withCount:10 success:^(AFHTTPRequestOperation *operation, id responseObject) {
       NSArray *resultArray = [responseObject objectForKey:@"data"];
       if (resultArray.count == 0) {
           [self showMsg:@"还没有数据哦!"];
           return ;

       }
       // 检测是否有数据
       if ([self checkErrorWithData:responseObject]) {
           [self.systemMessageArray removeAllObjects];
           if (_tableViewNeedReLoad) {
               _tableViewNeedReLoad();
           }
           return ;
       }
       [self.systemMessageArray removeAllObjects];
       SystemMessageModelRootClass *informationMessageModel = [[SystemMessageModelRootClass alloc] initWithJsonDict:responseObject];
       _systemMessageArray = [[NSMutableArray alloc] initWithArray:informationMessageModel.data];
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
    
    
    // 判断加载时当前的请求的页面
    NSInteger dataCount = 0;
    if (self.systemMessageArray.count) {
        if (self.systemMessageArray.count <= 10) {
            dataCount = 10;
        }else {
            NSInteger temp = self.systemMessageArray.count % 10;
            if (temp) {
                temp += 10 - temp;
            }
            dataCount = self.systemMessageArray.count + temp;
        }
    }
    NSInteger index = dataCount / 10 + 1;
    // 设置当前请求的页面
    _index = index;
    NSString *coachid = [UserInfoModel defaultUserInfo].userID;
    [NetWorkEntiry getSystemMessageCoachid:coachid withSeqindex:index withCount:10 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 检测是否有数据
        if ([self checkErrorWithData:responseObject]) {
            NSString *msg = @"没有找到数据";
            if (self.systemMessageArray.count) {
                msg = @"已经加载完成全部数据";
            }
            [self showMsg:msg];
            if (_tableViewNeedReLoad) {
                _tableViewNeedReLoad();
            }

            return ;
        }
        SystemMessageModelRootClass *informationMessageModel = [[SystemMessageModelRootClass alloc] initWithJsonDict:responseObject];
        _systemMessageArray = [[NSMutableArray alloc] initWithArray:informationMessageModel.data];
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
