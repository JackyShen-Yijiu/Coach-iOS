//
//  JENetwoking.m
//  BlackCat
//
//  Created by bestseller on 15/9/24.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "JENetwoking.h"
#import <UIKit/UIKit.h>
#import "ToolHeader.h"
@interface JENetwoking ()
@property (copy, nonatomic) NSString *urlString;
@property (assign, nonatomic) JENetworkingRequestMethod method;
@property (weak, nonatomic) id<JENetwokingDelegate>delegate;
@end
@implementation JENetwoking
//大量数据下载
+ (instancetype)initWithUrl:(NSString *)urlString
       WithMethod:(JENetworkingRequestMethod)method
     WithDelegate:(id<JENetwokingDelegate>)delegate {
    DYNSLog(@"data ");

    JENetwoking *networking = [[self alloc] init];
    networking.urlString = urlString;
    networking.method = method;
    networking.delegate = delegate;
    [networking startDownLoad];
    return networking;
}

- (void)startDownLoad {
    
    if (self.method == JENetworkingRequestMethodGet) {

        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer.timeoutInterval = 30;
        manager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
        [manager GET:self.urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            if (responseObject == nil) {
                return;
            }
            if ([_delegate respondsToSelector:@selector(jeNetworkingCallBackData:)]) {
                [_delegate jeNetworkingCallBackData:responseObject];
            }
            
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {

        }];
    }
    
}
//简单获取回调用于按钮点击上传图片，点击发送消息
+ (void)startDownLoadWithUrl:(NSString *)urlString
                   postParam:(id)param
                  WithMethod:(JENetworkingRequestMethod)method
              withCompletion:(Completion)completion {
    
    
    Completion _completion = [completion copy];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    manager.requestSerializer.timeoutInterval = 30.0f;
    if (method == JENetworkingRequestMethodGet) {
        if ([UserInfoModel defaultUserInfo].token) {
            [manager.requestSerializer setValue:[UserInfoModel defaultUserInfo].token forHTTPHeaderField:@"authorization"];
        }
        [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            if (responseObject == nil) {
                return ;
            }
            if (_completion) {
                _completion(responseObject);
            }
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            DYNSLog(@"error = %@",error);
        }];
    }else if (method == JENetworkingRequestMethodPost) {
        NSAssert(param != nil, @"param 不能为空");
        if ([UserInfoModel defaultUserInfo].token) {
            [manager.requestSerializer setValue:[UserInfoModel defaultUserInfo].token forHTTPHeaderField:@"authorization"];
        }
        DYNSLog(@"token = %@",manager.requestSerializer.HTTPRequestHeaders);

        [manager POST:urlString parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            DYNSLog(@"responseObject = %@",responseObject);
            if (responseObject == nil) {
                return ;
            }
            if (_completion) {
                _completion(responseObject);
            }
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            DYNSLog(@"error = %@",error);

        }];
        
    }else if (method == JENetworkingRequestMethodPut) {
        if ([UserInfoModel defaultUserInfo].token) {
            [manager.requestSerializer setValue:[UserInfoModel defaultUserInfo].token forHTTPHeaderField:@"authorization"];
        }
        DYNSLog(@"token = %@",manager.requestSerializer.HTTPRequestHeaders);
        
        [manager PUT:urlString parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            DYNSLog(@"responseObject = %@",responseObject);
            if (responseObject == nil) {
                return ;
            }
            if (_completion) {
                _completion(responseObject);
            }
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            DYNSLog(@"error = %@",error);
            
        }];
    }else if (method == JENetworkingRequestMethodDelete) {
        if ([UserInfoModel defaultUserInfo].token) {
            [manager.requestSerializer setValue:[UserInfoModel defaultUserInfo].token forHTTPHeaderField:@"authorization"];
        }
        DYNSLog(@"token = %@",manager.requestSerializer.HTTPRequestHeaders);
        
        [manager DELETE:urlString parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            DYNSLog(@"responseObject = %@",responseObject);
            if (responseObject == nil) {
                return ;
            }
            if (_completion) {
                _completion(responseObject);
            }
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            DYNSLog(@"error = %@",error);
            
        }];
    }
}
@end
