//
//  NetWorkEntiry.m
//  JewelryApp
//
//  Created by kequ on 15/5/12.
//  Copyright (c) 2015年 jewelry. All rights reserved.
//

#import "NetWorkEntiry.h"
#import "JSONKit.h"

@implementation NetWorkEntiry

+ (void)loginWithUserName:(NSString *)userName password:(NSString *)password
                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
//    NSDictionary * dic = @{@"phone":userName,@"code":password};
//    NSString * urlStr = [NSString stringWithFormat:@"%@/login",KNETBASEURL];
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:urlStr parameters:dic success:success failure:failure];
}

+ (void)mofifyPassWord:(NSString *)pasWord
               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
//    NSMutableDictionary * dic = [self commonComonPar];
//    NSString * urlStr = [NSString stringWithFormat:@"%@/user/change_password",KNETBASEURL];
//    dic[@"password"] = pasWord;
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:urlStr parameters:dic success:success failure:failure];
}

#pragma mark - Upload | modify
@end
