//
//  StudentSignInViewModel.m
//  HeiMao_B
//
//  Created by 大威 on 16/1/12.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "StudentSignInViewModel.h"
#import "NetWorkEntiry.h"

@implementation StudentSignInViewModel

- (void)dvvNetworkRequestRefresh {
    
    [NetWorkEntiry studentSignInWithUserId:_userId
                                   coachId:_coachId
                             reservationId:_reservationId
                            codeCreateTime:_codeCreateTime
                              userlatitude:_userlatitude
                             userLongitude:_userLongitude
                             coachLatitude:_coachLatitude
                            coachLongitude:_coachLongitude
                                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                       
                                       if ([self dvvCheckErrorWithResponseObject:responseObject]) {
                                           // 调用失败回调
                                           [self dvvRefreshError];
                                           return ;
                                       }
                                       // 调用成功回调
                                       [self dvvRefreshSuccess];
                                       
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 调用失败回调
        [self dvvNetworkError];
    }];
}

- (BOOL)dvvCheckErrorWithResponseObject:(id)responseObject {
    
    // 对象不为空
    if (!responseObject) {
        return YES;
    }
    NSDictionary *dict = responseObject;
    // 对象是字典类型
    if (![dict isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    // type是否为1
    if (![[dict objectForKey:@"type"] integerValue]) {
        return YES;
    }
//    if (![[dict objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
//        return YES;
//    }
//    NSArray *array = [dict objectForKey:@"data"];
//    if (!array.count) {
//        return YES;
//    }
    
    return NO;
}

@end
